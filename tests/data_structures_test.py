import pytest

from zfun import ZByte, ZWord, ZMachineIllegalOperation


def test_instantiating_zbyte():
    zb = ZByte(bytes.fromhex('12'))
    assert zb.bytes == b'\x12', 'Instantiate ZByte from bytes'

    zb = ZByte(memoryview(bytes.fromhex('42')))
    assert zb.bytes == b'\x42', 'Instantiate ZByte from memoryview'

    zb = ZByte.from_int(-1)
    assert zb.bytes == b'\xff', 'Instantiate ZByte from int'

    zb = ZByte.from_unsigned_int(0xf0)
    assert zb.bytes == b'\xf0', 'Instantiate ZByte from unsigned int'

    with pytest.raises(TypeError):
        ZByte(22)

    with pytest.raises(ValueError):
        ZByte(b'\x12\x34')

    with pytest.raises(ValueError):
        ZByte(b'')

    with pytest.raises(ValueError):
        ZByte.from_int(-129)

    with pytest.raises(ValueError):
        ZByte.from_int(128)

    with pytest.raises(ValueError):
        ZByte.from_unsigned_int(-1)

    with pytest.raises(ValueError):
        ZByte.from_unsigned_int(256)


def test_zbyte_to_zbyte_math():
    zb = ZByte.from_int(0) + ZByte.from_int(12)
    assert zb.bytes == b'\x0c', 'ZByte + ZByte'

    zb = ZByte.from_int(0) - ZByte.from_int(1)
    assert zb.bytes == b'\xff', 'ZByte - ZByte'

    zb = ZByte.from_int(-128) - ZByte.from_int(1)
    assert zb.bytes == b'\x7f', 'Zbyte arithmetic truncation'

    zb = ZByte.from_int(-2) * ZByte.from_int(8)
    assert zb.int == -16, 'ZByte * ZByte'

    zb = ZByte.from_int(127) * ZByte.from_int(127)
    assert zb.bytes == b'\x01', 'ZByte multiplication truncation'

    zb = ZByte.from_int(3) // ZByte.from_int(2)
    assert zb.bytes == b'\x01', 'ZByte integer division'

    with pytest.raises(ZMachineIllegalOperation, match='Divide by zero'):
        ZByte.from_int(45) // ZByte.from_int(0)

    with pytest.raises(ZMachineIllegalOperation):
        zb.from_int(4) / zb.from_int(8)

    zb = ZByte(b'\x01').inc()
    assert zb.bytes == b'\x02'

    zb = ZByte(b'\xff').inc()
    assert zb.bytes == b'\x00', 'Rollover on increment'

    zb = ZByte.from_int(0).dec()
    assert zb.int == -1

    zb = ZByte(b'\x00').dec()
    assert zb.bytes == b'\xff', 'Rollover on decrement'

    zb = ZByte.from_int(127) % ZByte.from_int(2)
    assert zb.int == 1

    zb = ZByte.from_int(-128) % ZByte.from_int(2)
    assert zb.int == 0


def test_zbyte_bitwise_operations():
    zb = ZByte.from_unsigned_int(0b1010_1010) << 1
    assert zb.unsigned_int == 0b0101_0100

    zb = ZByte.from_unsigned_int(0b0000_1111) << 4
    assert zb.unsigned_int == 0b1111_0000

    zb = ZByte.from_unsigned_int(0b1111_0000) >> 4
    assert zb.unsigned_int == 0b0000_1111

    zb = ZByte.from_unsigned_int(0b0001_0000) >> 1
    assert zb.unsigned_int == 0b0000_1000

    zb = ZByte.from_unsigned_int(0b1111_1111) & 0b0101_0101
    assert zb.bytes == b'\x55'

    zb = ZByte.from_unsigned_int(0b1111_0000) | 0b0000_1111
    assert zb.bytes == b'\xff'

    zb = ~ZByte.from_unsigned_int(0b0101_0101)
    assert zb.unsigned_int == 0b1010_1010

    zb = ~ZByte.from_unsigned_int(0b0000_1111)
    assert zb.unsigned_int == 0b1111_0000

    zb = ZByte.from_unsigned_int(0b1010_1100)
    assert zb.is_bit_set(7) is True
    assert zb.is_bit_set(0) is False
    assert zb.is_bit_set(3) is True
    assert zb.is_bit_clear(7) is False
    assert zb.is_bit_clear(0) is True
    assert zb.is_bit_clear(3) is False

    assert ZByte.from_int(1) == ZByte(b'\x01')
    assert ZByte.from_int(42) != ZByte(b'\x01')


