from typing import Union

from .header import ZCodeHeader
from .stack import ZMachineStack
from .data_structures import ZWord, ZByte, ZData


class ZMachineVariables:

    def __init__(self, memory: memoryview, header: ZCodeHeader, stack: ZMachineStack):
        self._header = header
        self._memory = memory
        self._stack = stack

    def global_val(self, var_num: int) -> ZWord:
        """ Get the value of the given global variable number. """
        var_address = self._header.global_var_table_address + (var_num * 2)
        return ZWord.read(self._memory, var_address)

    def set_global(self, var_num: int, val: ZWord):
        """ Set the value of the given global variable number.

        :param var_num:
        :param val:
        """
        assert type(val) == ZWord, 'A ZWord is expected'

        var_address = self._header.global_var_table_address + (var_num * 2)
        val.write(self._memory, var_address)

    def val(self, var_num: ZByte) -> ZData:
        """ Get a variable value as defined by the Z-Machine spec.

        $00 popped off of the stack
        $01 - $0f are the local variables of the current routine
        $10 - $ff are the global variables

        :param var_num: Variable number (operand)
        :return: Variable value
        """
        assert type(var_num) == ZByte, 'Variable number must be a ZByte'
        var_num_int = var_num.unsigned_int

        if var_num_int == 0:
            return self._stack.pop()
        elif var_num_int < 0x10:
            return self._stack.local_var(var_num_int - 1)
        else:
            return self.global_val(var_num_int - 0x10)

    def set(self, var_num: ZByte, val: ZData):
        """ Store a value in a variable type

        $00 pushed onto the stack
        $01 - $0f are the local variables of the current routine
        $10 - $ff are the global variables

        :param var_num:
        :param val:
        """
        assert type(var_num) == ZByte, 'Variable number must be a ZByte'
        assert issubclass(type(val), ZData), 'A ZByte or ZWord value is expected'
        var_num_int = var_num.unsigned_int

        if var_num_int == 0:
            # Replace the value at the top of the stack
            self._stack.push(val)
        elif var_num_int < 0x10:
            self._stack.set_local_var(var_num_int - 1, val)
        else:
            self.set_global(var_num_int - 0x10, ZWord(val))

