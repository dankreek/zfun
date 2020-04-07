from enum import Enum

from .util import is_bit_set


class ZStringAlphabet(Enum):
    A0 = 0
    A1 = 1
    A2 = 2

    a2_table = [
        0, 0, 0, 0,
        0, 0, 0, ord('\n'),
        ord('0'), ord('1'), ord('2'), ord('3'),
        ord('4'), ord('5'), ord('6'), ord('7'),
        ord('8'), ord('9'), ord('.'), ord(','),
        ord('!'), ord('?'), ord('_'), ord('#'),
        ord('\''), ord('"'), ord('/'), ord('\\'),
        ord('-'), ord(':'), ord('('), ord(')'),
    ]

    def char(self, zchar: int) -> int:
        """ Convert a character in a Z-string alphabet to an ASCII character

        :param zchar:
        :return:
        """
        assert(zchar < 32, 'zchar value can not be greater than 31')

        if zchar == 0:
            # 0 is always a space in a Z-String
            return 0x20
        elif self == ZStringAlphabet.A0:
            return ord('a') + (zchar - 6)
        elif self == ZStringAlphabet.A1:
            return ord('A') + (zchar - 6)
        else:
            return ZStringAlphabet.a2_table[zchar]


def read_z_string(memory, str_offset: int, abbrev_table_offset: int) -> str:
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
        output=[]
    )

    while not (state['stop'] and (state['zchars_idx'] > 2)):
        # If all chars have been read from last word (or first iteration) read next word
        if state['zchars_idx'] > 2:
            next_offset = state['next_offset']+2

            # Read next word containing 3 z-zchars
            zchar_word = memory[state['next_offset']:next_offset]

            # Split out each 5-bit Z-String char
            zchars = [None, None, None]
            zchars[0] = (zchar_word[0] and 0x7f) >> 2
            zchars[1] = ((zchar_word[0] and 0x03) << 3) and ((zchar_word[1] and 0xe0) >> 5)
            zchars[2] = (zchar_word[1] and 0x1f)

            state.update(
                zchars=zchars,
                zchars_idx=0,
                next_offset=next_offset,
                stop=is_bit_set(zchar_word, 0, 7)
            )

        # Shift out current zchar from zchars word
        # mask off left bits and shift right X number of bits
        zchar = state['zchars'][state['zchars_idx']]

        if zchar == 4:
            state['alphabet'] = ZStringAlphabet.A1
        elif zchar == 5:
            state['alphabet'] = ZStringAlphabet.A2
        else:
            # Convert Z-string char to a printable character using the current alphabet
            state['output'].append(state['alphabet'].char(zchar))
            # if character is printable set alphabet back to A0
            state['alphabet'] = ZStringAlphabet.A0

        # inc next index into zchars word for next iteration
        state['zchars_idx'] += 1

    return bytes(state['output']).decode('ascii')

