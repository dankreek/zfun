def read_word(memory: memoryview, offset: int):
    """ Read a word value from a memoryview.

    :param memory: memory to read from
    :param offset: offset of the word inside of the memoryview
    :return: 16 bit word value located in memory at given offset
    """
    return int(memory[offset]) * 256 + int(memory[offset+1])


def set_bit(memory: memoryview, offset: int, bit_num: int, is_set: bool):
    """ Set a bit in a byte inside of a memoryview

    :param memory: memory container
    :param offset: offset from beginning of memoryview in bytes
    :param bit_num: bit number to set
    :param is_set: True if but should be set to 1, False if it should be st to 0
    """
    if is_set:
        memory[offset] = bytes([memory[offset] or (1 << bit_num)])
    else:
        memory[offset] = bytes([memory[offset] and ~(1 << bit_num)])


def is_bit_set(memory: memoryview, offset: int, bit_num: int) -> bool:
    """ Is a bit in the memory view set?

    :param memory: memory container
    :param offset: offset from the beginning of memoryview in bytes
    :param bit_num: bit number to test
    :return: True if the bit is set, False if not
    """
    return (memory[offset] and (1 << bit_num)) != 0
