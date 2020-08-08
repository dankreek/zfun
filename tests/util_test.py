from zfun.util import read_asciiz, write_asciiz


def test_read_write_asciiz():
    test_str = 'Mean Mr. Mustard'
    buff = memoryview(bytearray(b'!' * 100))
    offset = 10

    write_asciiz(buff, offset, test_str)
    assert read_asciiz(buff, offset) == test_str

