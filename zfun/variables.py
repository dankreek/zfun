from .header import ZCodeHeader
from .util import read_signed_word, read_word, write_word, write_signed_word

from typing import Union


class ZMachineVariables:

    def __init__(self, memory: memoryview, header: ZCodeHeader):
        self._header = header
        self._memory = memory

    def global_val_bytes(self, var_num: int) -> memoryview:
        """ Get the value of the given global variable number. """
        var_offset = self._header.global_var_table_address + (var_num * 2)
        return self._memory[var_offset:var_offset+2]

    def global_val(self, var_num: int) -> int:
        """ Get the value of the given global variable number as an unsigned int.

        :param var_num:
        :return:
        """
        return read_word(self._memory, self._header.global_var_table_address + (var_num * 2))

    def global_signed_val(self, var_num: int) -> int:
        """ Get the value of the given global variable number as a signed int.

        :param var_num:
        :return:
        """
        return read_signed_word(self._memory, self._header.global_var_table_address + (var_num * 2))

    def set_global_val_bytes(self, var_num: int, val: Union[bytes, memoryview]):
        """ Set the value of the given global variable number.

        :param var_num:
        :param val:
        """
        var_offset = self._header.global_var_table_address + (var_num * 2)
        self._memory[var_offset] = val[0]
        self._memory[var_offset+1] = val[1]

    def set_global_val(self, var_num: int, val: int):
        """ Set the value of the given global variables number as an unsigned int.

        :param var_num:
        :param val:
        """
        var_offset = self._header.global_var_table_address + (var_num * 2)
        write_word(self._memory, var_offset, val)

    def set_global_signed_val(self, var_num: int, val: int):
        """ Set the value of the given global variables number as an unsigned int.

        :param var_num:
        :param val:
        """
        var_offset = self._header.global_var_table_address + (var_num * 2)
        write_signed_word(self._memory, var_offset, val)

