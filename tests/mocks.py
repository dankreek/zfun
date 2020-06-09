from typing import List, Tuple
from zfun import ZMachineScreen, ZMachineStack, ZMachineInput


class MockScreen(ZMachineScreen):

    def __init__(self):
        self._printed_data: List[str] = []
        self._is_status_displayed = False

    def initialize(self, memory: memoryview, stack: ZMachineStack):
        pass

    def terminate(self):
        pass

    @property
    def dimensions(self) -> Tuple[int, int]:
        return 24, 80

    @property
    def upper_window_height(self) -> int:
        return 10

    @property
    def selected_window(self) -> int:
        return 1

    def print(self, text: str):
        self._printed_data.append(text)

    @property
    def is_status_displayed(self) -> bool:
        return self._is_status_displayed

    @is_status_displayed.setter
    def is_status_displayed(self, displayed: bool):
        self._is_status_displayed = displayed

    @property
    def printed_text(self) -> List[str]:
        """ List of text passed to the screen via the print() method. """
        return self._printed_data


class MockInput(ZMachineInput):

    def __init__(self, mock_reads: List[str] = None):
        if mock_reads is None:
            self._mock_reads = []
        else:
            # Reverse the list to pop from the beginning
            mock_reads.reverse()
            self._mock_reads = mock_reads

    def read_string(self, max_len: int) -> str:
        try:
            return self._mock_reads.pop()
        except IndexError:
            raise RuntimeError('Out of input')

