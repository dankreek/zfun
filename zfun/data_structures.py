from abc import ABC, abstractmethod
from typing import Union

from .exc import ZMachineIllegalOperation


class ZData(ABC):

    def __init__(self, value: bytes):
        self._value: bytes = value

    def __repr__(self):
        return f'<{type(self).__name__} {self.__str__()}>'

    def __str__(self):
        return f'0x{self._value.hex()}'

    def __len__(self):
        return len(self._value)

    @abstractmethod
    def __eq__(self, other):
        """ Bitwise equivalence comparison.

        :param other:
        :return: True if the bit widths and set bits are the same
        """
        pass

    @abstractmethod
    def __add__(self, other):
        pass

    @abstractmethod
    def __sub__(self, other):
        pass

    @abstractmethod
    def __mul__(self, other):
        pass

    @abstractmethod
    def __floordiv__(self, other):
        pass

    @abstractmethod
    def __lshift__(self, other):
        pass

    @abstractmethod
    def __rshift__(self, other):
        pass

    @abstractmethod
    def __and__(self, other):
        pass

    @abstractmethod
    def __or__(self, other):
        pass

    @abstractmethod
    def __invert__(self):
        pass

    @abstractmethod
    def __mod__(self, other):
        pass

    def __truediv__(self, other):
        raise ZMachineIllegalOperation('Can not true-divide ZData')

    def hex(self) -> str:
        """ Get the value of ZData as a hex string. """
        return self._value.hex()

    @abstractmethod
    def write(self, memory: memoryview, address: int):
        """ Write ZData to memory at the provided address.

        :param memory: Memory to write to
        :param address: Address in memory to write to
        """
        pass

    @staticmethod
    @abstractmethod
    def from_int(value: int):
        """ Return ZData from a signed int

        :param value: Int value to convert to ZData
        :return:
        """
        pass

    @staticmethod
    @abstractmethod
    def from_unsigned_int(value: int):
        """ Return ZData from an unsigned int

        :param value: Unsigned int value to convert to ZData
        :return:
        """
        pass

    @property
    def bytes(self) -> bytes:
        """ Data value as a Python byte string"""
        return self._value

    @property
    def int(self) -> int:
        """ Value of data as a signed integer """
        return int.from_bytes(self._value, 'big', signed=True)

    @property
    def unsigned_int(self) -> int:
        """ Value of data as an unsigned integer """
        return int.from_bytes(self._value, 'big', signed=False)

    @abstractmethod
    def inc(self, amount: int = 1):
        """ Increment the value (unsigned addition) by the specified amount.

        :return: New ZData with incremented value
        """
        pass

    @abstractmethod
    def dec(self, amount: int = 1):
        """ Decrement the value (unsigned subtraction) by the specified amount.

        :return: New ZData with decremented value
        """
        pass

    @abstractmethod
    def is_bit_set(self, bit_number: int) -> bool:
        """ Test if the specified bit number is set.

        :param bit_number: Bit number to test
        :return: True if the bit is 1
        """
        pass

    def is_bit_clear(self, bit_number: int) -> bool:
        """ Test if the specified bit number is clear.

        :param bit_number: Bit number to test
        :return: True if the bit is 0
        """
        return not self.is_bit_set(bit_number)


