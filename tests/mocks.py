from typing import List, Tuple, Optional
from datetime import timedelta
from zfun import ZMachineScreen, ZMachineInterpreter, ZMachineInput
from zfun.screen import TextStyle


class MockScreen(ZMachineScreen):

    def __init__(self):
        self._printed_data: List[str] = []

    def initialize(self, interpreter: ZMachineInterpreter):
        interpreter._memory[1] = 0x20

    def terminate(self):
        pass

    @property
    def dimensions(self) -> Tuple[int, int]:
        return 24, 80

    @property
    def upper_window_height(self) -> int:
        return 0

    @property
    def selected_window(self) -> int:
        return 1

    def print(self, text: str):
        self._printed_data.append(text)

    @property
    def printed_text(self) -> List[str]:
        """ List of text passed to the screen via the print() method. """
        return self._printed_data

    def set_upper_window_height(self, height: int):
        pass

    def set_style(self, style: TextStyle):
        pass

    def add_style(self, style: TextStyle):
        pass

    @property
    def cursor_location(self) -> Tuple[int, int]:
        return 0, 0

    def set_cursor_location(self, line_num: int, column_num: int):
        pass

    def clear_all_windows(self):
        pass

    def clear_window(self, window_num: int):
        pass

    def erase_to_eol(self):
        pass

    def select_window(self, window_num: int):
        pass

    def flush_buffer(self):
        pass


class MockInput(ZMachineInput):

    def __init__(self, mock_reads: List[str] = None):
        if mock_reads is None:
            self._mock_reads = []
        else:
            # Reverse the list to pop from the beginning
            mock_reads.reverse()
            self._mock_reads = mock_reads

    def read_string(self, max_len: int, max_time_s: Optional[timedelta] = None) -> str:
        try:
            return self._mock_reads.pop()
        except IndexError:
            raise RuntimeError('Out of input')

    def read_char(self, max_time_s: Optional[int] = None) -> str:
        return ''


