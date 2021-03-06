from typing import List, Union, NamedTuple

from .dictionary import ZMachineDictionary
from .data_structures import ZWord, ZByte


class WordAndOffset(NamedTuple):
    word: str
    offset: int
    next_offset: int


def _next_word(memory: memoryview, word_separators: List[int], offset: int) -> Union[None, WordAndOffset]:
    """ Read the next word from the text buffer and return it along ith the offset to the next word.

    :param memory:
    :param word_separators:
    :param offset:
    :return: Word and offset to next word, or None if there is no next word. If the word is an empty string, then no
             word was found at the given offset so continue iterating
    """
    if memory[offset] in word_separators:
        # If this is a word separator just return it by itself
        return WordAndOffset(chr(memory[offset]), offset, offset + 1)
    elif memory[offset] == 0:
        # Noooo mooorrree wooorrddsss
        return None

    word = ''
    i = offset
    while True:
        if (memory[i] in word_separators) or (memory[i] == 0):
            # The word separator will be the next word so retain the offset
            return WordAndOffset(word, offset, i)
        if memory[i] == ord(' '):
            # Spaces are not considered words so return the offset to the next word
            return WordAndOffset(word, offset, i + 1)
        else:
            word += chr(memory[i])
            i += 1


def tokenize(memory: memoryview, dictionary: ZMachineDictionary, text_buffer: int, parse_buffer: int):
    """ Tokenize the string in the text buffer into the token buffer

    :param memory: Memory to read words and write tokens to
    :param dictionary: Dictionary to read words and word-separators from
    :param text_buffer: Offset of the text-buffer
    :param parse_buffer: Offset of the parse-buffer
    """
    # The max number of words is stored in the first byte of the the parse-buffer
    max_tokens = memory[parse_buffer]
    token_i = 0

    word_offset = _next_word(memory, dictionary.word_separators, text_buffer + 1)
    while (word_offset is not None) and (token_i < max_tokens):
        if len(word_offset.word) > 0:
            dict_word_addr = dictionary.lookup_word(word_offset.word)
            num_letters = len(word_offset.word)
            block_offset = parse_buffer + 2 + (token_i * 4)

            ZWord.from_unsigned_int(dict_word_addr).write(memory, block_offset)
            ZByte.from_unsigned_int(num_letters).write(memory, block_offset+2)
            ZByte.from_unsigned_int(word_offset.offset - text_buffer).write(memory, block_offset+3)

            token_i += 1

        word_offset = _next_word(memory, dictionary.word_separators, word_offset.next_offset)

    # Write the number of tokens parsed into byte 1 of the parse buffer
    ZByte.from_unsigned_int(token_i).write(memory, parse_buffer + 1)

