from itertools import zip_longest
from enum import Enum

from typing import List

from .util import is_bit_set, read_word

ABBREV_TBL_1 = 1
ABBREV_TBL_2 = 2
ABBREV_TBL_3 = 3
SHIFT_TO_A1 = 4
SHIFT_TO_A2 = 5
ZSCII_LITERAL = 6

a2_table = [
    -1, -1, -1, -1,
    -1, -1, -1, ord('\n'),
    ord('0'), ord('1'), ord('2'), ord('3'),
    ord('4'), ord('5'), ord('6'), ord('7'),
    ord('8'), ord('9'), ord('.'), ord(','),
    ord('!'), ord('?'), ord('_'), ord('#'),
    ord('\''), ord('"'), ord('/'), ord('\\'),
    ord('-'), ord(':'), ord('('), ord(')'),
]


class ZStringAlphabet(Enum):
    A0 = 0
    A1 = 1
    A2 = 2

    def ascii_char(self, zchar: int) -> int:
        """ Given a character in a Z-string alphabet, return its ASCII character

        :param zchar:
        :return:
        """
        assert zchar < 32, 'zchar value can not be greater than 31'

        if zchar == 0:
            # 0 is always a space in a Z-String
            return 0x20
        elif self == ZStringAlphabet.A0:
            return ord('a') + (zchar - 6)
        elif self == ZStringAlphabet.A1:
            return ord('A') + (zchar - 6)
        else:
            return a2_table[zchar]


def z_string_to_ascii(memory, str_offset: int, abbrev_table_offset: int = None) -> List[int]:
    """ Read a Z-String from memory (v3 or higher) and return a list of ascii character codes.

    :param memory:
    :param str_offset:
    :param abbrev_table_offset:
    :return: Z-String converted to ASCII character codes
    """
    state = dict(
        alphabet=ZStringAlphabet.A0,
        next_offset=str_offset,
        stop=False,
        zchars=None,
        zchars_idx=3,
        # list of ints containing ASCII characters
        abbrev_idx=None,
        # flag indicating that a literal ZSCII code is being read
        reading_zscii=False,
        # list of z-chars which make up the 10-bit ZSCII character code
        zscii_codes=None,
        # list of ASCII character codes to be output
        output=[]
    )

    while not (state['stop'] and (state['zchars_idx'] > 2)):
        # If all chars have been read from last word (or first iteration) read next word
        if state['zchars_idx'] > 2:
            next_offset = state['next_offset']+2

            # Read next 16 bit word containing 3 z-zchars
            zchar_word = memory[state['next_offset']:next_offset]

            # Split out each 5-bit Z-String char
            zchars = [None, None, None]
            zchars[0] = (zchar_word[0] & 0x7f) >> 2
            zchars[1] = (((zchar_word[0] & 0x03) << 3) & 0xff) | ((zchar_word[1] & 0xe0) >> 5)
            zchars[2] = (zchar_word[1] & 0x1f)

            state.update(
                zchars=zchars,
                zchars_idx=0,
                next_offset=next_offset,
                stop=is_bit_set(zchar_word, 0, 7)
            )

        zchar = state['zchars'][state['zchars_idx']]

        if state['reading_zscii']:
            state['zscii_codes'].append(zchar)

            if len(state['zscii_codes']) == 2:
                zscii_code = (state['zscii_codes'][0] << 5) | state['zscii_codes'][1]

                if 32 > zscii_code > 126:
                    raise RuntimeError(f'zscii code {zscii_code} can not be converted to ascii')

                state['output'].append(zscii_code)

                state.update(
                    alphabet=ZStringAlphabet.A0,
                    reading_zscii=False,
                    zscii_codes=None
                )
        elif state['abbrev_idx']:
            if abbrev_table_offset is None:
                # XXX: make a real exception
                raise RuntimeError('No abbrevition table supplied')
            else:
                full_abbrev_idx = ((state['abbrev_idx'] - 1) * 32) + zchar
                state['output'].extend(abbreviation_to_ascii(memory, abbrev_table_offset, full_abbrev_idx))
                state['abbrev_idx'] = None
        elif ABBREV_TBL_1 <= zchar <= ABBREV_TBL_3:
            if abbrev_table_offset is None:
                # XXX: make a real exception
                raise RuntimeError('No abbrevition table supplied')
            else:
                state['abbrev_idx'] = zchar
        elif zchar == SHIFT_TO_A1:
            state['alphabet'] = ZStringAlphabet.A1
        elif zchar == SHIFT_TO_A2:
            state['alphabet'] = ZStringAlphabet.A2
        elif (zchar == ZSCII_LITERAL) and (state['alphabet'] == ZStringAlphabet.A2):
            state.update(
                reading_zscii=True,
                zscii_codes=[]
            )
        else:
            # Convert Z-string char to a printable character using the current alphabet
            state['output'].append(state['alphabet'].ascii_char(zchar))
            # since this is a printable character set alphabet back to A0
            state['alphabet'] = ZStringAlphabet.A0

        # inc next index into zchars array for next iteration
        state['zchars_idx'] += 1

    return state['output']


