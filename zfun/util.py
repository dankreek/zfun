def read_word(memory: memoryview, offset: int):
    """ Read a word value from a memoryview.

    :param memory: memory to read from
    :param offset: offset of the word inside of the memoryview
    :return: 16 bit word value located in memory at given offset
    """
    return (memory[offset] << 8) | memory[offset+1]


def write_word(memory: memoryview, offset: int, value: int):
    """ Write an unsigned word value to a memoryview.

    :param memory: memory to write to
    :param offset: offset of the word to write in the memory view
    :param value: Value to write, between 0 and 65,6535
    """
    assert 0 <= value <= 65535

    memory[offset] = value >> 8
    memory[offset + 1] = value & 0xff


def set_bit(memory: memoryview, offset: int, bit_num: int, is_set: bool):
    """ Set a bit in a byte inside of a memoryview

    :param memory: memory container
    :param offset: offset from beginning of memoryview in bytes
    :param bit_num: bit number to set
    :param is_set: True if but should be set to 1, False if it should be st to 0
    """
    if is_set:
        memory[offset] = memory[offset] | (1 << bit_num)
    else:
        memory[offset] = memory[offset] & ~(1 << bit_num)


def is_bit_set(memory: memoryview, offset: int, bit_num: int) -> bool:
    """ Is a bit in the memory view set?

    :param memory: memory container
    :param offset: offset from the beginning of memoryview in bytes
    :param bit_num: bit number to test
    :return: True if the bit is set, False if not
    """
    return (memory[offset] & (1 << bit_num)) != 0