def test_zbyte_read_and_write_memory(zork1_v3_data: memoryview):
    zb = ZByte.read(zork1_v3_data, 0)
    assert zb.int == 3

    ZByte.from_int(42).write(zork1_v3_data, 0)
    assert zork1_v3_data[0] == 42


def test_zbyte_to_zword_math():
    zw = ZByte.from_int(0) + ZWord.from_int(256)
    assert zw.bytes == b'\x01\x00', 'ZByte + ZWord'

    zw = ZByte.from_int(0) - ZWord.from_int(129)
    assert zw.int == -129, 'ZByte - ZWord'

    zw = ZByte.from_int(-2) * ZWord.from_int(128)
    assert zw.int == -256, 'ZByte * ZWord'

    zw = ZByte.from_int(126) // ZWord.from_int(2)
    assert zw.int == 63, 'ZByte/ZWord integer division'

    with pytest.raises(ZMachineIllegalOperation, match='Divide by zero'):
        ZByte.from_int(45) // ZWord.from_int(0)

    with pytest.raises(ZMachineIllegalOperation):
        ZByte.from_int(4) / ZWord.from_int(8)

    zw = ZByte.from_int(127) % ZWord.from_int(2)
    assert zw.int == 1

    zw = ZByte.from_int(-128) % ZWord.from_int(2)
    assert zw.int == 0

def test_instantiate_zword():
    zw = ZWord(bytes.fromhex('1234'))
    assert zw.bytes == b'\x12\x34', 'Instantiate ZWord from bytes'

    zw = ZWord(memoryview(bytes.fromhex('4242')))
    assert zw.bytes == b'\x42\x42', 'Instantiate ZWord from memoryview'

    zw = ZWord.from_int(-1)
    assert zw.bytes == b'\xff\xff', 'Instantiate ZWord from int'

    zw = ZWord.from_unsigned_int(0xf0f0)
    assert zw.bytes == b'\xf0\xf0', 'Instantiate ZWord from unsigned int'

    with pytest.raises(TypeError):
        ZWord(22)

    with pytest.raises(ValueError):
        ZWord(b'\x12\x34\x69')

    with pytest.raises(ValueError):
        ZWord(b'\x12')

    with pytest.raises(ValueError):
        ZWord(b'')

    with pytest.raises(ValueError):
        ZWord.from_int(-32769)

    with pytest.raises(ValueError):
        ZWord.from_int(32768)

    with pytest.raises(ValueError):
        ZWord.from_unsigned_int(-1)

    with pytest.raises(ValueError):
        ZWord.from_unsigned_int(65536)


