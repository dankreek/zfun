from typing import Union


def read_word(memory: Union[bytes, memoryview], offset: int = None) -> int:
    """ Read an unsigned word value from bytes.

    :param memory: memory to read from
    :param offset: offset of the word inside of the memoryview, reads from start of memory if None
    :return: 16 bit word value located in memory at given offset
    """
    if offset is None:
        offset = 0

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


def write_signed_word(memory: memoryview, offset: int, value: int):
    """ Write a signed word value to a memoryview

    :param memory: memory to write to
    :param offset: offset of the word to write in the memory view
    :param value: Value to write, between 0 and 65,6535
    """
    assert -32768 <= value <= 32767

    byte_val = value.to_bytes(2, byteorder='big', signed=True)
    memory[offset] = byte_val[0]
    memory[offset+1] = byte_val[1]


def read_signed_word(memory: Union[bytes, memoryview], offset: int = None) -> int:
    """ Read a word as a signed integer from a memoryview

    :param memory: memory to read from
    :param offset: offset of the word inside of the memoryview, if None reads from first byte
    :return: signed integer word value located in memory at given offset
    """
    if offset is None:
        offset = 0

    return int.from_bytes(memory[offset:offset+2], byteorder='big', signed=True)


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


def signed_word(val: int) -> bytes:
    """ Return a 16-bit word containing a signed representation of val.

    :param val: Value to convert to a 16 bit word
    :return:
    """
    # To simulate underflow and overflow in a 16-bit machine, do all conversions at 32 and truncate
    big_val = val.to_bytes(4, 'big', signed=True)
    return big_val[2:]


def word(val: int) -> bytes:
    """ Return a 16-bit word containing an unsigned representation of val.

    :param val: Value to convert to a 16-bit word
    :return:
    """
    # To simulate underflow and overflow in a 16-bit machine, do all conversions at 32-bit and truncate
    big_val = val.to_bytes(2, 'big', signed=False)
    return big_val[2:]
