import curses
from enum import Enum
from abc import ABC, abstractmethod
from typing import Tuple, Union, Callable

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
    def print_main_win(self, text: str, more_cb: Callable = None):
        """ Print text to the main window.

        If the text is too long to fit in one page of the main window the [MORE] prompt is
        displayed, then the `more_cb` function is called which should just block until the
        user pressed a key, then return.

        :param text:
        :param more_cb:
        """
        pass


class ZMachineCursesScreen(ZMachineScreen):

    def __init__(self, header: ZCodeHeader):
        super().__init__(header)

        self._std_scr = curses.initscr()
        self._std_scr.scrollok(True)
        self._upper_win_height = 0
        self._selected_window = 0

        # Curses windows
        self._status_win: Union[None, curses._CursesWindow] = None
        self._upper_win: Union[None, curses._CursesWindow] = None
        self._main_win: Union[None, curses._CursesWindow] = None

    def initialize(self):
        self._upper_win_height = 0

        # curses.update_lines_cols()
        curses.noecho()     # don't echo keyboard input
        curses.cbreak()     # read keys without waiting for ENTER
        self._std_scr.keypad(True)  # return key codes as strings
        self._std_scr.refresh()

        if self._header.version == 3:
            # Set flags 1
            self._header.is_status_line_unavailable = False
            self._header.is_screen_splitting_available = True
            self._header.is_default_font_variable_width = False

            # Set flags 2
            self._header.is_transcription_on = False
        else:
            raise NotImplemented(f'Only version 3 stories are supported.')

        self._status_win = curses.newwin(1, curses.COLS+1, 0, 0)
        self._status_win.bkgd(' ', curses.A_REVERSE)

        self._main_win = self._create_main_win()

        # Refresh the screen
        # self._std_scr.refresh()
        self._main_win.refresh()

    @staticmethod
    def _create_main_win():
        main_win = curses.newwin(curses.LINES - 1, curses.COLS, 1, 0)
        main_win.scrollok(True)

        # Setup main window
        # self._main_win.move(curses.LINES - self._upper_win_height - 2, 0)

        # for _ in range(curses.LINES - 1):
        #     main_win.addch('\n')

        return main_win

    def _resize_windows(self):
        """ Resize the upper and main window to fit the current screen dimension and upper window size """
        self._main_win.resize(curses.LINES - 1 - self._upper_win_height, curses.COLS + 1)

        if self._upper_win_height > 0:
            self._upper_win.resize(self._upper_win_height, curses.COLS + 1)

        # XXX: Does this refresh every window on the screen?
        self._std_scr.refresh()

    def print_main_win(self, text: str, more_cb: Callable = None):
        # XXX: add [MORE] functionality
        self._main_win.addstr(text)
        self._main_win.refresh()

    @property
    def std_scr(self):
        return self._std_scr

    @property
    def main_win(self):
        return self._main_win

    def update_status(self, object_name: str = None, global2: int = None, global3: int = None):
        # TODO: get strings from game memory once a global vars structure is created

        if self._header.status_line_type == StatusLineType.SCORE_TURNS:
            status = f' Score: {global2:<7} Moves: {global3:<5} '
        else:
            if global2 < 12:
                daypart = 'am'
                hours = global2
            else:
                daypart = 'pm'
                hours = global2 - 12

            if hours == 0:
                hours = 12

            status = f'Time: {hours:>2}:{global3:02} {daypart:<5} '

        self._status_win.erase()
        self._status_win.addstr(0, 1, object_name)
        self._status_win.addstr(0, curses.COLS - len(status), status)
        self._status_win.refresh()

    @property
    def upper_window_height(self) -> Union[None, int]:
        return self._upper_win_height

    @upper_window_height.setter
    def upper_window_height(self, height: int):
        # XXX: called when split_window instruction happens, handle all inits required
        self._upper_win_height = height

    @property
    def dimensions(self) -> Tuple[int, int]:
        return curses.LINES, curses.COLS

    @property
    def selected_window(self) -> int:
        return self._selected_window

    def terminate(self):
        curses.nocbreak()
        self._std_scr.keypad(False)
        curses.echo()
        curses.endwin()

