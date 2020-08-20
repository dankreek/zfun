from copy import copy
from enum import Enum
from abc import ABC, abstractmethod
from typing import NamedTuple, Union, Tuple, List, Optional

from .data_structures import ZWord, ZByte, ZData, PC
from .util import is_bit_set
from .exc import ZMachineException
from .z_string import z_string_to_str_with_next
from .header import get_header


class ZMachineOpcodeParsingError(ZMachineException):
    pass


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


class ZMachineLabel(NamedTuple):
    predicate_type: bool
    offset: int

    """ The size of the label, 1 or 2 bytes """
    size: int


class ZMachineOpcodeInfo(NamedTuple):
    """ String version of opcode """
    name: str

    """ Argument types for the opcode """
    operand_types: Tuple[ZMachineOperandTypes]

    """ Operand values for the opcode """
    operands: Tuple[ZData]

    """ Variable to store result, if applicable """
    result_var: Optional[ZByte]

    """ Predicate type and offset for a branching instruction, if applicable """
    label: Optional[ZMachineLabel]

    """ Parsed string literal for instructions which precede z-string literals """
    string: Optional[str]

    """ Raw data for opcode and operands """
    data: bytes


class ZMachineOpcodeParser(ABC):

    def __init__(self, memory: Union[bytes, memoryview],
                 short_0op_opcodes: List[Tuple[str, bool, bool, bool]],
                 short_1op_opcodes: List[Tuple[str, bool, bool, bool]],
                 long_opcodes: List[Tuple[str, bool, bool, bool]],
                 variable_opcodes: List[Tuple[str, bool, bool, bool]]):
        self._memory = memory
        self._header = get_header(memory)
        self._short_0op = short_0op_opcodes
        self._short_1op = short_1op_opcodes
        self._long_opcodes = long_opcodes
        self._var_opcodes = variable_opcodes

    def _parse_short_operand_types(self, opcode_byte) -> Optional[Tuple[ZMachineOperandTypes]]:
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

    def _parse_variable_operand_types(self, types_addr: int, num_type_bytes: int = 1):
        next_pc = types_addr

        operand_types = []
        for address in range(num_type_bytes):
            operand_types += self._variable_types_in_byte(self._memory[next_pc])
            next_pc += 1

        # Filter out the OMITTED params
        types_list = [op_type for op_type in operand_types if op_type != ZMachineOperandTypes.OMITTED]
        return tuple(types_list), next_pc

    def _short_form_opcode(self, opcode_byte) -> Optional[Tuple[str, bool, bool, bool]]:
        """

        :param opcode_byte:
        :return: Tuple of opcode name, and bool indicating if opcode has a result variable, a label, or a string literal. None if opcode not supported
        """
        # If bits 5 and 4 are 0b11 then this is a 0-operand opcode, otherwise it's a 1-operand opcode
        # The opcode identifier itself is in the lower 4 bits
        if opcode_byte & 0b0011_0000 == 0b0011_0000:
            return self._short_0op[opcode_byte & 0x0f]
        else:
            return self._short_1op[opcode_byte & 0x0f]

    def _long_form_opcode(self, opcode_byte) -> Optional[Tuple[str, bool, bool, bool]]:
        """

        :param opcode_byte:
        :return: Tuple of opcode name, and bool indicating if opcode has a result variable, a label, or a string literal. None if opcode not supported
        """
        # Opcode identifier in long form is in the lower 5 bits
        return self._long_opcodes[opcode_byte & 0x1f]

    def _variable_form_opcode(self, opcode_byte) -> Optional[Tuple[str, bool, bool, bool]]:
        """

        :param opcode_byte:
        :return: Tuple of opcode name, and bool indicating if opcode has a result variable, a label, or a string literal. None if opcode not supported
        """
        # If the top bits are 0b110 then this is the variable form of a 2OP instruction
        if (opcode_byte & 0b1110_0000) == 0b1100_0000:
            # Opcode identifier is in lower 5 bits
            return self._long_opcodes[opcode_byte & 0x1f]
        else:
            return self._var_opcodes[opcode_byte & 0x1f]

    def _read_operands(self, operands_addr: int, operand_types: Tuple[ZMachineOperandTypes]) -> Tuple[Optional[Tuple[ZData]], int]:
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
                operands.append(ZByte(self._memory, addr))
                addr += 1
            elif op_type == ZMachineOperandTypes.LARGE_CONSTANT:
                operands.append(ZWord(self._memory, addr))
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

    def read_label(self, address: int) -> Tuple[ZMachineLabel, int]:
        """ Read a predicate type and offset for a branching instruction

        See section 4.7 of the Z-Machine Standards Document.

        :param address: Address to read label at
        :return: Decoded label info at address and the address of the next instruction in memory
        """
        first_branch_byte = self._memory[address]

        # If bit 7 is set, the predicate is a True type
        if is_bit_set(self._memory, address, 7):
            predicate = True
        else:
            predicate = False

        # If bit 6 is set, then the offset is an unsigned 6-bit number
        if is_bit_set(self._memory, address, 6):
            # Mask off the predicate and number type bits
            offset = ZByte.from_unsigned_int(first_branch_byte & 0b0011_1111).unsigned_int
            size = 1
        else:
            # If bit 6 is set then the offset is a 14-bit signed int, using the rest of the bits in
            # this byte and all of the the next byte. Since we can only address 8 or 16 bit numbers the
            # predicate and number type bits need to be padded with the same value as the sign bit.
            if is_bit_set(self._memory, address, 5):
                # Pad with 1's since this is a negative number
                first_branch_byte |= 0b1110_0000
            else:
                # Pad with 0's since this is a positive number
                first_branch_byte &= 0b0001_1111

            next_branch_byte = self._memory[address + 1]
            size = 2

            offset = ZWord(bytes([first_branch_byte, next_branch_byte])).integer

        return ZMachineLabel(predicate, offset, size), address + size

    def parse(self, opcode_pc: PC) -> Tuple[ZMachineOpcodeInfo, PC]:
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
            opcode_info = self._variable_form_opcode(opcode_byte)
            # Variable operand types are stored in the byte/bytes following the opcode

            if opcode_info[0] in ['call_vn2', 'call_vs2']:
                # The call_vn2 and call_vs2 operands are special "double variable" types which have 2 operand type bytes
                num_type_bytes = 2
            else:
                # All other variable opcodes have 1 byte of types
                num_type_bytes = 1

            operand_types, next_pc = self._parse_variable_operand_types(next_pc, num_type_bytes)
        elif opcode_form == OpcodeForm.SHORT:
            opcode_info = self._short_form_opcode(opcode_byte)
            # The short operand type is stored in the opcode byte itself
            operand_types = self._parse_short_operand_types(opcode_byte)
        elif opcode_form == OpcodeForm.LONG:
            opcode_info = self._long_form_opcode(opcode_byte)
            # Long form operand types are also stored in the opcode byte
            operand_types = self._parse_long_operand_types(opcode_byte)
        else:
            raise NotImplemented('Extended opcodes are not currently implemented')

        if opcode_info is None:
            raise ZMachineOpcodeParsingError('opcode not found')
        else:
            opcode_name, has_result, has_label, has_str = opcode_info

        operands, next_pc = self._read_operands(next_pc, operand_types)

        # Read in the result variable number and advance the PC
        if has_result:
            res_var = ZByte(self._memory, next_pc)
            next_pc += 1
        else:
            res_var = None

        if has_label:
            label, next_pc = self.read_label(next_pc)
        else:
            label = None

        if has_str:
            string_literal, next_pc = z_string_to_str_with_next(
                self._memory, next_pc, self._header.abbreviations_table_address
            )
        else:
            string_literal = None

        opcode_info = ZMachineOpcodeInfo(
            opcode_name,
            operand_types,
            operands,
            res_var,
            label,
            string_literal,
            bytes(self._memory[address:next_pc])
        )

        return opcode_info, PC(next_pc)


