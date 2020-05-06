import curses
import textwrap
from enum import Enum
from abc import ABC, abstractmethod
from typing import Tuple, Union, Callable, List

from .header import ZCodeHeader, StatusLineType
from .variables import ZMachineVariables
from .objects import ObjectTable


class ColorCodes(Enum):
    BLACK = 2
    RED = 3
    GREEN = 4
    YELLOW = 5
    BLUE = 6
    MAGENTA = 7
    CYAN = 8
    WHITE = 9
    LIGHT_GREY = 10
    MEDIUM_GREY = 11
    DARK_GREY = 12


class ZMachineScreen(ABC):
    def __init__(self, header: ZCodeHeader, variables: ZMachineVariables, obj_table: ObjectTable):
        self._header = header
        self._variables = variables
        self._obj_table = obj_table

    # These guesses come from someone else's guesses! (just like most things known)
    # https://github.com/sussman/zvm/blob/master/zvm/zscreen.py#L14-L21
    STATUS_WIN = 1
    LOWER_WIN = 2

    @abstractmethod
    def initialize(self):
        """ Initialize the screen and set all screen capabilities in the header """
        pass

    @abstractmethod
    def terminate(self):
        """ Free up all resources use by the screen back to the environment. """
        pass

    @property
    @abstractmethod
    def dimensions(self) -> Tuple[int, int]:
        """ The height and width of the screen, measured in number of characters """
        pass

    @property
    @abstractmethod
    def upper_window_height(self) -> int:
        """ The current height of the upper window. If 0 then there is no upper window. """
        pass

    @upper_window_height.setter
    @abstractmethod
    def upper_window_height(self, height: int):
        """ Set the height of the upper windows """
        pass

    @property
    @abstractmethod
    def selected_window(self) -> int:
        """ The currently selected window number """
        pass

    @selected_window.setter
    @abstractmethod
    def selected_window(self, window_num: int):
        pass

    # XXX: remove this later and let the implementation handle it
    @abstractmethod
    def set_more_cb(self, more_cb: Callable):
        """ Set the [MORE] prompt callback.

        If the text is too long to fit in one page of the main window the [MORE] prompt is
        displayed, then the `more_cb` function is called which should just block until the
        user pressed a key, then return.

        :param more_cb:
        :return:
        """
        pass

    @abstractmethod
    def print(self, text: str):
        """ Print text to the selected window.

        :param text:
        """
        pass

    @property
    @abstractmethod
    def is_status_displayed(self) -> bool:
        """ Should the status bar be displayed? """
        pass

    @is_status_displayed.setter
    @abstractmethod
    def is_status_displayed(self, display_status: bool):
        pass

    @abstractmethod
    def read_string(self, max_len: int) -> str:
        """ Prompt the user for input and return it in the form of a string.

        :param max_len: The maximum length of input that should be accepted
        :return: The string the user typed.
        """
        pass


