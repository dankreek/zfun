import curses
import textwrap

from zfun import ZMachineInterpreter, ZMachineInput, ZMachineScreen, ZCodeHeader, ZMachineVariables, ZMachineObjectTable, StatusLineType
from typing import List, Union, Tuple


class ZMachineCursesScreenV3(ZMachineScreen, ZMachineInput):

    def __init__(self):
        self._header = Union[ZCodeHeader, None]
        self._variables = Union[ZMachineVariables, None]
        self._obj_table = Union[ZMachineObjectTable, None]

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

    def initialize(self, interpreter: ZMachineInterpreter):
        self._header = interpreter.header
        self._variables = interpreter.variables
        self._obj_table = interpreter.object_table

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
            # Some earlier games don't explicitly turn on the status line
            if self._header.serial_code in ['840726']:
                self.is_status_displayed = True

            # Set flags 1
            self._header.is_status_line_unavailable = False
            self._header.is_screen_splitting_available = True
            self._header.is_default_font_variable_width = False

            # Set flags 2
            self._header.is_transcription_on = False
        else:
            raise NotImplemented(f'Only version 3 stories are supported.')

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

    def _print_backscroll_line(self, line: str):
        if len(line.rstrip()) == curses.COLS:
            line = line.rstrip()

        self._std_scr.addstr(curses.LINES-1, 0, line)

    def print(self, text: str):
        orig_back_scroll_size = len(self._back_scroll)
        if orig_back_scroll_size > 0:
            is_last_line_finished = self._back_scroll[-1][-1] == '\n'
        else:
            is_last_line_finished = False

        self._append_text_to_history(text)
        self._apply_history_to_back_scroll()

        if not is_last_line_finished:
            # reprint the last line, in the case where the line has been appended
            self._print_backscroll_line(self._back_scroll[orig_back_scroll_size-1])

        # Output each new line and allow for hardware scrolling
        for i in range(orig_back_scroll_size, len(self._back_scroll)):
            self._print_backscroll_line(self._back_scroll[i])

            # If an entire page of text has been sent since the last time a user was prompted, ask them to press a key
            if self._back_scroll[i].endswith('\n') and ((i - self._last_prompt_idx + 2) > self._main_win_height):
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
            score = self._variables.global_val(1).int
            turns = self._variables.global_val(2).unsigned_int

            status = f'Score: {score}/{turns}'
            status += ' ' * (19 - len(status))
        else:
            hours = self._variables.global_val(1).unsigned_int
            mins = self._variables.global_val(2).unsigned_int

            if hours < 12:
                day_part = 'am'
            else:
                day_part = 'pm'
                hours -= 12

            if hours == 0:
                hours = 12

            status = f'Time:{hours:>2}:{mins:02} {day_part}      '

        self._std_scr.move(0, 0)

        if self._variables.global_val(0).unsigned_int > 0:
            obj_name_len = curses.COLS - len(status) - 1
            obj_name = self._obj_table.object(self._variables.global_val(0).unsigned_int).properties.name
            if len(obj_name) > obj_name_len:
                # truncate object name if too long
                obj_name = obj_name[:obj_name_len-3] + '... '
        else:
            obj_name = ''

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
                if line.lstrip() == '':
                    # If this line only contains spaces, just leave it as is
                    wrapped_text = line
                else:
                    wrapped_text = textwrap.fill(line, width=curses.COLS-1)

                for wrapped_line in wrapped_text.splitlines(keepends=False):
                    wrapped_line += '\n'
                    self._back_scroll.append(wrapped_line)

                # If the original line doesn't end with an explicit newline, remove the one we added
                if line[-1] != '\n':
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
            elif key_pressed == curses.KEY_PPAGE:
                # TODO: implement back scroll view
                self._enter_view_back_scroll()
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

    def _enter_view_back_scroll(self):
        pass

    def terminate(self):
        curses.nocbreak()
        self._std_scr.keypad(False)
        curses.echo()
        curses.endwin()