short_form_1op_opcodes_v3 = [
    ('jz', False, True, False),
    ('get_sibling', True, True, False),
    ('get_child', True, True, False),
    ('get_parent', True, False, False),
    ('get_prop_len', True, False, False),
    ('inc', False, False, False),
    ('dec', False, False, False),
    ('print_addr', False, False, False),
    None,
    ('remove_obj', False, False, False),
    ('print_obj', False, False, False),
    ('ret', False, False, False),
    ('jump', False, False, False),
    ('print_paddr', False, False, False),
    ('load', True, False, False),
    ('not', True, False, False)
]

short_form_0op_opcodes_v3 = [
    ('rtrue', False, False, False),
    ('rfalse', False, False, False),
    ('print', False, False, True),
    ('print_ret', False, False, True),
    ('nop', False, False, False),
    ('save', False, True, False),
    ('restore', False, True, False),
    ('restart', False, False, False),
    ('ret_popped', False, False, False),
    ('pop', False, False, False),
    ('quit', False, False, False),
    ('new_line', False, False, False),
    ('show_status', False, False, False),
    None,
    ('verify', False, True, False),
    None,
    None
]

long_opcodes_v3 = [
    None,
    ('je', False, True, False),
    ('jl', False, True, False),
    ('jg', False, True, False),
    ('dec_chk', False, True, False),
    ('inc_chk', False, True, False),
    ('jin', False, True, False),
    ('test', False, True, False),
    ('or', True, False, False),
    ('and', True, False, False),
    ('test_attr', False, True, False),
    ('set_attr', False, False, False),
    ('clear_attr', False, False, False),
    ('store', False, False, False),
    ('insert_obj', False, False, False),
    ('loadw', True, False, False),
    ('loadb', True, False, False),
    ('get_prop', True, False, False),
    ('get_prop_addr', True, False, False),
    ('get_next_prop', True, False, False),
    ('add', True, False, False),
    ('sub', True, False, False),
    ('mul', True, False, False),
    ('div', True, False, False),
    ('mod', True, False, False),
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None
]

