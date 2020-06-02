import pytest

from typing import Tuple

from mocks import MockInput, MockScreen
from zfun import ZCodeHeader, ZMachineInterpreter, ZMachineInterpreterV3, get_header


@pytest.fixture
def v3_header_and_data(zork1_v3_data: memoryview) -> Tuple[ZCodeHeader, memoryview]:
    header = get_header(zork1_v3_data)
    return header, zork1_v3_data


def test_some_stuff(v3_header_and_data: Tuple[ZCodeHeader, memoryview]):
    header, memory = v3_header_and_data
    screen = MockScreen()
    input = MockInput(['look'])

    interpreter = ZMachineInterpreterV3(header, memory, screen, input)
    interpreter.initialize()
    interpreter.run()