# XXX: Add pgup/pgdown functionality (only functioning during user input and not MORE prompt would make this easier)
class ZMachineCursesScreenV3(ZMachineScreen):

    def __init__(self, header: ZCodeHeader, variables: ZMachineVariables, obj_table: ObjectTable):
        super().__init__(header, variables, obj_table)

        # A history of every line sent to the main window, used for populating the back scroll
        self._main_win_history: List[str] = []

        # A copy of the text in _main_win_history broken up into
        # lines which are the length of the width of the current screen.
        # Will be re-written any time the screen is resized
        self._back_scroll: List[str] = []

        # Index into the back scroll indicating the last time the user was prompted for anything
        # to facilitate prompting the user for [MORE]
        self._last_prompt_idx = 0

        self._obj_name: str = ''
        self._global2: int = 0
        self._global3: int = 0

        self._is_status_displayed = False

        # Initialize curses
        self._std_scr = curses.initscr()
        self._screen_y, self._screen_x = self._std_scr.getmaxyx()

        # By default the [MORE] prompt just waits for a user to press any key via getch()
        self._more_cb = self._handle_more_prompt

    def _handle_more_prompt(self) -> bool:
        """ Get a character with getch and poll until a user strikes a key.

        If the screen is resized, handle that.

        :returns: True if [more] prompting should continue, False if not (in the case of a resize)
        """
        self._std_scr.addstr('[MORE]', curses.A_BOLD)
        self._std_scr.refresh()

        if self.is_status_displayed:
            self._draw_status_line()
            self._std_scr.refresh()

        got = -1
        while got == -1:
            got = self._std_scr.getch()

            if got == curses.KEY_RESIZE:
                self._handle_screen_resize()
                return False

        return True

    def initialize(self):
        # Standard curses initialization
        self._std_scr.clear()
        curses.noecho()     # don't echo keyboard input
        curses.cbreak()     # read keys without waiting for ENTER
        self._std_scr.keypad(True)  # return key codes as strings
        self._std_scr.scrollok(True)
        self._std_scr.idlok(True)

        # Timeout while waiting for keystrokes to check for screen resizing
        self._std_scr.timeout(10)

        self._std_scr.refresh()

        # Set header flags for this screen's capability in the z-machine
        if self._header.version == 3:
            # Set flags 1
            self._header.is_status_line_unavailable = False
            self._header.is_screen_splitting_available = True
            self._header.is_default_font_variable_width = False

            # Set flags 2
            self._header.is_transcription_on = False
        else:
            raise NotImplemented(f'Only version 3 stories are supported.')

    def set_more_cb(self, more_cb: Callable):
        self._more_cb = more_cb

    def _handle_screen_resize(self, append: str = None, attr: int = curses.A_NORMAL):
        # Re-apply the history to the back-scroll with the new screen dimensions
        curses.update_lines_cols()
        self._apply_history_to_back_scroll()
        self._redraw_screen()

        if append is not None:
            self._std_scr.addstr(append, attr)

        self._std_scr.refresh()

    @property
    def is_status_displayed(self) -> bool:
        return self._is_status_displayed

    @is_status_displayed.setter
    def is_status_displayed(self, status_displayed: bool):
        self._is_status_displayed = status_displayed
        self._draw_status_line()
        self._std_scr.refresh()

    @property
    def _main_win_height(self):
        return curses.LINES - (1 if self.is_status_displayed else 0)

    def print(self, text: str):
        orig_back_scroll_size = len(self._back_scroll)

        self._append_text_to_history(text)
        self._apply_history_to_back_scroll()

        if orig_back_scroll_size > 0:
            # reprint the last line, in the case where the line has been appended
            self._std_scr.addstr(curses.LINES-2, 0, self._back_scroll[orig_back_scroll_size-1])

        # Output each new line and allow for hardware scrolling
        for i in range(orig_back_scroll_size, len(self._back_scroll)):
            output_str = self._back_scroll[i]
            self._std_scr.addstr(curses.LINES-1, 0, output_str)

            # If an entire page of text has been sent since the last time a user was prompted, ask them to press a key
            if (i - self._last_prompt_idx) > (self._main_win_height - 3):
                if self._handle_more_prompt():
                    self._last_prompt_idx = i
                    self._std_scr.move(curses.LINES-1, 0)
                    self._std_scr.clrtoeol()
                else:
                    # The screen was resized so the rest of the text will have already been
                    # displayed to the user. The back-scroll buffer it totally different now
                    # so the user can just use pgup/pgdown to view anything they missed
                    self._reset_last_prompt()
                    return

        self._std_scr.refresh()

        if self._is_status_displayed:
            self._draw_status_line()
            self._std_scr.refresh()

    def _reset_last_prompt(self):
        """ Reset the last prompt index to be the very bottom of the back scroll """
        self._last_prompt_idx = len(self._back_scroll) - 1

    def _redraw_screen(self):
        """ Redraw the contents of the screen and refresh """
        self._std_scr.erase()

        self._redraw_main_win()

        if self.is_status_displayed:
            self._draw_status_line()

    def _draw_status_line(self):
        """ Draw the status line into the std_src but don't refresh """
        orig_y, orig_x = self._std_scr.getyx()

        if self._header.status_line_type == StatusLineType.SCORE_TURNS:
            score = self._variables.global_signed_val(1)
            turns = self._variables.global_val(2)

            status = f'Score: {score}/{turns}'
            status += ' ' * (19 - len(status))
        else:
            hours = self._variables.global_val(1)
            mins = self._variables.global_val(2)

            if hours < 12:
                day_part = 'am'
            else:
                day_part = 'pm'
                hours -= 12

            if hours == 0:
                hours = 12

            status = f'Time:{hours:>2}:{mins:02} {day_part}      '

        self._std_scr.move(0, 0)

        obj_name_len = curses.COLS - len(status) - 1
        obj_name = self._obj_table.object(self._variables.global_val(0)).properties.name
        if len(obj_name) > obj_name_len:
            # truncate object name if too long
            obj_name = obj_name[:obj_name_len-3] + '... '

        self._std_scr.addstr(obj_name, curses.A_REVERSE)
        self._std_scr.addstr(' ' * (curses.COLS - len(obj_name) - len(status)), curses.A_REVERSE)
        self._std_scr.addstr(status, curses.A_REVERSE)

        # move cursor back
        self._std_scr.move(orig_y, orig_x)

    def _redraw_main_win(self):
        bs_start_idx = len(self._back_scroll) - self._main_win_height

        if bs_start_idx < 0:
            # the back scroll is smaller than the main window height
            screen_start_line = abs(bs_start_idx)
            bs_start_idx = 0
        else:
            screen_start_line = curses.LINES - self._main_win_height

        self._std_scr.move(screen_start_line, 0)
        for i in range(bs_start_idx, len(self._back_scroll)):
            self._std_scr.addstr(self._back_scroll[i])

    def _append_text_to_history(self, text: str):
        """ add/append new lines to the main window history """
        for line in text.splitlines(keepends=True):
            # If the last line in the history didn't end with an endline, append this line to it
            if self._main_win_history and not self._main_win_history[-1].endswith('\n'):
                self._main_win_history[-1] += line
            else:
                self._main_win_history.append(line)

    def _apply_history_to_back_scroll(self):
        """ Break up the history into a list of word-wrapped lines which are the width of the screen """
        # TODO: Figure out an incremental way to do this if it becomes too slow
        self._back_scroll.clear()
        for line in self._main_win_history:
            if line == '\n':
                self._back_scroll.append(line)
            else:
                wrapped_text = textwrap.fill(line, width=curses.COLS)

                for wrapped_line in wrapped_text.splitlines(keepends=False):
                    # Only add an explicit endline if the line is shorter than the width of the screen,
                    # otherwise the screen will just wrap to the next line automatically
                    if len(wrapped_line) < curses.COLS:
                        wrapped_line += '\n'

                    self._back_scroll.append(wrapped_line)

                # If the original line doesn't end with an explicit newline, remove the one we added
                if line[-1] != '\n' and self._back_scroll[-1][-1] == '\n':
                    self._back_scroll[-1] = self._back_scroll[-1][:-1]

    @property
    def upper_window_height(self) -> Union[None, int]:
        raise NotImplemented('No upper window functionality in V3')

    @upper_window_height.setter
    def upper_window_height(self, height: int):
        raise NotImplemented('No upper window functionality in V3')

    @property
    def dimensions(self) -> Tuple[int, int]:
        return curses.LINES, curses.COLS

    @property
    def selected_window(self) -> int:
        return ZMachineScreen.LOWER_WIN

    @selected_window.setter
    def selected_window(self, window_num: int):
        raise NotImplemented('No upper window functionality in V3')

    def read_string(self, max_len: int) -> str:
        user_input = ''

        if self.is_status_displayed:
            self._draw_status_line()

        key_pressed = -1
        while key_pressed != ord('\n'):
            key_pressed = self._std_scr.getch()

            if key_pressed in [ord('\b'), curses.KEY_BACKSPACE]:
                if len(user_input) == 0:
                    curses.beep()
                else:
                    # Remove the last character typed from the accumulator and the screen
                    user_input = user_input[:-1]
                    orig_y, orig_x = self._std_scr.getyx()

                    new_x = orig_x - 1
                    if new_x < 0:
                        new_x = curses.COLS - 1
                        new_y = orig_y - 1
                    else:
                        new_y = orig_y

                    self._std_scr.addch(new_y, new_x, ' ')
                    self._std_scr.move(new_y, new_x)
            elif key_pressed == curses.KEY_RESIZE:
                self._handle_screen_resize(user_input)
            elif 32 <= key_pressed <= 126:
                # If the user has typed a regular key within the printable ASCII range
                if len(user_input) >= max_len:
                    curses.beep()
                else:
                    user_input += chr(key_pressed)
                    self._std_scr.addch(key_pressed)

        # Add the user input to the print history
        # (in case the screen gets resized or a viewable back scroll is implemented later)
        self.print(user_input + '\n')

        # Reset the [MORE] prompt index since the user has been prompted for input
        self._reset_last_prompt()

        return user_input

    def terminate(self):
        curses.nocbreak()
        self._std_scr.keypad(False)
        curses.echo()
        curses.endwin()