class ZByte(ZData):

    def __init__(self, value: Union[ZData, bytes, memoryview], offset: int = 0):
        if type(value) in [memoryview, bytes]:
            if len(value) == 0:
                raise ValueError('value must be at least 1 byte long')

            value = bytes([value[offset]])
        elif type(value) == ZByte:
            # Copy/cast constructor
            value = value.bytes
        else:
            raise TypeError('ZByte value can only be set with ZByte, bytes or memoryview')

        super().__init__(value)

    def pad(self, is_signed: bool = False):
        """ Pad an 8-bit value to make it 16-bits.

        :param is_signed: Pad the high byte with the sign bit if True, otherwise pad with 0x00
        :return: A new 16-bit value
        :rtype: ZWord
        """
        if is_signed and (self.int < 0):
            return ZWord(b'\xff' + self._value)
        else:
            return ZWord(b'\x00' + self._value)

    def __eq__(self, other):
        if type(other) != ZByte:
            raise TypeError(f'can not compare a ZByte to {type(other)}')
        else:
            return self._value == other.bytes

    def _trunc_int(self, calc_size: int, res_size: int, value: int) -> bytes:
        bytes_val = value.to_bytes(calc_size, 'big', signed=True)
        return bytes_val[calc_size-res_size:]

    def __add__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only add ZData types')

        value = self.int + other.int
        if type(other) == ZWord:
            return ZWord(self._trunc_int(3, 2, value))
        elif type(other) == ZByte:
            return ZByte(self._trunc_int(2, 1, value))

    def __sub__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only subtract ZData types')

        value = self.int - other.int
        if type(other) == ZWord:
            return ZWord(self._trunc_int(3, 2, value))
        elif type(other) == ZByte:
            return ZByte(self._trunc_int(2, 1, value))

    def __mul__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only multiply ZData types')

        value = self.int * other.int
        if type(other) == ZWord:
            return ZWord(self._trunc_int(4, 2, value))
        elif type(other) == ZByte:
            return ZByte(self._trunc_int(2, 1, value))

    def __floordiv__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only divide ZData types')
        elif other.int == 0:
            raise ZMachineIllegalOperation('Divide by zero')

        value = self.int // other.int
        if type(other) == ZWord:
            return ZWord(self._trunc_int(4, 2, value))
        elif type(other) == ZByte:
            return ZByte(self._trunc_int(2, 1, value))

    def __mod__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only modulo ZData types')
        elif other.int == 0:
            raise ZMachineIllegalOperation('Modulo by zero')

        value = self.int % other.int

        if type(other) == ZByte:
            return ZByte.from_int(value)
        else:
            return ZWord.from_int(value)

    def __lshift__(self, other):
        if (type(other) != int) or (other < 0):
            raise TypeError('Can only shift by a positive integer')

        value = self.int << other
        return ZByte(self._trunc_int(2, 1, value))

    def __rshift__(self, other):
        if (type(other) != int) or (other < 0):
            raise TypeError('Can only shift by a positive integer')

        value = self.unsigned_int >> other
        return ZByte(self._trunc_int(1, 1, value))

    def __and__(self, other):
        if (type(other) != int) or (0 > other > 255):
            raise TypeError('Can only apply bitwise operations with an integer between 0 and 255')

        value = self.int & other
        return ZByte(self._trunc_int(1, 1, value))

    def __or__(self, other):
        if (type(other) != int) or (0 > other > 255):
            raise TypeError('Can only apply bitwise operations with an integer between 0 and 255')

        value = self.int | other
        return ZByte(self._trunc_int(1, 1, value))

    def __invert__(self):
        value = ~self.int
        return ZByte(self._trunc_int(1, 1, value))

    @staticmethod
    def from_int(value: int):
        try:
            return ZByte(value.to_bytes(1, 'big', signed=True))
        except OverflowError:
            raise ValueError('Can only create a signed byte from a value between -128 and 127')

    @staticmethod
    def from_unsigned_int(value: int):
        try:
            return ZByte(value.to_bytes(1, 'big', signed=False))
        except OverflowError:
            raise ValueError('Can only create an unsigned byte from a value between 0 and 255')

    def inc(self, amount: int = 1):
        new_val = self.unsigned_int + amount

        # Convert to 2 byte value to allow for over/underflow
        bytes_val = new_val.to_bytes(2, 'big', signed=False)
        return ZByte(bytes_val[1:])

    def dec(self, amount: int = 1):
        new_val = self.unsigned_int - amount

        # Convert to 2 byte value to allow for over/underflow
        bytes_val = new_val.to_bytes(2, 'big', signed=True)
        return ZByte(bytes_val[1:])

    def write(self, memory: memoryview, address: int):
        memory[address:address+1] = self._value

    def is_bit_set(self, bit_number: int) -> bool:
        if 0 < bit_number > 7:
            raise ValueError('Can only test bits 0-8 in a ZByte')

        mask = 1 << bit_number
        return (self.int & mask) != 0


