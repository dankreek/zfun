import sys
import curses
import textwrap

from enum import Enum
from abc import ABC, abstractmethod
from typing import Tuple, Union, Callable, List

from .header import ZCodeHeader, StatusLineType


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
    def __init__(self, header: ZCodeHeader):
        self._header = header

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

    @abstractmethod
    def update_status(self, object_name: str = None, global2: int = None, global3: int = None):
        """ Update the status line.

        If parameters are not provided then they are acquired from game memory.

        :param object_name: Name of the object to display in the status line.
        :param global2: Value of 2nd global var
        :param global3: Value of 3rd global var
        """
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
    def read_string(self) -> str:
        """ Prompt the user for input and return it in the form of a string.

        :return: The string the user typed.
        """
        pass


class ZMachineCursesScreenV3(ZMachineScreen):

    MAX_INPUT_SIZE = 77  # So punk rock (also the limit for the 8 bit interpreters)

    def __init__(self, header: ZCodeHeader):
        super().__init__(header)

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

        # By default the [MORE] prompt just waits for a user to press any key via getch()
        self._more_cb = self._std_scr.getch

    def initialize(self):
        # Standard curses initialization
        self._std_scr.clear()
        curses.noecho()     # don't echo keyboard input
        curses.cbreak()     # read keys without waiting for ENTER
        self._std_scr.keypad(True)  # return key codes as strings
        self._std_scr.scrollok(True)
        self._std_scr.idlok(True)
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

    def _resize_windows(self):
        """ Resize the upper and main window to fit the current screen dimension and upper window size """
        pass

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
            self._std_scr.addstr(curses.LINES-2, 0, self._back_scroll[orig_back_scroll_size-1] + '\n')

        # Output each new line and allow for hardware scrolling
        for i in range(orig_back_scroll_size, len(self._back_scroll)):
            output_str = self._back_scroll[i]
            self._std_scr.addstr(curses.LINES-1, 0, output_str)

            # only add an end line if the line isn't as wide as the screen
            if len(output_str) < curses.COLS:
                self._std_scr.addch('\n')

            # If an entire page of text has been sent since the last time a user was prompted, ask them to press a key
            if (i - self._last_prompt_idx) > (self._main_win_height - 3):
                self._std_scr.addstr('[MORE]', curses.A_BOLD)
                self._std_scr.refresh()

                if self.is_status_displayed:
                    self._draw_status_line()
                    self._std_scr.refresh()

                # Ask the user to press a key
                if self._more_cb:
                    self._more_cb()

                self._last_prompt_idx = i
                self._std_scr.move(curses.LINES-1, 0)
                self._std_scr.clrtoeol()

        self._std_scr.refresh()

        if self._is_status_displayed:
            self._draw_status_line()
            self._std_scr.refresh()

    def _reset_last_prompt(self):
        """ Reset the last prompt index to be the very bottom of the back scroll """
        self._last_prompt_idx = len(self._back_scroll) - 1

    def _redraw_screen(self):
        """ Redraw the contents of the screen and refresh """
        if self.is_status_displayed:
            self._draw_status_line()

        self._draw_main_win()

        # Move cursor back to original position
        self._std_scr.refresh()

    def _draw_status_line(self):
        """ Draw the status line into the std_src but don't refresh """
        orig_y, orig_x = self._std_scr.getyx()

        if self._header.status_line_type == StatusLineType.SCORE_TURNS:
            # XXX: Make set_status accept bytes for globals
            # XXX: score should be a signed number - use int.from_bytes(byteorder='big', signed=True)
            status = f'Score: {self._global2}/{self._global3}'
            status += ' ' * (19 - len(status))
        else:
            if self._global2 < 12:
                daypart = 'am'
                hours = self._global2
            else:
                daypart = 'pm'
                hours = self._global2 - 12

            if hours == 0:
                hours = 12

            status = f'Time:{hours:>2}:{self._global3:02} {daypart}      '

        self._std_scr.move(0, 0)

        obj_name_len = curses.COLS - len(status) - 1
        if len(self._obj_name) > obj_name_len:
            # truncate object name if too long
            obj_name = self._obj_name[:obj_name_len-3] + '... '
        else:
            obj_name = self._obj_name

        self._std_scr.addstr(obj_name, curses.A_REVERSE)
        self._std_scr.addstr(' ' * (curses.COLS - len(self._obj_name) - len(status)), curses.A_REVERSE)
        self._std_scr.addstr(status, curses.A_REVERSE)

        # move cursor back
        self._std_scr.move(orig_y, orig_x)

    def _draw_main_win(self):
        bs_start_idx = len(self._back_scroll) - self._main_win_height

        if bs_start_idx < 0:
            # the back scroll is smaller than the main window height
            bs_start_idx = abs(bs_start_idx)
            screen_start_line = curses.LINES - len(self._back_scroll)
        else:
            screen_start_line = curses.LINES - self._main_win_height

        self._std_scr.move(screen_start_line, 0)
        for i in range(bs_start_idx, len(self._back_scroll)):
            text_line = self._back_scroll[i].rstrip()
            self._std_scr.addstr(text_line)
            # pad out spaces at end to overwrite anything previously on the screen
            self._std_scr.addstr(' ' * (curses.COLS - len(text_line)))

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
            if line.strip() == '':
                # textwrap will turn a blank line into an empty array
                self._back_scroll.append('')
            else:
                self._back_scroll += textwrap.wrap(line, width=curses.COLS)

    def update_status(self, object_name: str = None, global2: int = None, global3: int = None):
        # TODO: get strings from game memory once a global vars structure is created
        # XXX: Store these a bytes since global2 can be signed if it represents a score
        self._obj_name = object_name
        self._global2 = global2
        self._global3 = global3
        self._draw_status_line()

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

    def read_string(self) -> str:
        user_input = ''

        # Add an end-line so that the prompt starts on a blank line
        self.print('\n')

        # Drawing directly to the screen without adding to the back scroll so that
        # none of this will be stored until the user pressed ENTER
        self._std_scr.addstr('>')
        self._std_scr.refresh()

        if self.is_status_displayed:
            self._draw_status_line()

        key_pressed = None
        while key_pressed != '\n':
            key_pressed = self._std_scr.getkey()

            if key_pressed == 'KEY_BACKSPACE':
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
            elif (len(key_pressed) == 1) and (32 <= ord(key_pressed) <= 127):
                # If the user has typed a regular key within the printable ASCII range
                if len(user_input) >= self.MAX_INPUT_SIZE:
                    curses.beep()
                else:
                    user_input += key_pressed
                    self._std_scr.addch(key_pressed)

        # Add the user input to the print history
        # (in case the screen gets resized or a viewable back scroll is implemented later)
        self.print(f'>{user_input}\n')

        # Reset the [MORE] prompt index since the user has been prompted for input
        self._reset_last_prompt()

        return user_input

    def terminate(self):
        curses.nocbreak()
        self._std_scr.keypad(False)
        curses.echo()
        curses.endwin()

