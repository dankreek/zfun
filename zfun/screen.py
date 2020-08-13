from enum import Enum
from abc import ABC, abstractmethod
from typing import Tuple


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


class TextStyle(Enum):
    ROMAN = 0
    REVERSE = 1
    BOLD = 2
    ITALIC = 4
    FIXED = 8


class ZMachineScreen(ABC):
    # These guesses come from someone else's guesses! (just like most things known)
    # https://github.com/sussman/zvm/blob/master/zvm/zscreen.py#L14-L21
    STATUS_WIN = 1
    LOWER_WIN = 2

    @abstractmethod
    def initialize(self, interpreter):
        """ Initialize the screen and set all screen capabilities in the game

        :param ZMachineInterpreter interpreter: Game interpreter
        """
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

    @abstractmethod
    def set_upper_window_height(self, height: int):
        """ Set the height of the upper windows """
        pass

    @abstractmethod
    def unsplit_screen(self):
        """ Remove upper window """
        pass

    @abstractmethod
    def set_style(self, style: TextStyle):
        """ Set the current text style, overwriting the current style """
        pass

    @abstractmethod
    def add_style(self, style: TextStyle):
        """ Add a new style in addition to the currently set styles """
        pass

    @property
    @abstractmethod
    def cursor_location(self) -> Tuple[int, int]:
        """ Return the cursor position of the selected window

        :returns: The current window's row number, column number
        """
        pass

    @abstractmethod
    def set_cursor_location(self, line_num: int, column_num: int):
        """ Set the cursor location of the current window

        Note that the first column and first row are indexed at 1

        :param line_num: Line number from top
        :param column_num: Column number from left
        """
        pass

    @abstractmethod
    def clear_all_windows(self):
        """ Clear the upper and lower windows"""
        pass

    @abstractmethod
    def clear_window(self, window_num: int):
        """ Clear the contents of the specified window

        :param window_num:
        """
        pass

    @abstractmethod
    def erase_to_eol(self):
        """ Erase the current line from the current column number to the end of the line. """
        pass

    @property
    @abstractmethod
    def selected_window(self) -> int:
        """ The currently selected window number """
        pass

    @abstractmethod
    def select_window(self, window_num: int):
        """ Select the window to write to

        :param window_num: Window number to select, 0 is lower window, 1 is upper window
        """
        pass

    @abstractmethod
    def print(self, text: str):
        """ Print text to the selected window.

        :param text:
        """
        pass

    def update_status(self):
        """ Manually update the status line.

        Note: This is only for V3 interpreters and in most cases probably does't need to be overridden.
        """
        pass