class ZWord(ZData):

    def __init__(self, value: Union[ZData, bytes, memoryview], offset: int = 0):
        if type(value) == ZWord:
            # Copy/cast constructor
            value = value.bytes
        elif type(value) in [memoryview, bytes]:
            if len(value) < 2:
                raise ValueError('value must be at least two bytes long')

            value = bytes(value[offset:offset+2])
        else:
            raise TypeError('ZWord value can only be set with ZWord, bytes or memoryview')

        if len(value) != 2:
            raise ValueError('only two bytes can be assigned to a ZWord')

        super().__init__(value)

    def __eq__(self, other):
        if type(other) != ZWord:
            raise TypeError(f'can not compare a ZWord to {type(other)}')
        else:
            return self._value == other.bytes

    def _trunc_int(self, value: int):
        bytes_val = value.to_bytes(4, 'big', signed=True)
        return bytes_val[2:]

    def __add__(self, other):
        if not issubclass(type(other), ZData):
            raise ValueError('Can only add to another ZData type')

        value = self.int + other.int
        return ZWord(self._trunc_int(value))

    def __sub__(self, other):
        if not issubclass(type(other), ZData):
            raise ValueError('Can only subtract from another ZData type')

        value = self.int - other.int
        return ZWord(self._trunc_int(value))

    def __mul__(self, other):
        if not issubclass(type(other), ZData):
            raise ValueError('Can only multiply with another ZData type')

        value = self.int * other.int
        return ZWord(self._trunc_int(value))

    def __floordiv__(self, other):
        if not issubclass(type(other), ZData):
            raise ValueError('Can only divide by another ZData type')
        elif other.int == 0:
            raise ZMachineIllegalOperation('Divide by zero')

        value = self.int // other.int
        return ZWord(self._trunc_int(value))

    def __mod__(self, other):
        if not issubclass(type(other), ZData):
            raise TypeError('can only modulo ZData types')
        elif other.int == 0:
            raise ZMachineIllegalOperation('Modulo by zero')

        value = self.int % other.int
        return ZWord.from_int(value)

    def __lshift__(self, other):
        if (type(other) != int) or (other < 0):
            raise ValueError('Can only shift by an unsigned int greater than 0')

        value = self.int << other
        return ZWord(self._trunc_int(value))

    def __rshift__(self, other):
        if (type(other) != int) or (other < 0):
            raise ValueError('Can only shift by an unsigned int greater than 0')

        value = self.int >> other
        return ZWord.from_int(value)

    def __and__(self, other):
        if (type(other) != int) or (0 > other > 65535):
            raise TypeError('Can only apply bitwise operations with an integer between 0 and 65535')

        value = self.unsigned_int & other
        return ZWord.from_unsigned_int(value)

    def __or__(self, other):
        if (type(other) != int) or (0 > other > 65535):
            raise TypeError('Can only apply bitwise operations with an integer between 0 and 65535')

        value = self.int | other
        return ZWord.from_int(value)

    def __invert__(self):
        value = ~self.int
        return ZWord.from_int(value)

    @staticmethod
    def from_int(value: int):
        try:
            return ZWord(value.to_bytes(2, 'big', signed=True))
        except OverflowError:
            raise ValueError('Can only create a ZWord from a value between -32768 and 32767')

    @staticmethod
    def from_unsigned_int(value: int):
        try:
            return ZWord(value.to_bytes(2, 'big', signed=False))
        except OverflowError:
            raise ValueError('Can only create a ZWord from a value between 0 and 65535')

    def inc(self, amount: int = 1):
        new_val = self.unsigned_int + amount

        # Convert to 3 byte value to allow for over/underflow
        bytes_val = new_val.to_bytes(3, 'big', signed=True)
        return ZWord(bytes_val[1:])

    def dec(self, amount: int = 1):
        new_val = self.unsigned_int - amount

        # Convert to 3 byte value to allow for over/underflow
        bytes_val = new_val.to_bytes(3, 'big', signed=True)
        return ZWord(bytes_val[1:])

    def write(self, memory: memoryview, address: int):
        memory[address:address+2] = self._value

    def is_bit_set(self, bit_number: int) -> bool:
        if 0 < bit_number > 15:
            raise ValueError('Can only test bits 0-15 in a ZByte')

        mask = 1 << bit_number
        return (self.int & mask) != 0


class PC:

    def __init__(self, value: Union[int, ZWord]):
        if type(value) == ZWord:
            value = value.unsigned_int
        elif type(value) == int:
            if value < 0:
                raise ValueError('PC can only be a positive value')
        else:
            raise TypeError('Can only set the PC with a positive int or ZWord')

        self._value = value

    def __eq__(self, other):
        if type(other) == int:
            return self._value == other
        elif type(other) == PC:
            return self._value == int(other)

    def __add__(self, other):
        if issubclass(type(other), ZData):
            other = other.unsigned_int

        new_val = self._value + other

        if new_val < 0:
            raise ValueError('PC can only be a positive value')

        return PC(new_val)

    def __sub__(self, other):
        if issubclass(type(other), ZData):
            other = other.unsigned_int

        new_val = self._value - other

        if new_val < 0:
            raise ValueError('PC can only be a positive value')

        return PC(new_val)

    def __mul__(self, other):
        assert other > 0, 'PC can not be less than 0'
        if issubclass(type(other), ZData):
            other = other.unsigned_int

        return PC(self._value * other)

    def __str__(self):
        return f'0x{self._value:02x}'

    def __repr__(self):
        return f'<PC {self.__str__()}>'

    def __int__(self):
        return self._value
