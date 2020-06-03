from .header import ZCodeHeader
from .stack import ZMachineStack

from typing import Union


# XXX: Clean up all int conversions. Remove "read" int methods completely
class ZMachineVariables:

    def __init__(self, memory: memoryview, header: ZCodeHeader, stack: ZMachineStack):
        self._header = header
        self._memory = memory
        self._stack = stack

    def global_val(self, var_num: int) -> memoryview:
        """ Get the value of the given global variable number. """
        var_offset = self._header.global_var_table_address + (var_num * 2)
        return self._memory[var_offset:var_offset+2]

    def set_global(self, var_num: int, val: Union[bytes, memoryview]):
        """ Set the value of the given global variable number.

        :param var_num:
        :param val:
        """
        assert len(val) == 2, 'A 16 bit word is expected'
        var_offset = self._header.global_var_table_address + (var_num * 2)
        self._memory[var_offset] = val[0]
        self._memory[var_offset+1] = val[1]

    def val(self, var_num: int) -> Union[bytes, memoryview]:
        """ Get a variable value as defined by the Z-Machine spec.

        $00 popped off of the stack
        $01 - $0f are the local variables of the current routine
        $10 - $ff are the global variables

        :param var_num:
        :return: Variable value
        """
        assert 0 <= var_num <= 0xff

        if var_num == 0:
            return self._stack.pop()
        elif var_num < 0x10:
            return self._stack.local_var(var_num - 1)
        else:
            return self.global_val(var_num - 0x10)

    def set(self, var_num: int, val: Union[bytes, memoryview]):
        """ Store a value in a variable type

        $00 pushed onto the stack
        $01 - $0f are the local variables of the current routine
        $10 - $ff are the global variables

        :param var_num:
        :param val:
        """
        assert 0 <= var_num <= 0xff
        assert 1 <= len(val) <= 2, 'An 8 or 16 bit value is expected'

        if len(val) == 1:
            val = b'\x00' + val

        if var_num == 0:
            # Replace the value at the top of the stack
            self._stack.push(val)
        elif var_num < 0x10:
            self._stack.set_local_var(var_num - 1, val)
        else:
            self.set_global(var_num - 0x10, val)

