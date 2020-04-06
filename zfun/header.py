import enum
import io
from abc import ABC, abstractmethod

from .util import read_word
from .exc import UnsupportedVersionError

HEADER_SIZE = 64


class StatusLineType(enum.Enum):
    SCORE_TURNS = 0
    HOURS_MINUTES = 1

    def __str__(self):
        if self == StatusLineType.SCORE_TURNS:
            return 'SCORE/TURNS'
        else:
            return 'HOURS/MINUTES'


class ZCodeHeader(ABC):
    def __init__(self, data: io.BytesIO):
        self._view = data.getbuffer()

    @staticmethod
    def read_version(data: bytes) -> int:
        """ Read the Z-Machine version from a Z-Code data """
        return int(data[0])

    @property
    @abstractmethod
    def version(self) -> int:
        """ Get the Z-Machine version"""
        pass

    @property
    def status_line_type(self) -> StatusLineType:
        raise UnsupportedVersionError(f'Not supported in version {self.version}')

    @property
    def release_number(self) -> int:
        return read_word(self._view, 2)

    @property
    def paged_memory_address(self) -> int:
        return read_word(self._view, 4)

    @property
    def first_instruction(self) -> int:
        return read_word(self._view, 6)

    @property
    def dictionary_address(self) -> int:
        return read_word(self._view, 8)

    @property
    def object_table_address(self) -> int:
        return read_word(self._view, 0x0a)

    @property
    def global_vars_address(self) -> int:
        return read_word(self._view, 0x0c)

    @property
    def static_memory_address(self) -> int:
        return read_word(self._view, 0x0e)

    @property
    def serial_code(self) -> str:
        code_bytes = bytes(self._view[0x12:0x18])
        try:
            return code_bytes.decode('ascii')
        except UnicodeDecodeError:
            # Zork1 v2 doesn't seem to have this info, maybe all v2's don't?
            return code_bytes

    @property
    def abbreviations_table_address(self) -> int:
        return read_word(self._view, 0x18)

    @property
    def file_length(self) -> int:
        """ Get the length of the file in bytes """
        raise UnsupportedVersionError(f'file_length not supported by version {self.version}')

    @property
    def file_checksum(self) -> int:
        raise UnsupportedVersionError(f'checksum not supported by version {self.version}')

    @property
    def routines_offset(self) -> int:
        raise UnsupportedVersionError(f'routines_offset not supported by version {self.version}')

    @property
    def string_offset(self) -> int:
        raise UnsupportedVersionError(f'string_offset not supported by version {self.version}')

    @property
    def terminating_chars_table(self) -> int:
        raise UnsupportedVersionError(f'terminating_chars_table not supported by version {self.version}')

    @property
    def alt_char_set_address(self) -> int:
        raise UnsupportedVersionError(f'alt_char_set_address not supported by version {self.version}')

    @property
    def extension_table_address(self) -> int:
        raise UnsupportedVersionError(f'extension_table_address not supported by version {self.version}')


class ZCodeHeaderV2(ZCodeHeader):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 2


class ZCodeHeaderV3(ZCodeHeaderV2):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 3

    @property
    def status_line_type(self) -> StatusLineType:
        line_type_bit = self._view[1] and 0x02
        if line_type_bit == 0:
            return StatusLineType.SCORE_TURNS
        else:
            return StatusLineType.HOURS_MINUTES

    @property
    def file_length(self) -> int:
        length = read_word(self._view, 0x1a)
        return length * 2

    @property
    def file_checksum(self) -> int:
        return read_word(self._view, 0x1c)


class ZCodeHeaderV4(ZCodeHeaderV3):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 4

    @property
    def file_length(self) -> int:
        length = read_word(self._view, 0x1a)
        return length * 4

    @property
    def status_line_type(self) -> StatusLineType:
        raise UnsupportedVersionError(f'status_line_type not supported in version {self.version}')


class ZCodeHeaderV5(ZCodeHeaderV4):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 5

    @property
    def terminating_chars_table(self) -> int:
        return read_word(self._view, 0x2e)

    @property
    def alt_char_set_address(self) -> int:
        return read_word(self._view, 0x34)

    @property
    def extension_table_address(self) -> int:
        return read_word(self._view, 0x36)


class ZCodeHeaderV6(ZCodeHeaderV5):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 6

    @property
    def file_length(self) -> int:
        length = read_word(self._view, 0x1a)
        return length * 8

    @property
    def routines_offset(self) -> int:
        return read_word(self._view, 0x28) * 8

    @property
    def string_offset(self) -> int:
        return read_word(self._view, 0x2a) * 8


def get_header(data: bytes):
    version = ZCodeHeader.read_version(data)
    bytes_io = io.BytesIO(data)

    if version == 2:
        return ZCodeHeaderV2(bytes_io)
    elif version == 3:
        return ZCodeHeaderV3(bytes_io)
    elif version == 4:
        return ZCodeHeaderV4(bytes_io)
    elif version == 5:
        return ZCodeHeaderV5(bytes_io)
    elif version == 6:
        return ZCodeHeaderV6(bytes_io)
    else:
        raise UnsupportedVersionError(f'Support for version {version} not implemented')


def read_header(file: str) -> ZCodeHeader:
    """ Read the header of a z-code file and return them shits.

    :param file: Path to z-code file
    :return:
    """
    with open(file, 'rb') as f:
        data = f.read(HEADER_SIZE)
        return get_header(data)
