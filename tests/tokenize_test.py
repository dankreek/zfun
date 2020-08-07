from typing import NamedTuple

from zfun import ZMachineDictionary, tokenize, ZWord
from zfun.util import write_asciiz


class TokenBlock(NamedTuple):
    dict_addr: int
    word_len: int
    text_pos: int


def read_token_block(memory: memoryview, parse_buf: int, token_num: int):
    block_offset = parse_buf + 2 + (token_num * 4)

    return TokenBlock(
        ZWord(memory, block_offset).unsigned_int,
        memory[block_offset + 2],
        memory[block_offset + 3]
    )


def test_tokenize(zork_v3_dict: ZMachineDictionary):
    text_buffer_addr = 0
    parse_buffer_addr = 256

    memory = memoryview(bytearray(b' ' * 512))

    # The games will set the maximum text-buffer size in the first byte of the text buffer
    memory[0] = 77

    # Games will set the max number of token blocks that can be stored at the beginning of the parse buffer
    memory[parse_buffer_addr] = 10

    write_asciiz(memory, 1, 'get,   lamp poop')

    tokenize(memory, zork_v3_dict, text_buffer_addr, parse_buffer_addr)

    assert memory[parse_buffer_addr + 1] == 4, 'The parse buffer should have marked that 4 tokens were parsed'

    token_block_0 = read_token_block(memory, parse_buffer_addr, 0)
    assert token_block_0.dict_addr == zork_v3_dict.entry_addr(252), 'correct address of the word `get` was found'
    assert token_block_0.text_pos == 1, 'correct position of the word `get` was found'
    assert token_block_0.word_len == 3, 'correct length of the word `get` was found'

    token_block_1 = read_token_block(memory, parse_buffer_addr, 1)
    assert token_block_1.dict_addr == zork_v3_dict.entry_addr(3), 'correct address of the comma was found'
    assert token_block_1.text_pos == 4, 'correct position of the comma was found'
    assert token_block_1.word_len == 1, 'correct length of the comma was found'

    token_block_2 = read_token_block(memory, parse_buffer_addr, 2)
    assert token_block_2.dict_addr == zork_v3_dict.entry_addr(336), 'correct address of the word `lamp` was found'
    assert token_block_2.text_pos == 8, 'correct position of the word `lamp` was found'
    assert token_block_2.word_len == 4, 'correct length of the word `lamp` was found'

    token_block_3 = read_token_block(memory, parse_buffer_addr, 3)
    assert token_block_3.dict_addr == 0, 'the word `poop` was correctly not found'
    assert token_block_3.text_pos == 13, 'correct position of the word `poop` was found'
    assert token_block_3.word_len == 4, 'correct length of the word `poop` was found'
