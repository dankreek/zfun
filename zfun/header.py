from enum import Enum
from .util import read_word
from abc import ABC, abstractmethod

HEADER_SIZE = 64

class StatusLineType(Enum):
    SCORE_TURNS = 0
    HOURS_MINUTES = 1


class ZCodeHeader(ABC):
    def __init__(self, data):
        self._data = data

    @staticmethod
    def read_version(data) -> int:
        """ Read the Z-Machine version from a Z-Code data """
        return int(data[0])

    @property
    @abstractmethod
    def version(self) -> int:
        """ Get the Z-Machine version"""
        pass

    @property
    def status_line_type(self) -> StatusLineType:
        line_type_bit = self._data[1] and 0x02
        if line_type_bit == 0:
            return StatusLineType.SCORE_TURNS
        else:
            return StatusLineType.HOURS_MINUTES

    @property
    def release_number(self) -> int:
        return read_word(self._data, 2)

    @property
    def paged_memory_address(self) -> int:
        return read_word(self._data, 4)

    @property
    def first_instruction(self) -> int:
        return read_word(self._data, 6)


class ZCodeHeaderV2(ZCodeHeader):
    def __init__(self, data):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 2


class ZCodeHeaderV3(ZCodeHeader):
    def __init__(self, data):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 3


class ZCodeHeaderV5(ZCodeHeader):
    def __init__(self, data):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 5

def get_header(data: bytes):
    version = ZCodeHeader.read_version(data)

    if version == 2:
        return ZCodeHeaderV2(data)
    elif version == 3:
        return ZCodeHeaderV3(data)
    elif version == 5:
        return ZCodeHeaderV5(data)
    else:
        raise NotImplementedError(f'Support for version {version} not implemented')


def read_header(file: str) -> ZCodeHeader:
    """ Read the header of a z-code file and return them shits.

    :param file: Path to z-code file
    :return:
    """
    with open(file, 'rb') as f:
        data = f.read(HEADER_SIZE)
        return get_header(data)
