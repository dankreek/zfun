from enum import Enum
from abc import ABC, abstractmethod
from typing import NamedTuple, Union, Tuple, List

from .data_structures import ZWord, ZByte, ZData, PC


class OpcodeForm(Enum):
    LONG = 0
    SHORT = 1
    EXTENDED = 2
    VARIABLE = 3


class ZMachineOperandTypes(Enum):
    LARGE_CONSTANT = 0
    SMALL_CONSTANT = 1
    VARIABLE = 2
    OMITTED = 3


class ZMachineOpcode(NamedTuple):
    """ String version of opcode """
    opcode: str

    """ Argument types for the opcode """
    operand_types: Union[None, Tuple[ZMachineOperandTypes]]

    """ Operand values for the opcode """
    operands: Union[None, Tuple[ZData]]

    """ Raw data for opcode and operands """
    data: bytes


class ZMachineOpcodeParser(ABC):

    def __init__(self, memory: Union[bytes, memoryview]):
        self._memory = memory

    def _parse_short_operand_types(self, opcode_byte) -> Union[None, Tuple[ZMachineOperandTypes]]:
        # The single operand type is stored in bits 5 and 4 and correspond the values of OperandTypes
        # Put the single opcode type in bits 7 and 6, and pad with 1's (which indicates no operand)
        types_byte = (opcode_byte << 2) | 0x3f

        # Only the first operand type is used so return it as a 1-tuple
        operand_types = self._variable_types_in_byte(types_byte)[0],

        if operand_types[0] == ZMachineOperandTypes.OMITTED:
            return None
        else:
            return operand_types

    @staticmethod
    def _variable_types_in_byte(types_byte) -> List[ZMachineOperandTypes]:
        """ Read each 2 bit operand type in a byte.

        :param types_byte: Byte containing operand types
        :return: List of all operand types found in the byte
        """
        operand_types = []
        for _ in range(4):
            # Mask off all but bits 7 and 6
            type_bits = types_byte & 0xc0

            if type_bits == 0:
                operand_types.append(ZMachineOperandTypes.LARGE_CONSTANT)
            elif type_bits == 0b0100_0000:
                operand_types.append(ZMachineOperandTypes.SMALL_CONSTANT)
            elif type_bits == 0b1000_0000:
                operand_types.append(ZMachineOperandTypes.VARIABLE)
            elif type_bits == 0b1100_0000:
                operand_types.append(ZMachineOperandTypes.OMITTED)
            else:
                raise RuntimeError('No idea how this happened')

            types_byte <<= 2

        return operand_types

    @staticmethod
    def _parse_long_operand_types(opcode_byte):
        # Bits 5 and 4 give the operand types
        # 0 = Small Constant
        # 1 = Variable
        first_operand_type = ZMachineOperandTypes.SMALL_CONSTANT if (opcode_byte & 0x40) == 0 else ZMachineOperandTypes.VARIABLE
        second_operand_type = ZMachineOperandTypes.SMALL_CONSTANT if (opcode_byte & 0x20) == 0 else ZMachineOperandTypes.VARIABLE
        operand_types = (first_operand_type, second_operand_type)
        return operand_types

    def _parse_variable_operand_types(self, types_addr: int, max_type_bytes: int = 1):
        next_pc = types_addr

        # Loop until the types list ends with OMITTED
        operand_types = self._variable_types_in_byte(self._memory[next_pc])
        next_pc += 1

        while operand_types[-1] != ZMachineOperandTypes.OMITTED and ((next_pc - types_addr) < max_type_bytes):
            operand_types += self._variable_types_in_byte(self._memory[next_pc])
            next_pc += 1

        # Filter out the OMITTED params
        types_list = [op_type for op_type in operand_types if op_type != ZMachineOperandTypes.OMITTED]
        return tuple(types_list), next_pc

    @abstractmethod
    def short_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        """

        :param opcode_byte:
        :return: Name of the short form opcode for the implemented z-machine version, None if opcode not supported
        """
        pass

    @abstractmethod
    def long_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        """

        :param opcode_byte:
        :return: Name of the long form opcode for the implemented z-machine version, None if opcode not supported
        """
        pass

    @abstractmethod
    def variable_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        """
        :param opcode_byte:
        :return: Name of the variable form opcode for implemented z-machine version, None if opcode not supported
        """
        pass

    def _read_operands(self, operands_addr: int, operand_types: Tuple[ZMachineOperandTypes]) -> Tuple[Union[None, Tuple[ZData]], int]:
        """ Read the operands at the given address as the specified types.

        :param operands_addr: Address where operands are located
        :param operand_types: Types of operands to read
        :return: A tuple of operand values and the next PC after reading all the operands
        """
        if operand_types is None:
            return None, operands_addr

        operands: List[ZData] = []

        addr = operands_addr
        for op_type in operand_types:
            if op_type in [ZMachineOperandTypes.SMALL_CONSTANT, ZMachineOperandTypes.VARIABLE]:
                operands.append(ZByte.read(self._memory, addr))
                addr += 1
            elif op_type == ZMachineOperandTypes.LARGE_CONSTANT:
                operands.append(ZWord.read(self._memory, addr))
                addr += 2

        return tuple(operands), addr

    @staticmethod
    def _opcode_form(opcode_byte) -> OpcodeForm:
        """ Determine the opcode form from the opcode byte.

        :param opcode_byte:
        """
        # The opcode form is stored in the top two bits of the opcode byte
        # 0b11 is variable
        # 0b10 is short form
        # 0b01 and 0b00 is long form
        # The exception being 0xbe which is for extended opcodes
        if opcode_byte == 0xbe:
            raise OpcodeForm.EXTENDED
        elif opcode_byte & 0b1100_0000 == 0b1100_0000:
            return OpcodeForm.VARIABLE
        elif opcode_byte & 0b1100_0000 == 0b1000_0000:
            return OpcodeForm.SHORT
        else:
            return OpcodeForm.LONG

    def parse(self, opcode_pc: PC) -> Tuple[ZMachineOpcode, PC]:
        """ Get the opcode and arguments at the given address.

        Note that the next PC that is returned will be at the position where Opcode decoding left off,
        so if an opcode needs to read its return variable number or a string constant it will need
        this info.

        :param opcode_pc: Memory address for opcode
        :return: ZMachineOpcode and operands/types and the memory address where the operand decoding stopped.
        """
        address = int(opcode_pc)

        opcode_byte = self._memory[address]
        opcode_form = self._opcode_form(opcode_byte)

        next_pc = address + 1
        if opcode_form == OpcodeForm.VARIABLE:
            opcode_name = self.variable_form_opcode_name(opcode_byte)
            # Variable operand types are stored in the byte/bytes following the opcode
            operand_types, next_pc = self._parse_variable_operand_types(next_pc, 1)
        elif opcode_form == OpcodeForm.SHORT:
            opcode_name = self.short_form_opcode_name(opcode_byte)
            # The short operand type is stored in the opcode byte itself
            operand_types = self._parse_short_operand_types(opcode_byte)
        elif opcode_form == OpcodeForm.LONG:
            opcode_name = self.long_form_opcode_name(opcode_byte)
            # Long form operand types are also stored in the opcode byte
            operand_types = self._parse_long_operand_types(opcode_byte)
        else:
            raise NotImplemented('Extended opcodes are not currently implemented')

        operands, next_pc = self._read_operands(next_pc, operand_types)

        return ZMachineOpcode(opcode_name, operand_types, operands, bytes(self._memory[address:next_pc])), PC(next_pc)


