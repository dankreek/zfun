import io

import pytest
import os.path as path

from zfun import ZMachineDictionary, get_header, ZMachineObjectTable


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


@pytest.fixture
def zork_v3_obj_table(zork1_v3_data: memoryview) -> ZMachineObjectTable:
    header = get_header(zork1_v3_data)
    yield ZMachineObjectTable(zork1_v3_data, header)


@pytest.fixture
def zork_v5_obj_table(zork1_v5_data: memoryview) -> ZMachineObjectTable:
    header = get_header(zork1_v5_data)
    yield ZMachineObjectTable(zork1_v5_data, header)


