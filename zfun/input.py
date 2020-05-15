from abc import ABC, abstractmethod


class ZMachineInput(ABC):

    @abstractmethod
    def read_string(self, max_len: int) -> str:
        """ Prompt the user for input and return it in the form of a string.

        :param max_len: The maximum length of input that should be accepted
        :return: The string the user typed.
        """
        pass


