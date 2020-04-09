import enum
import io
from abc import ABC, abstractmethod
from typing import Union

from .util import read_word, set_bit, is_bit_set
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


class InterpreterNumber(enum.Enum):
    DEC_SYSTEM_20 = 1
    APPLE_2E = 2
    MAC = 3
    AMIGA = 4
    ATARI_ST = 5
    IBM_PC = 6
    COMMODORE_128 = 7
    COMMODORE_64 = 8
    APPLE_2C = 9
    APPLE_2GS = 10
    TANDY_COLOR = 11


class ZMachineColor(enum.Enum):
    BLACK = 2
    RED = 3
    GREEN = 4
    YELLOW = 5
    BLUE = 6
    MAGENTA = 7
    CYAN = 8
    WHITE = 9


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

    # Flags 1 for versions 1-3
    @property
    def status_line_type(self) -> StatusLineType:
        raise UnsupportedVersionError(f'status_line_type not supported in version {self.version}')

    @property
    def is_file_split(self) -> bool:
        raise UnsupportedVersionError(f'is_file_split not supported in version {self.version}')

    @is_file_split.setter
    def is_file_split(self, is_censored: bool):
        raise UnsupportedVersionError(f'is_file_split not supported in version {self.version}')

    @property
    def is_status_line_unavailable(self) -> bool:
        raise UnsupportedVersionError(f'is_status_line_unavailable not supported in version {self.version}')

    @is_status_line_unavailable.setter
    def is_status_line_unavailable(self, is_unavailable: bool):
        raise UnsupportedVersionError(f'is_status_line_unavailable not supported in version {self.version}')

    @property
    def is_screen_splitting_available(self) -> bool:
        raise UnsupportedVersionError(f'is_screen_splitting_available not supported in version {self.version}')

    @is_screen_splitting_available.setter
    def is_screen_splitting_available(self, is_available: bool):
        raise UnsupportedVersionError(f'is_screen_splitting_available not supported in version {self.version}')

    @property
    def is_default_font_variable_width(self) -> bool:
        raise UnsupportedVersionError(f'is_default_font_variable_width not supported in version {self.version}')

    @is_default_font_variable_width.setter
    def is_default_font_variable_width(self, is_var_width: bool):
        raise UnsupportedVersionError(f'is_default_font_variable_width not supported in version {self.version}')

    # Flags 1 for version 4+
    @property
    def is_color_available(self) -> bool:
        raise UnsupportedVersionError(f'is_color_available not supported in version {self.version}')

    @is_color_available.setter
    def is_color_available(self, is_color_supported: bool):
        raise UnsupportedVersionError(f'is_color_available not supported in version {self.version}')

    @property
    def is_picture_display_available(self) -> bool:
        raise UnsupportedVersionError(f'is_picture_display_available not supported in version {self.version}')

    @is_picture_display_available.setter
    def is_picture_display_available(self, pics_available: bool):
        raise UnsupportedVersionError(f'is_picture_display_available not supported in version {self.version}')

    @property
    def is_bold_style_available(self):
        raise UnsupportedVersionError(f'is_bold_style_available not supported in version {self.version}')

    @is_bold_style_available.setter
    def is_bold_style_available(self, bold_available: bool):
        raise UnsupportedVersionError(f'is_bold_style_available not supported in version {self.version}')

    @property
    def is_italic_style_available(self) -> bool:
        raise UnsupportedVersionError(f'is_italic_style_available not supported in version {self.version}')

    @is_italic_style_available.setter
    def is_italic_style_available(self, emphasis_available: bool):
        raise UnsupportedVersionError(f'is_italic_style_available not supported in version {self.version}')

    @property
    def is_fixed_style_available(self) -> bool:
        raise UnsupportedVersionError(f'is_fixed_style_available not supported in version {self.version}')

    @is_fixed_style_available.setter
    def is_fixed_style_available(self, fixed_available: bool):
        raise UnsupportedVersionError(f'is_fixed_style_available not supported in version {self.version}')

    @property
    def is_sound_available(self) -> bool:
        raise UnsupportedVersionError(f'is_sound_available not supported in version {self.version}')

    @is_sound_available.setter
    def is_sound_available(self, sound_available: bool):
        raise UnsupportedVersionError(f'is_sound_available not supported in version {self.version}')

    @property
    def is_timed_keyboard_input_available(self) -> bool:
        raise UnsupportedVersionError(f'is_timed_keyboard_input_available not supported in version {self.version}')

    @is_timed_keyboard_input_available.setter
    def is_timed_keyboard_input_available(self, timed_input: bool):
        raise UnsupportedVersionError(f'is_timed_keyboard_input_available not supported in version {self.version}')

    @property
    def high_memory_address(self) -> int:
        return read_word(self._view, 4)

    # These next two occupy the same word depending on version
    @property
    def initial_pc_value(self) -> int:
        return read_word(self._view, 6)

    @property
    def initial_main_routine_address(self) -> int:
        raise UnsupportedVersionError(f'initial_main_route_address is not supported in version {self.version}')

    @property
    def dictionary_address(self) -> int:
        return read_word(self._view, 8)

    @property
    def object_table_address(self) -> int:
        return read_word(self._view, 0x0a)

    @property
    def global_var_table_address(self) -> int:
        return read_word(self._view, 0x0c)

    @property
    def static_memory_address(self) -> int:
        return read_word(self._view, 0x0e)

    # Flags 2
    @property
    def is_transcription_on(self) -> bool:
        return is_bit_set(self._view, 0x10, 0)

    @is_transcription_on.setter
    def is_transcription_on(self, transcription_on: bool):
        set_bit(self._view, 0x10, 0, transcription_on)

    @property
    def is_fixed_width_forced(self) -> bool:
        raise UnsupportedVersionError(f'is_fixed_width_forced is not supported in version {self.version}')

    @is_fixed_width_forced.setter
    def is_fixed_width_forced(self, force_fixed_width: bool):
        raise UnsupportedVersionError(f'is_fixed_width_forced is not supported in version {self.version}')

    @property
    def req_status_line_redraw(self) -> bool:
        raise UnsupportedVersionError(f'req_status_line_redraw is not supported in version {self.version}')

    @req_status_line_redraw.setter
    def req_status_line_redraw(self, redraw: bool):
        raise UnsupportedVersionError(f'req_status_line_redraw is not supported in version {self.version}')

    @property
    def want_to_use_pictures(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_pictures is not supported in version {self.version}')

    @want_to_use_pictures.setter
    def want_to_use_pictures(self, use_pictures: bool):
        raise UnsupportedVersionError(f'want_to_use_pictures is not supported in version {self.version}')

    @property
    def want_to_use_undo_opcodes(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_undo_opcodes is not supported in version {self.version}')

    @want_to_use_undo_opcodes.setter
    def want_to_use_undo_opcodes(self, use_undo: bool):
        raise UnsupportedVersionError(f'want_to_use_undo_opcodes is not supported in version {self.version}')

    @property
    def want_to_use_mouse(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_mouse is not supported in version {self.version}')

    @want_to_use_mouse.setter
    def want_to_use_mouse(self, use_mouse: bool):
        raise UnsupportedVersionError(f'want_to_use_mouse is not supported in version {self.version}')

    @property
    def want_to_use_colors(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_colors is not supported in version {self.version}')

    @want_to_use_colors.setter
    def want_to_use_colors(self, use_colors: bool):
        raise UnsupportedVersionError(f'want_to_use_colors is not supported in version {self.version}')

    @property
    def want_to_use_sound_effects(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_sound_effects is not supported in version {self.version}')

    @want_to_use_sound_effects.setter
    def want_to_use_sound_effects(self, use_colors: bool):
        raise UnsupportedVersionError(f'want_to_use_sound_effects is not supported in version {self.version}')

    @property
    def want_to_use_menus(self) -> bool:
        raise UnsupportedVersionError(f'want_to_use_menus is not supported in version {self.version}')

    @want_to_use_menus.setter
    def want_to_use_menus(self, use_colors: bool):
        raise UnsupportedVersionError(f'want_to_use_menus is not supported in version {self.version}')

    @property
    def serial_code(self) -> Union[str, bytes]:
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
        raise UnsupportedVersionError(f'file_length is not supported by version {self.version}')

    @property
    def file_checksum(self) -> int:
        raise UnsupportedVersionError(f'checksum is not supported by version {self.version}')

    @property
    def interpreter_number(self) -> InterpreterNumber:
        raise UnsupportedVersionError(f'interpreter_number is not supported by version {self.version}')

    @interpreter_number.setter
    def interpreter_number(self, number: InterpreterNumber):
        raise UnsupportedVersionError(f'interpreter_number is not supported by version {self.version}')

    @property
    def interpreter_version(self) -> Union[str, int]:
        raise UnsupportedVersionError(f'interpreter_version is not supported by version {self.version}')

    @interpreter_version.setter
    def interpreter_version(self, version: Union[str, int]):
        raise UnsupportedVersionError(f'interpreter_version is not supported by version {self.version}')

    @property
    def screen_height(self) -> int:
        raise UnsupportedVersionError(f'screen_height is not supported by version {self.version}')

    @screen_height.setter
    def screen_height(self, height: int):
        raise UnsupportedVersionError(f'screen_height is not supported by version {self.version}')

    @property
    def screen_width(self) -> int:
        raise UnsupportedVersionError(f'screen_width is not supported by version {self.version}')

    @screen_width.setter
    def screen_width(self, height: int):
        raise UnsupportedVersionError(f'screen_width is not supported by version {self.version}')

    @property
    def font_height(self) -> int:
        raise UnsupportedVersionError(f'font_height is not supported by version {self.version}')

    @font_height.setter
    def font_height(self, height: int):
        raise UnsupportedVersionError(f'font_height is not supported by version {self.version}')

    @property
    def font_width(self) -> int:
        raise UnsupportedVersionError(f'font_width is not supported by version {self.version}')

    @font_width.setter
    def font_width(self, height: int):
        raise UnsupportedVersionError(f'font_width is not supported by version {self.version}')

    @property
    def routines_offset(self) -> int:
        raise UnsupportedVersionError(f'routines_offset is not supported by version {self.version}')

    @property
    def static_strings_offset(self) -> int:
        raise UnsupportedVersionError(f'static_strings_offset is not supported by version {self.version}')

    @property
    def default_background_color(self) -> ZMachineColor:
        raise UnsupportedVersionError(f'default_background_color is not supported by version {self.version}')

    @default_background_color.setter
    def default_background_color(self, color: ZMachineColor):
        raise UnsupportedVersionError(f'default_background_color is not supported by version {self.version}')

    @property
    def default_foreground_color(self) -> ZMachineColor:
        raise UnsupportedVersionError(f'default_foreground_color is not supported by version {self.version}')

    @default_foreground_color.setter
    def default_foreground_color(self, color: ZMachineColor):
        raise UnsupportedVersionError(f'default_foreground_color is not supported by version {self.version}')

    @property
    def terminating_chars_table_address(self) -> int:
        raise UnsupportedVersionError(f'terminating_chars_table_address is not supported by version {self.version}')

    @property
    def output_stream3_text_width(self) -> int:
        raise UnsupportedVersionError(f'output_stream3_text_width is not supported by version {self.version}')

    @output_stream3_text_width.setter
    def output_stream3_text_width(self, text_width: int):
        raise UnsupportedVersionError(f'output_stream3_text_width is not supported by version {self.version}')

    @property
    def std_rev_number(self) -> int:
        return read_word(self._view, 0x32)

    @property
    def alt_char_set_address(self) -> int:
        raise UnsupportedVersionError(f'alt_char_set_address is not supported by version {self.version}')

    @property
    def extension_table_address(self) -> int:
        raise UnsupportedVersionError(f'extension_table_address is not supported by version {self.version}')


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
        if is_bit_set(self._view, 1, 1):
            return StatusLineType.SCORE_TURNS
        else:
            return StatusLineType.HOURS_MINUTES

    @property
    def is_file_split(self) -> bool:
        return is_bit_set(self._view, 1, 2)

    @is_file_split.setter
    def is_file_split(self, is_split: bool):
        set_bit(self._view, 1, 2, is_split)

    @property
    def is_status_line_unavailable(self) -> bool:
        return is_bit_set(self._view, 1, 4)

    @is_status_line_unavailable.setter
    def is_status_line_unavailable(self, available: bool):
        set_bit(self._view, 1, 4, available)

    @property
    def is_screen_splitting_available(self) -> bool:
        return is_bit_set(self._view, 1, 5)

    @is_screen_splitting_available.setter
    def is_screen_splitting_available(self, screen_splitting: bool):
        set_bit(self._view, 1, 5, screen_splitting)

    @property
    def is_default_font_variable_width(self) -> bool:
        return is_bit_set(self._view, 1, 6)

    @is_default_font_variable_width.setter
    def is_default_font_variable_width(self, var_width: bool):
        set_bit(self._view, 1, 6, var_width)

    @property
    def is_fixed_width_forced(self) -> bool:
        return is_bit_set(self._view, 0x10, 1)

    @is_fixed_width_forced.setter
    def is_fixed_width_forced(self, forced: bool):
        set_bit(self._view, 0x10, 1, forced)

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
        raise UnsupportedVersionError(f'status_line_type is not supported in version {self.version}')

    @property
    def is_censored_mode(self) -> bool:
        raise UnsupportedVersionError(f'is_censored_mode is not available in version {self.version}')

    @is_censored_mode.setter
    def is_file_split(self, is_split: bool):
        raise UnsupportedVersionError(f'is_censored_mode is not available in version {self.version}')


class ZCodeHeaderV5(ZCodeHeaderV4):
    def __init__(self, data: io.BytesIO):
        super().__init__(data)

    @property
    def version(self) -> int:
        return 5

    @property
    def terminating_chars_table_address(self) -> int:
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
    def initial_pc_value(self) -> int:
        raise UnsupportedVersionError(f'initial_pc_value not supported in version {self.version}, use initial_main_routine_address')

    @property
    def initial_main_routine_address(self) -> int:
        # XXX: return the unpacked address
        pass

    @property
    def file_length(self) -> int:
        length = read_word(self._view, 0x1a)
        return length * 8

    @property
    def routines_offset(self) -> int:
        return read_word(self._view, 0x28) * 8

    @property
    def static_strings_offset(self) -> int:
        return read_word(self._view, 0x2a) * 8


# XXX: make up better names for read_header and get_header
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
