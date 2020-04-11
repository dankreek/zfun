import io
import pytest
import os.path as path


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
    yield _file_memorybuffer('zork1.z3')

