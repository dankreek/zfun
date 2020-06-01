import io
from typing import Tuple, List

import pytest
import os.path as path

from zfun import ZMachineDictionary, get_header, ZMachineScreen, ZMachineInput, ZMachineStack


class MockScreen(ZMachineScreen):

    def __init__(self):
        self._printed_data: List[str] = []

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
        return False

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
            # Return empty string if nothing left to output
            return ''


def _file_memorybuffer(file_name: str):
    file_path = path.join(path.dirname(__file__), file_name)
    with open(file_path, 'rb') as f:
        io_buf = io.BytesIO(f.read())
        return io_buf.getbuffer()


@pytest.fixture
def zork1_v3_data() -> memoryview:
    yield _file_memorybuffer('zork1.z3')


@pytest.fixture
def zork1_v5_data() -> memoryview:
    yield _file_memorybuffer('zork1.z5')


@pytest.fixture
def zork_v5_dict(zork1_v5_data: memoryview) -> ZMachineDictionary:
    header = get_header(zork1_v5_data)
    yield ZMachineDictionary(zork1_v5_data, header)


@pytest.fixture
def zork_v3_dict(zork1_v3_data: memoryview) -> ZMachineDictionary:
    header = get_header(zork1_v3_data)
    yield ZMachineDictionary(zork1_v3_data, header)


