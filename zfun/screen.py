from enum import Enum
from abc import ABC, abstractmethod
from typing import Tuple

from .stack import ZMachineStack


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