# name, has_result, has_label, has_z_string
variable_opcodes_v3 = [
    ('call', True, False, False),
    ('storew', False, False, False),
    ('storeb', False, False, False),
    ('put_prop', False, False, False),
    ('sread', False, False, False),
    ('print_char', False, False, False),
    ('print_num', False, False, False),
    ('random', True, False, False),
    ('push', False, False, False),
    ('pull', False, False, False),
    ('split_window', False, False, False),
    ('set_window', False, False, False),
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    ('output_stream', False, False, False),
    ('input_stream', False, False, False),
    ('sound_effect', False, False, False),
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None
]

short_form_0op_opcodes_v4 = copy(short_form_0op_opcodes_v3)
short_form_0op_opcodes_v4[0x05] = ('save', True, False, False)
short_form_0op_opcodes_v4[0x06] = ('restore', True, False, False)
short_form_0op_opcodes_v4[0x0c] = None

short_form_1op_opcodes_v4 = copy(short_form_1op_opcodes_v3)
short_form_1op_opcodes_v4[0x08] = ('call_1s', True, False, False)

long_opcodes_v4 = copy(long_opcodes_v3)
long_opcodes_v4[0x19] = ('call_2s', True, False, False)

variable_opcodes_v4 = copy(variable_opcodes_v3)
variable_opcodes_v4[0x00] = ('call_vs', True, False, False)
variable_opcodes_v4[0x0c] = ('call_vs2', True, False, False)
variable_opcodes_v4[0x0d] = ('erase_window', False, False, False)
variable_opcodes_v4[0x0e] = ('erase_line', False, False, False)
variable_opcodes_v4[0x0f] = ('set_cursor', False, False, False)
variable_opcodes_v4[0x10] = ('get_cursor', False, False, False)
variable_opcodes_v4[0x11] = ('set_text_style', False, False, False)
variable_opcodes_v4[0x12] = ('buffer_mode', False, False, False)
variable_opcodes_v4[0x16] = ('read_char', True, False, False)
variable_opcodes_v4[0x17] = ('scan_table', True, True, False)


class ZMachineOpcodeParserV3(ZMachineOpcodeParser):

    def __init__(self, memory: Union[bytes, memoryview]):
        super().__init__(memory, short_form_0op_opcodes_v3, short_form_1op_opcodes_v3, long_opcodes_v3, variable_opcodes_v3)


class ZMachineOpcodeParserV4(ZMachineOpcodeParser):

    def __init__(self, memory: Union[bytes, memoryview]):
        super().__init__(memory, short_form_0op_opcodes_v4, short_form_1op_opcodes_v4, long_opcodes_v4, variable_opcodes_v4)