def abbreviation_to_ascii(memory, abbrev_table_addr: int, abbrev_index: int) -> List[int]:
    """ Parse a z-string from the abbreviation table and return it.

    The abbreviation table is a contiguous list of 96 words (32 in version 2), each of which
    contains a word address pointing to a z-string in memory.

    A word address is a pointer to a word which is divided by 2.

    :param memory:
    :param abbrev_table_addr: Address of the abbreviation table
    :param abbrev_index: The abbreviation number to lookup.
    :return: List of ascii characters for the abbreviation
    """
    offset = abbrev_table_addr + (abbrev_index * 2)
    word_ptr = read_word(memory, offset) * 2
    return z_string_to_ascii(memory, word_ptr)


def z_string_to_str(memory, str_addr: int, abbrev_table_addr: int = None) -> str:
    """ Convert a z-string to a Python string.

    :param memory:
    :param str_addr:
    :param abbrev_table_addr:
    :return: Z-string converted to a Python string
    """
    return bytes(z_string_to_ascii(memory, str_addr, abbrev_table_addr)).decode('ascii')


def pack_z_chars(z_chars: List[int]) -> List[int]:
    """ Given a list of z-chars pack them into a properly terminated z-string.

    This function packs all the 5-bit z-chars into a list of 8-bit bytes, and
    adds the terminator bit to the 15th bit of the last word.

    :param z_chars:
    :return: Terminated z-string
    """
    # Put all characters in groups of 3, using 0x04 as a padding character
    # XXX: add constants for control z-chars
    groups = zip_longest(*([iter(z_chars)] * 3), fillvalue=4)
    output = []

    for group in groups:
        output.append(((group[0] << 2) & 0xff) | (group[1] >> 3))
        output.append(((group[1] << 5) & 0xff) | group[2])

    # set termination bit on last word
    hi_byte_i = len(output) - 2
    output[hi_byte_i] = output[hi_byte_i] + 0x80

    return output


def z_string(pystring: str) -> bytes:
    """ Convert a Python string into a Z-string """
    z_chars = []

    for char in pystring:
        if ord('a') <= ord(char) <= ord('z'):
            # Alphabet A0 (lowercase)
            z_chars.append(ord(char) - ord('a') + 6)
        elif ord('A') <= ord(char) <= ord('Z'):
            # Alphabet A1 (uppercase)
            z_chars += [SHIFT_TO_A1, ord(char) - ord('A') + 6]
        else:
            # Alphabet A2 (symbols and digits)
            try:
                char_idx = a2_table.index(ord(char))
                z_chars += [SHIFT_TO_A2, char_idx]
            except ValueError:
                if 32 <= ord(char) <= 126:
                    # Two z-chars after 6 are the high 5 bits and low 5 bits of the ascii code
                    ascii_code = ord(char)
                    z_chars += [SHIFT_TO_A2, ZSCII_LITERAL, ascii_code >> 5, ascii_code & 0x1f]
                else:
                    raise ValueError(f'Could not translate char "{char}" into z-string char')

    output = pack_z_chars(z_chars)
    return bytes(output)

