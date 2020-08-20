from datetime import timedelta
from abc import ABC, abstractmethod
from typing import Optional


class ZMachineInput(ABC):

    @abstractmethod
    def read_string(self, max_len: int, max_time_s: Optional[timedelta] = None) -> str:
        """ Prompt the user for input and return it in the form of a string.

        :param max_len: The maximum length of input that should be accepted
        :param max_time_s: The maximum amount of time to wait for user input
        :return: The string the user typed.
        """
        pass

    @abstractmethod
    def read_char(self, max_time_s: Optional[int] = None) -> Optional[str]:
        """ Read a single character from the user.

        :param max_time_s: Maximum amount of time to wait for the user to press a key
        :return: The character the user typed or None if the user did not press a key in the specified time
        """
        pass