short_form_1op_opcodes_v3 = [
    'jz',           # 99 Problems
    'get_sibling',
    'get_child',
    'get_parent',
    'get_prop_len',
    'inc',
    'dec',
    'print_addr',
    None,
    'remove_obj',
    'print_obj',
    'ret',
    'jump',
    'print_paddr',
    'load',
    'not'
]

short_form_0op_opcodes_v3 = [
    'rtrue',
    'rfalse',
    'print',
    'print_ret',
    'nop',
    'save',
    'restore',
    'restart',
    'ret_popped',
    'pop',
    'quit',
    'new_line',
    'show_status',
    None,
    'verify',
    None,
    None
]

long_form_opcodes_v3 = [
    None,
    'je',
    'jl',
    'jg',
    'dec_chk',
    'inc_chk',
    'jin',
    'test',
    'or',
    'and',
    'test_attr',
    'set_attr',
    'clear_attr',
    'store',
    'insert_obj',
    'loadw',
    'loadb',
    'get_prop',
    'get_prop_addr',
    'get_next_prop',
    'add',
    'sub',
    'mul',
    'div',
    'mod',
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None
]

variable_form_opcodes_v3 = [
    'call',
    'storew',
    'storeb',
    'put_prop',
    'sread',
    'print_char',
    'print_num',
    'random',
    'push',
    'pull',
    'split_window',
    'set_window',
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    'output_stream',
    'input_stream',
    'sound_effect',
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None
]


class ZMachineOpcodeParserV3(ZMachineOpcodeParser):
    def short_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        # If bits 5 and 4 are 0b11 then this is a 0-operand opcode, otherwise it's a 1-operand opcode
        # The opcode identifier itself is in the lower 4 bits
        if opcode_byte & 0b0011_0000 == 0b0011_0000:
            return short_form_0op_opcodes_v3[opcode_byte & 0x0f]
        else:
            return short_form_1op_opcodes_v3[opcode_byte & 0x0f]

    def long_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        # Opcode identifier in long form is in the lower 5 bits
        return long_form_opcodes_v3[opcode_byte & 0x1f]

    def variable_form_opcode_name(self, opcode_byte) -> Union[None, str]:
        # If the top bits are 0b110 then this is the variable form of a 2OP instruction
        if (opcode_byte & 0b1110_0000) == 0b1100_0000:
            # Opcode identifier is in lower 5 bits
            return long_form_opcodes_v3[opcode_byte & 0x1f]
        else:
            return variable_form_opcodes_v3[opcode_byte & 0x1f]

