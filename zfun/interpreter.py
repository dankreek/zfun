from abc import ABC, abstractmethod
from typing import Union, Tuple

from .stack import ZMachineStack
from .opcodes import ZMachineOpcodeParser, ZMachineOpcodeParserV3, ZMachineOperandTypes
from .objects import ZMachineObjectTable
from .header import ZCodeHeader, get_header
from .tokenize import tokenize
from .z_string import z_string_to_str, z_string_to_str_with_next
from .dictionary import ZMachineDictionary
from .exc import ZMachineExitException, ZMachineUndefinedInstruction, ZMachineResetException
from .util import read_word, read_signed_word, signed_word, word, write_word, is_bit_set
from .variables import ZMachineVariables
from .screen import ZMachineScreen


# XXX: use is_bit_set for various unwieldy mask bools


class ZMachineInterpreter(ABC):
    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen):
        self._stack = ZMachineStack()
        self._header = header
        self._screen = screen

        self._pc = header.initial_pc_value

        self._memory = memory
        self._opcode_parser = ZMachineOpcodeParserV3(memory)
        self._dictionary = ZMachineDictionary(memory, header)
        self._variables = ZMachineVariables(memory, header, self._stack)
        self._obj_table = ZMachineObjectTable(memory, header)

        # Store the operands and types for the currently executing instruction here
        # I wouldn't normally pass around arguments in global fashion but this is to better
        # simulate my later implementation for the Commodore 128
        self._operands = Union[None, Tuple[bytes]]
        self._operand_types = Union[None, Tuple[ZMachineOperandTypes]]

    def step(self, address: int = None):
        """ Execute a single instruction.

        If an address is provided, the PC is reset to that address before executing the instruction.

        If the `quit` instruction is found, then ZMachineExitException is raised.

        :param address: Address of the instruction to execute or the current PC if None.
        """
        if address is not None:
            self._pc = address

        opcode_and_operands, next_pc = self._opcode_parser.parse(self._pc)
        self._pc = next_pc

        opcode_method_name = '__opcode_' + opcode_and_operands.opcode

        if not hasattr(self, opcode_method_name):
            raise ZMachineUndefinedInstruction(f'The instruction `{opcode_and_operands.opcode}` is not defined for this interpreter.')
        else:
            self._operands = opcode_and_operands.operands
            self._operand_types = opcode_and_operands.operand_types

            # XXX: try and wrap in exception with machine info if any exception is raised (other than exit)
            # Call the opcode's handler method
            self.__getattribute__(opcode_method_name)()

    def run(self):
        """ Run the Z-machine from the current PC until the machine quits. """
        while True:
            try:
                self.step()
            except ZMachineResetException:
                # TODO: Implement restarting game
                pass
            except ZMachineExitException:
                return

    @abstractmethod
    def save_handler(self, save_data: bytes) -> bool:
        """ Save the save_data somewhere to be restored later.

        :param save_data: Save game data
        :return: True if save was successful, False if not
        """
        pass

    @abstractmethod
    def restore_handler(self) -> Union[bytes, None]:
        """ Read save data from user and return it.

        :return: Game state data, or None if loading data failed.
        """
        pass

    @staticmethod
    @abstractmethod
    def expanded_packed_address(packed_address: int) -> int:
        """ Expand a packed address for the implementing version of the interpreter.

        :param packed_address: Address in packed form.
        :return: The packed_address expanded to be the actual address.
        """
        pass

    def _read_res_var(self) -> int:
        """ Read a single byte at the PC, advance the PC and return the result variable number. """
        res_var = self._memory[self._pc]
        self._pc += 1
        return res_var

    def _read_branch(self) -> Tuple[bool, int]:
        """ Read a branch predicate and location after decoding a branch instruction.

        See section 4.7 of the Z-Machine Standards Document.

        :return: True if branch should happen on a true condition, and the offset of the branch if predicate is satisfied.
        """
        self._pc += 1
        first_branch_byte = self._memory[self._pc]

        # If bit 7 is set, the predicate is a True type
        if is_bit_set(self._memory, self._pc, 7):
            predicate = True
        else:
            predicate = False

        # If bit 6 is set, then the offset is an unsigned 6-bit number
        if is_bit_set(self._memory, self._pc, 6):
            # Mask off the predicate and number type bits
            offset = (first_branch_byte & 0b0011_1111)
        else:
            # If bit 6 is clear then the offset is a 14-bit signed int, using the rest of the bits in
            # this byte and all of the the next byte. Since we can only address 8 or 16 bit numbers the
            # predicate and number type bits need to be padded with the same value as the sign bit.
            if is_bit_set(self._memory, self._pc, 5):
                # Pad with 1's since this is a negative number
                first_branch_byte |= 0b1110_0000
            else:
                # Pad with 0's since this is a positive number
                first_branch_byte &= 0b0001_1111

            self._pc += 1
            next_branch_byte = self._memory[self._pc]

            offset = read_signed_word(bytes([first_branch_byte, next_branch_byte]))

        return predicate, offset

    def _read_string_literal(self) -> str:
        """ Reads a literal string after and instruction and increment PC

        :return: String read after current instruction
        """
        string, next_pc = z_string_to_str_with_next(self._memory, self._pc)
        self._pc = next_pc
        return string

    def _operand_val(self, operand_num: int) -> int:
        """ Read the value of an operand as an integer.

        If the operand is a variable type then it is read from global/local vars or the stack.

        :param operand_num:
        :return:
        """
        val = self._operands[operand_num]

        if self._operand_types[operand_num] == ZMachineOperandTypes.VARIABLE:
            val = self._variables.val(int.from_bytes(val, 'big', signed=False))

        if len(val) == 1:
            return int.from_bytes(val, 'big', signed=False)
        else:
            return read_word(val)

    def _signed_operand_val(self, operand_num: int) -> int:
        """ Read the value of an operand as a signed integer.

        If the operand is a variable type then it is read from global/local vars or the stack.

        :param operand_num:
        :return:
        """
        val = self._operands[operand_num]

        if self._operand_types[operand_num] == ZMachineOperandTypes.VARIABLE:
            val = self._variables.val(int.from_bytes(val, 'big', signed=False))

        if len(val) == 1:
            return int.from_bytes(val, 'big', signed=True)
        else:
            return read_signed_word(val)

    def _handle_branch(self, branch_pred: bool, pred_type: bool, offset: int):
        if branch_pred == pred_type:
            # In the case where an offset is 0 or 1, return false or true from the current routine
            if (offset == 0) or (offset == 1):
                ret_pc, res_var = self._stack.pop_routine_call()
                self._variables.set(res_var, signed_word(offset))
                self._pc = ret_pc
            else:
                self._pc += offset - 2

    # --- Instructions are all defined below and executed via reflection ---

    # 0OP instructions

    def __opcode_rtrue(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(1))
        self._pc = next_pc

    def __opcode_rfalse(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(0))
        self._pc = next_pc

    def __opcode_print(self):
        string = self._read_string_literal()
        self._screen.print(string)

    def __opcode_print_ret(self):
        string = self._read_string_literal()
        self._screen.print(string + '\n')

        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(1))
        self._pc = next_pc

    def __opcode_nop(self):
        pass

    def __opcode_save(self):
        predicate_type, offset = self._read_branch()
        # TODO: Implement save game state
        success = self.save_handler(bytes([]))
        self._handle_branch(success == predicate_type, offset)

    def __opcode_restore(self):
        predicate_type, offset = self._read_branch()
        # TODO: Implement restore game state
        restore_data = self.restore_handler()

    def __opcode_restart(self):
        raise ZMachineResetException()

    def __opcode_ret_popped(self):
        ret_val = self._stack.pop()
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ret_val)
        self._pc = next_pc

    def __opcode_pop(self):
        self._stack.pop()

    def __opcode_quit(self):
        # When the quit instruction is executed, simply raise the exit exception.
        raise ZMachineExitException()

    def __opcode_new_line(self):
        self._screen.print('\n')

    def __opcode_show_status(self):
        self._screen.is_status_displayed = True

    def __opcode_verify(self):
        # Technically supposed to verify the integrity of the game file, but not doing it
        pass

    # 1OP instructions

    def __opcode_jz(self):
        predicate_type, offset = self._read_branch()
        self._handle_branch(self._operand_val(0) == 0, predicate_type, offset)

    def __opcode_get_sibling(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.sibling))
        self._handle_branch(obj.sibling != 0, predicate_type, offset)

    def __opcode_get_child(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.child))
        self._handle_branch(obj.child != 0, predicate_type, offset)

    def __opcode_get_parent(self):
        res_var = self._read_res_var()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.parent))

    def __opcode_get_prop_len(self):
        res_var = self._read_res_var()

        prop_addr = self._operand_val(0)
        prop_data = self._obj_table.property_at(prop_addr)
        self._variables.set(res_var, word(prop_data.size))

    def __opcode_inc(self):
        var_num = self._operand_val(0)
        cur_val = read_word(self._variables.val(var_num))
        self._variables.set(var_num, word(cur_val + 1))

    def __opcode_dec(self):
        var_num = self._operand_val(0)
        cur_val = read_word(self._variables.val(var_num))
        self._variables.set(var_num, word(cur_val - 1))

    def __opcode_print_addr(self):
        zstr_addr = self._operand_val(0)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def __opcode_remove_obj(self):
        obj_num = self._operand_val(0)
        self._obj_table.remove_obj_from_parent(obj_num)

    def __opcode_print_obj(self):
        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._screen.print(obj.properties.name)

    def __opcode_ret(self):
        ret_val = self._operand_val(0)
        next_pc, res_var = self._stack.pop_routine_call()
        self._variables.set(res_var, word(ret_val))
        self._pc = next_pc

    def __opcode_jump(self):
        offset = self._signed_operand_val(0)
        self._pc += offset

    def __opcode_print_paddr(self):
        packed_addr = self._operand_val(0)
        zstr_addr = self.expanded_packed_address(packed_addr)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def __opcode_load(self):
        res_var = self._read_res_var()
        val = self._operand_val(0)
        self._variables.set(res_var, word(val))

    def __opcode_not(self):
        # This is technically an unsigned operation, but using signed numbers to
        # leverage Python's concept of an integer. Without using signed numbers
        # the result of the operation may not fit in 16 bits
        res_var = self._read_res_var()
        val = self._signed_operand_val(0)
        self._variables.set(res_var, signed_word(~val))

    # 2OP instructions

    def __opcode_je(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._operand_val(0)
        op_1 = self._operand_val(1)
        self._handle_branch(op_0 == op_1, predicate_type, offset)

    def __opcode_jl(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._signed_operand_val(0)
        op_1 = self._signed_operand_val(1)
        self._handle_branch(op_0 < op_1, predicate_type, offset)

    def __opcode_jg(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._signed_operand_val(0)
        op_1 = self._signed_operand_val(1)
        self._handle_branch(op_0 > op_1, predicate_type, offset)

    def __opcode_dec_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operand_val(0)
        cmp_val = self._signed_operand_val(1)
        val = read_signed_word(self._variables.val(var_num))
        val -= 1
        self._variables.set(var_num, signed_word(val))
        self._handle_branch(val < cmp_val, predicate_type, offset)

    def __opcode_inc_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operand_val(0)
        cmp_val = self._signed_operand_val(1)
        val = read_signed_word(self._variables.val(var_num))
        val += 1
        self._variables.set(var_num, signed_word(val))
        self._handle_branch(val > cmp_val, predicate_type, offset)

    def __opcode_jin(self):
        predicate_type, offset = self._read_branch()
        child_obj_num = self._operand_val(0)
        parent_obj_num = self._operand_val(1)
        obj0 = self._obj_table.object(child_obj_num)
        self._handle_branch(obj0.parent == parent_obj_num, predicate_type, offset)

    def __opcode_test(self):
        predicate_type, offset = self._read_branch()
        bitmap = self._operand_val(0)
        flags = self._operand_val(1)
        self._handle_branch((bitmap & flags) == flags, predicate_type, offset)

    def __opcode_or(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)
        self._variables.set(res_var, word(a | b))

    def __opcode_and(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)
        self._variables.set(res_var, word(a & b))

    def __opcode_test_attr(self):
        predicate_type, offset = self._read_branch()
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        self._handle_branch(obj.is_attribute_set(attr_num), predicate_type, offset)

    def __opcode_set_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, True)

    def __opcode_clear_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, False)

    def __opcode_store(self):
        var_num = self._operand_val(0)
        val = self._operand_val(1)
        self._variables.set(var_num, word(val))

    def __opcode_insert_obj(self):
        obj_num = self._operand_val(0)
        parent_obj_num = self._operand_val(1)
        self._obj_table.insert_child(obj_num, parent_obj_num)

    def __opcode_loadw(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0)
        word_idx = self._operand_val(1)
        ret_word = read_word(self._memory, arr_addr + (2 * word_idx))
        self._variables.set(res_var, word(ret_word))

    def __opcode_loadb(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0)
        byte_idx = self._operand_val(1)
        ret_byte = self._memory[arr_addr + byte_idx]
        self._variables.set(res_var, word(ret_byte))

    def __opcode_get_prop(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        prop_val = obj.properties.property_val(prop_num)

        if len(prop_val) == 1:
            # Pad with 00 if property is only one byte long
            prop_val = b'\x00' + prop_val

        self._variables.set(res_var, prop_val)

    def __opcode_get_prop_addr(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)

        obj = self._obj_table.object(obj_num)
        prop_addr = obj.properties.own_property_address(prop_num)

        if prop_addr is None:
            prop_addr = 0

        self._variables.set(res_var, word(prop_addr))

    def __opcode_get_next_prop(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)

        obj = self._obj_table.object(obj_num)

        if prop_num == 0:
            prop_info = obj.properties.first_own_property()
        else:
            prop_info = obj.properties.own_property(prop_num)

        if prop_info.next_prop_address is None:
            next_prop_num = 0
        else:
            next_prop = self._obj_table.property_at(prop_info.next_prop_address)
            next_prop_num = next_prop.number

        self._variables.set(res_var, word(next_prop_num))

    def __opcode_add(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a + b))

    def __opcode_sub(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a - b))

    def __opcode_mul(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a * b))

    def __opcode_div(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a // b))

    def __opcode_mod(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a % b))

    # VAR OP instructions

    def __opcode_call(self):
        # The first operand contains the packed address of the routine to call.
        routine_address = self.expanded_packed_address(self._operands[0])

        # The first byte of the routine header contains the number of local variables the routine has
        local_vars_count = self._memory[routine_address]

        # Each local variable's initial value is stored in the words following the word count byte
        initial_local_var_values = [
            read_word(self._memory, routine_address + 1 + (i * 2))
            for i in range(local_vars_count)
        ]

        # The return value the variable number is stored in the byte after the operands
        res_var = self._read_res_var()

        # Add new frame to the stack for this routine
        self._stack.push_routine_call(self._pc, local_vars_count, res_var, *initial_local_var_values)

        # The 2nd to nth operand contains the values to pass into the routine
        # Passing values into a routine is accomplished by setting the local variables
        for var_num in range(len(self._operands)-1):
            self._stack.set_local_var(var_num, self._operands[var_num+1])

        # The address of the first instruction is directly after all the parameters
        self._pc = routine_address + 1 + (local_vars_count * 2)

    def __opcode_storew(self):
        arr_addr = self._operand_val(0)
        word_i = self._operand_val(1)
        value = self._operand_val(2)
        write_word(self._memory, arr_addr + (word_i * 2), value)

    def __opcode_storeb(self):
        arr_addr = self._operand_val(0)
        byte_i = self._operand_val(1)
        value = self._operand_val(2)
        self._memory[arr_addr + byte_i] = value



class ZMachineInterpreterV3(ZMachineInterpreter):

    def __init__(self, header: ZCodeHeader, memory: memoryview):
        assert header.version == 3, 'invalid z-code version for version interpreter'
        super().__init__(header, memory)

    @staticmethod
    def expanded_packed_address(packed_address: int) -> int:
        return packed_address * 2


