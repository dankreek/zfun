from typing import Union


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


def read_asciiz(memory: Union[memoryview, bytes], offset: int) -> str:
    """ Read a 0-terminated ascii string from memory

    :param memory: Memory to read from
    :param offset: Offset to start reading string from
    :return: The string read from memory
    """
    string = ''

    for i in range(offset, len(memory)):
        if memory[i] == 0:
            return string
        else:
            string += chr(memory[i])

    return string


def write_asciiz(memory: memoryview, offset: int, string: str):
    """ Write a 0-terminated ascii string to memory

    :param memory: Memory to write to
    :param offset: Offset in memory to write to
    :param string: String to write
    """
    asciiz = [ord(char) for char in string]
    asciiz.append(0)

    memory[offset:offset + len(asciiz)] = bytes(asciiz)