def test_zword_zword_math():
    zw = ZWord.from_int(0) + ZWord.from_int(512)
    assert zw.bytes == b'\x02\x00', 'ZWord + ZWord'

    zw = ZWord.from_int(0) - ZWord.from_int(1)
    assert zw.bytes == b'\xff\xff', 'ZWord - ZWord'

    zw = ZWord.from_int(-32768) - ZWord.from_int(1)
    assert zw.bytes == b'\x7f\xff', 'ZWord arithmetic truncation'

    zw = ZWord.from_int(-2) * ZWord.from_int(8)
    assert zw.int == -16, 'ZWord * ZWord'

    zw = ZWord.from_int(32767) * ZWord.from_int(32767)
    assert zw.bytes == b'\x00\x01', 'ZWord multiplication truncation'

    zw = ZWord.from_int(3) // ZWord.from_int(2)
    assert zw.bytes == b'\x00\x01', 'ZWord integer division'

    with pytest.raises(ZMachineIllegalOperation, match='Divide by zero'):
        ZWord.from_int(45) // ZWord.from_int(0)

    with pytest.raises(ZMachineIllegalOperation):
        ZWord.from_int(4) / ZWord.from_int(8)

    zw = ZWord(b'\x00\x01').inc()
    assert zw.bytes == b'\x00\x02'

    zw = ZWord(b'\xff\xfe').inc()
    assert zw.bytes == b'\xff\xff'

    zw = ZWord(b'\xff\xff').inc()
    assert zw.bytes == b'\x00\x00', 'Rollover on increment'

    zw = ZWord.from_int(500).dec()
    assert zw.int == 499

    zw = ZWord(b'\xff\xff').dec()
    assert zw.bytes == b'\xff\xfe'

    zw = ZWord(b'\x00\x00').dec()
    assert zw.bytes == b'\xff\xff', 'Rollover on decrement'

    zw = ZWord.from_int(32767) % ZWord.from_int(2)
    assert zw.int == 1

    zw = ZWord.from_int(-32768) % ZWord.from_int(2)
    assert zw.int == 0


def test_zword_bitwise_operations():
    zw = ZWord.from_unsigned_int(0b1010_1010_1010_1010) << 1
    assert zw.unsigned_int == 0b0101_0101_0101_0100

    zw = ZWord.from_unsigned_int(0b0000_1111_0000_1111) << 4
    assert zw.unsigned_int == 0b1111_0000_1111_0000

    zw = ZWord.from_unsigned_int(0b0000_1111_1111_0000) >> 4
    assert zw.unsigned_int == 0b0000_0000_1111_1111

    zw = ZWord.from_unsigned_int(0b0001_0000) >> 1
    assert zw.unsigned_int == 0b0000_1000

    zw = ZWord.from_unsigned_int(0b1111_1111) & 0b0101_0101
    assert zw.unsigned_int == 0b0101_0101

    zw = ZWord.from_unsigned_int(0b1111_0000) | 0b0000_1111
    assert zw.bytes == b'\x00\xff'

    zw = ~ZWord.from_unsigned_int(0b0101_0101)
    assert zw.unsigned_int == 0b1111_1111_1010_1010

    zw = ~ZWord.from_unsigned_int(0b0000_1111)
    assert zw.unsigned_int == 0b1111_1111_1111_0000

    zw = ZWord.from_unsigned_int(0b1111_0000_1111_0000)
    assert zw.is_bit_set(15) is True
    assert zw.is_bit_set(0) is False
    assert zw.is_bit_set(4) is True
    assert zw.is_bit_clear(15) is False
    assert zw.is_bit_clear(0) is True
    assert zw.is_bit_clear(4) is False

    assert ZWord.from_int(-1) == ZWord(b'\xff\xff')
    assert ZWord.from_int(-1) != ZWord(b'\x00\x00')


def test_zword_read_and_write_memory(zork1_v3_data: memoryview):
    zw = ZWord.read(zork1_v3_data, 6)
    assert zw.unsigned_int == 0x4f05

    ZWord.from_unsigned_int(0x4269).write(zork1_v3_data, 6)
    assert zork1_v3_data[6:8] == b'\x42\x69'


def test_zword_to_zbyte_math():
    zw = ZWord.from_int(129) + ZByte.from_int(127)
    assert zw.bytes == b'\x01\x00', 'ZWord + ZByte'

    zw = ZWord.from_int(0) - ZByte.from_int(127)
    assert zw.int == -127, 'ZWord - ZByte'

    zw = ZWord.from_int(-4) * ZByte.from_int(64)
    assert zw.int == -256, 'ZWord * ZByte'

    zw = ZWord.from_int(126) // ZByte.from_int(2)
    assert zw.int == 63, 'ZWord/ZByte integer division'

    with pytest.raises(ZMachineIllegalOperation, match='Divide by zero'):
        ZWord.from_int(45) // ZByte.from_int(0)

    with pytest.raises(ZMachineIllegalOperation):
        ZWord.from_int(4) / ZByte.from_int(8)


