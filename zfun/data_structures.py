from itertools import zip_longest
from enum import Enum

from .util import is_bit_set

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
        """ Convert a character in a Z-string alphabet to an ASCII character

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


def parse_z_string(memory, str_offset: int, abbrev_table_offset: int = None) -> str:
    """ Read a Z-String from memory (v3 or higher)

    :param memory:
    :param str_offset:
    :param abbrev_table_offset:
    :return: Z-String converted to Python string
    """
    state = dict(
        alphabet=ZStringAlphabet.A0,
        next_offset=str_offset,
        stop=False,
        zchars=None,
        zchars_idx=3,
        # list of ints containing ASCII characters
        output=[],
        abbrev_idx=None,
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
            zchars[1] = ((zchar_word[0] & 0x03) << 3) | ((zchar_word[1] & 0xe0) >> 5)
            zchars[2] = (zchar_word[1] & 0x1f)

            state.update(
                zchars=zchars,
                zchars_idx=0,
                next_offset=next_offset,
                stop=is_bit_set(zchar_word, 0, 7)
            )

        zchar = state['zchars'][state['zchars_idx']]

        if state['abbrev_idx']:
            full_abbrev_idx = state['abbrev_idx'] + zchar
            # XXX: do a recursive call for abbreviation but leave abbrev_table_offset at None
            state['abbrev_idx'] = None
            raise NotImplemented('abbreviations not yet supported')
        elif 1 <= zchar <= 3:
            state['abbrev_idx'] = zchar
            raise NotImplemented('abbreviations not yet supported')
        elif zchar == 4:
            state['alphabet'] = ZStringAlphabet.A1
        elif zchar == 5:
            state['alphabet'] = ZStringAlphabet.A2
        elif (zchar == 6) and (state['alphabet'] == ZStringAlphabet.A2):
            raise NotImplemented('literal ZSCII characters not yet supported')
        else:
            # Convert Z-string char to a printable character using the current alphabet
            state['output'].append(state['alphabet'].ascii_char(zchar))
            # since this is a printable character set alphabet back to A0
            state['alphabet'] = ZStringAlphabet.A0

        # inc next index into zchars array for next iteration
        state['zchars_idx'] += 1

    return bytes(state['output']).decode('ascii')


def z_string(pystring: str) -> bytes:
    """ Convert a Python string into a Z-string """
    z_chars = []

    for char in pystring:
        if ord('a') <= ord(char) <= ord('z'):
            # Alphabet A0 (lowercase)
            z_chars.append(ord(char) - ord('a') + 6)
        elif ord('A') <= ord(char) <= ord('Z'):
            # Alphabet A1 (uppercase)
            z_chars.append(4)
            z_chars.append(ord(char) - ord('A') + 6)
        else:
            # Alphabet A2 (symbols and digits)
            try:
                char_idx = a2_table.index(ord(char))
                z_chars.append(5)
                z_chars.append(char_idx)
            except ValueError:
                raise ValueError(f'Could not translate char "{char}" into z-string char')

    # Put all characters in groups of 3, using 0x04 as a padding character
    groups = zip_longest(*([iter(z_chars)] * 3), fillvalue=4)

    output = []
    for group in groups:
        output.append((group[0] << 2) + (group[1] >> 3))
        output.append((group[1] << 5) + group[2])

    # set termination bit on last word
    hi_byte_i = len(output) - 2
    output[hi_byte_i] = output[hi_byte_i] + 0x80

    # pack the z_chars into a byte array and return it
    return bytes(output)

