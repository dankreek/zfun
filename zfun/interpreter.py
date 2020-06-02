import random
from abc import ABC, abstractmethod
from typing import Union, Tuple

from .dictionary import ZMachineDictionary
from .exc import ZMachineIllegalOperation, ZMachineException
from .header import ZCodeHeader
from .input import ZMachineInput
from .opcodes import ZMachineOpcodeParser, ZMachineOpcodeParserV3, ZMachineOperandTypes
from .objects import ZMachineObjectTable
from .screen import ZMachineScreen
from .stack import ZMachineStack
from .tokenize import tokenize
from .util import read_word, read_signed_word, signed_word, word, write_word, is_bit_set
from .variables import ZMachineVariables
from .z_string import z_string_to_str, z_string_to_str_with_next


class ZMachineInterpreter(ABC):
    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen, keyboard: ZMachineInput):
        self._header = header
        self._memory = memory
        self._screen = screen
        self._keyboard = keyboard

        self._stack = ZMachineStack()
        self._pc = header.initial_pc_value

        # XXX: Read the version from the header to instantiate this
        self._opcode__parser = ZMachineOpcodeParserV3(memory)
        self._dictionary = ZMachineDictionary(memory, header)
        self._variables = ZMachineVariables(memory, header, self._stack)
        self._obj_table = ZMachineObjectTable(memory, header)

        # Store the operands and types for the currently executing instruction here
        # I wouldn't normally pass around arguments in global fashion but this is to better
        # simulate my later implementation for the Commodore 128, as well as simplify the signatures
        # for the opcode handling methods.
        self._operands = Union[None, Tuple[bytes]]
        self._operand_types = Union[None, Tuple[ZMachineOperandTypes]]

    @abstractmethod
    def initialize(self):
        """ Initialize all header values for this version and call the screen's initialization. """
        self._screen.initialize(self._memory, self._stack)

    @abstractmethod
    def terminate(self):
        """ Free up all resources use by the interpreter. """
        self._screen.terminate()

    @property
    def pc(self) -> int:
        """ Current value of the PC """
        return self._pc

    @property
    def stack(self) -> ZMachineStack:
        return self._stack

    @property
    def object_table(self) -> ZMachineObjectTable:
        return self._obj_table

    @property
    def variables(self) -> ZMachineVariables:
        return self._variables

    def step(self, address: int = None):
        """ Execute a single instruction.

        If an address is provided, the PC is reset to that address before executing the instruction.

        If the `quit` instruction is found, then ZMachineExitException is raised.

        :param address: Address of the instruction to execute or the current PC if None.
        :raises ZMachineExitException: When the `quit` instruction is executed
        :raises ZMachineResetException: When the `restart` instruction is executed
        :raises ZMachineRuntimeException: When an unexpected error occurs
        """
        if address is not None:
            self._pc = address

        start_pc = self._pc

        try:
            opcode_and_operands, next_pc = self._opcode__parser.parse(self._pc)
            self._pc = next_pc

            opcode_method_name = '_opcode__' + opcode_and_operands.opcode

            if not hasattr(self, opcode_method_name):
                raise ZMachineUndefinedInstruction(f'The instruction `{opcode_and_operands.opcode}` is not defined for this interpreter.')
            else:
                self._operands = opcode_and_operands.operands
                self._operand_types = opcode_and_operands.operand_types

                # Call the opcode's handler method
                self.__getattribute__(opcode_method_name)()
        except (ZMachineExitException, ZMachineResetException) as e:
            # These exceptions are expected so just reraise them
            raise e
        except Exception as e:
            # Any other exception should be wrapped in a ZMachineRuntimeException
            raise e
            # raise ZMachineRuntimeException(self, start_pc) from e

    def run(self, breakpoint_pc: int = None):
        """ Run the Z-machine from the current PC until the machine quits.

        :param breakpoint_pc: If set, return from this method when the PC is equal to `breakpoint_pc`
        :raises ZMachineExitException: When the `quit` instruction is executed
        :raises ZMachineResetException: When the `restart` instruction is executed
        :raises ZMachineRuntimeException: When an unexpected error occurs
        """
        while True:
            self.step()

            if self._pc == breakpoint_pc:
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
            self._pc += 1
        else:
            # If bit 6 is set then the offset is a 14-bit signed int, using the rest of the bits in
            # this byte and all of the the next byte. Since we can only address 8 or 16 bit numbers the
            # predicate and number type bits need to be padded with the same value as the sign bit.
            if is_bit_set(self._memory, self._pc, 5):
                # Pad with 1's since this is a negative number
                first_branch_byte |= 0b1110_0000
            else:
                # Pad with 0's since this is a positive number
                first_branch_byte &= 0b0001_1111

            next_branch_byte = self._memory[self._pc + 1]
            self._pc += 2

            offset = read_signed_word(bytes([first_branch_byte, next_branch_byte]))

        return predicate, offset

    def _read_string_literal(self) -> str:
        """ Reads a literal string after and instruction and increment PC

        :return: String read after current instruction
        """
        string, next_pc = z_string_to_str_with_next(self._memory, self._pc, self._header.abbreviations_table_address)
        self._pc = next_pc
        return string

    def _operand_bytes(self, operand_num: int) -> bytes:
        """ Return the bytes of constant operands, or the bytes value of variable operand.

        :param operand_num:
        :return:
        """
        bytes_val = self._operands[operand_num]

        if self._operand_types[operand_num] == ZMachineOperandTypes.VARIABLE:
            bytes_val = self._variables.val(int.from_bytes(bytes_val, 'big', signed=False))

        return bytes_val

    def _operand_val(self, operand_num: int) -> int:
        """ Read the value of an operand as an integer.

        If the operand is a variable type then it is read from global/local vars or the stack.

        :param operand_num:
        :return:
        """
        val = self._operand_bytes(operand_num)

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
        val = self._operand_bytes(operand_num)

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

    # -------- Instructions are all defined below and executed via reflection --------
    # Opcode method name convention is '_opcode__' + name of opcode

    # --- 0OP instructions ---

    def _opcode__rtrue(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(1))
        self._pc = next_pc

    def _opcode__rfalse(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(0))
        self._pc = next_pc

    def _opcode__print(self):
        string = self._read_string_literal()
        self._screen.print(string)

    def _opcode__print_ret(self):
        string = self._read_string_literal()
        self._screen.print(string + '\n')

        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, word(1))
        self._pc = next_pc

    def _opcode__nop(self):
        pass

    def _opcode__restart(self):
        raise ZMachineResetException()

    def _opcode__ret_popped(self):
        ret_val = self._stack.pop()
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ret_val)
        self._pc = next_pc

    def _opcode__quit(self):
        # When the quit instruction is executed, simply raise the exit exception.
        raise ZMachineExitException()

    def _opcode__new_line(self):
        self._screen.print('\n')

    # 1OP instructions

    def _opcode__jz(self):
        predicate_type, offset = self._read_branch()
        self._handle_branch(self._operand_val(0) == 0, predicate_type, offset)

    def _opcode__get_sibling(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.sibling))
        self._handle_branch(obj.sibling != 0, predicate_type, offset)

    def _opcode__get_child(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.child))
        self._handle_branch(obj.child != 0, predicate_type, offset)

    def _opcode__get_parent(self):
        res_var = self._read_res_var()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._variables.set(res_var, word(obj.parent))

    def _opcode__get_prop_len(self):
        res_var = self._read_res_var()

        prop_addr = self._operand_val(0)
        prop_data = self._obj_table.property_at(prop_addr)
        self._variables.set(res_var, word(prop_data.size))

    def _opcode__inc(self):
        var_num = self._signed_operand_val(0)
        cur_val = read_word(self._variables.val(var_num))
        self._variables.set(var_num, word(cur_val + 1))

    def _opcode__dec(self):
        var_num = self._signed_operand_val(0)
        cur_val = read_word(self._variables.val(var_num))
        self._variables.set(var_num, word(cur_val - 1))

    def _opcode__print_addr(self):
        zstr_addr = self._operand_val(0)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__remove_obj(self):
        obj_num = self._operand_val(0)
        self._obj_table.remove_obj_from_parent(obj_num)

    def _opcode__print_obj(self):
        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num)
        self._screen.print(obj.properties.name)

    def _opcode__ret(self):
        ret_val = self._operand_bytes(0)
        next_pc, res_var = self._stack.pop_routine_call()
        self._variables.set(res_var, ret_val)
        self._pc = next_pc

    def _opcode__jump(self):
        offset = self._signed_operand_val(0)
        # The two bytes of operands need to be accounted for
        self._pc += (offset - 2)

    def _opcode__print_paddr(self):
        packed_addr = self._operand_val(0)
        zstr_addr = self.expanded_packed_address(packed_addr)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__load(self):
        res_var = self._read_res_var()
        val = self._operand_bytes(0)
        self._variables.set(res_var, val)

    # 2OP instructions

    def _opcode__je(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._operand_val(0)
        op_1 = self._operand_val(1)
        self._handle_branch(op_0 == op_1, predicate_type, offset)

    def _opcode__jl(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._signed_operand_val(0)
        op_1 = self._signed_operand_val(1)
        self._handle_branch(op_0 < op_1, predicate_type, offset)

    def _opcode__jg(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._signed_operand_val(0)
        op_1 = self._signed_operand_val(1)
        self._handle_branch(op_0 > op_1, predicate_type, offset)

    def _opcode__dec_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operand_val(0)
        cmp_val = self._signed_operand_val(1)
        val = read_signed_word(self._variables.val(var_num))
        val -= 1
        self._variables.set(var_num, signed_word(val))
        self._handle_branch(val < cmp_val, predicate_type, offset)

    def _opcode__inc_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operand_val(0)
        cmp_val = self._signed_operand_val(1)
        val = read_signed_word(self._variables.val(var_num))
        val += 1
        self._variables.set(var_num, signed_word(val))
        self._handle_branch(val > cmp_val, predicate_type, offset)

    def _opcode__jin(self):
        predicate_type, offset = self._read_branch()
        child_obj_num = self._operand_val(0)
        parent_obj_num = self._operand_val(1)
        obj = self._obj_table.object(child_obj_num)
        self._handle_branch(obj.parent == parent_obj_num, predicate_type, offset)

    def _opcode__test(self):
        predicate_type, offset = self._read_branch()
        bitmap = self._operand_val(0)
        flags = self._operand_val(1)
        self._handle_branch((bitmap & flags) == flags, predicate_type, offset)

    def _opcode__or(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)
        self._variables.set(res_var, word(a | b))

    def _opcode__and(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)
        self._variables.set(res_var, word(a & b))

    def _opcode__test_attr(self):
        predicate_type, offset = self._read_branch()
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        self._handle_branch(obj.is_attribute_set(attr_num), predicate_type, offset)

    def _opcode__set_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, True)

    def _opcode__clear_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, False)

    def _opcode__store(self):
        var_num = self._operand_val(0)
        val = self._operand_val(1)
        self._variables.set(var_num, word(val))

    def _opcode__insert_obj(self):
        obj_num = self._operand_val(0)
        parent_obj_num = self._operand_val(1)
        self._obj_table.insert_child(obj_num, parent_obj_num)

    def _opcode__loadw(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0)
        word_idx = self._operand_val(1)
        ret_word = read_word(self._memory, arr_addr + (2 * word_idx))
        self._variables.set(res_var, word(ret_word))

    def _opcode__loadb(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0)
        byte_idx = self._operand_val(1)
        ret_byte = self._memory[arr_addr + byte_idx]
        self._variables.set(res_var, word(ret_byte))

    def _opcode__get_prop(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num)
        prop_val = obj.properties.property_val(prop_num)

        if len(prop_val) == 1:
            # Pad with 00 if property is only one byte long
            prop_val = b'\x00' + prop_val

        self._variables.set(res_var, prop_val)

    def _opcode__get_prop_addr(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)

        obj = self._obj_table.object(obj_num)
        prop_addr = obj.properties.own_property_address(prop_num)

        if prop_addr is None:
            prop_addr = 0

        self._variables.set(res_var, word(prop_addr))

    def _opcode__get_next_prop(self):
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

    def _opcode__add(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a + b))

    def _opcode__sub(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(b - a))

    def _opcode__mul(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a * b))

    def _opcode__div(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a // b))

    def _opcode__mod(self):
        res_var = self._read_res_var()
        a = self._signed_operand_val(0)
        b = self._signed_operand_val(1)
        self._variables.set(res_var, signed_word(a % b))

    # VAR OP instructions

    def _opcode__storew(self):
        arr_addr = self._operand_val(0)
        word_i = self._operand_val(1)
        value = self._operand_val(2)
        write_word(self._memory, arr_addr + (word_i * 2), value)

    def _opcode__storeb(self):
        arr_addr = self._operand_val(0)
        byte_i = self._operand_val(1)
        value = self._operand_bytes(2)

        # If the value is from a variable it will be 2 bytes, only store the LSB
        if len(value) == 2:
            value = value[1]
        else:
            # The value is a single byte so convert it to an int for memoryview
            value = int.from_bytes(value, 'big')

        self._memory[arr_addr + byte_i] = value

    def _opcode__put_prop(self):
        obj_num = self._operand_val(0)
        prop_num = self._operand_val(1)
        value = self._operand_bytes(2)

        obj = self._obj_table.object(obj_num)
        obj.properties.set_own_property(prop_num, value)

    def _opcode__print_char(self):
        char = self._operand_val(0)
        self._screen.print(chr(char))

    def _opcode__print_num(self):
        num = self._signed_operand_val(0)
        self._screen.print(str(num))

    def _opcode__random(self):
        res_var = self._read_res_var()
        rnd_range = self._signed_operand_val(0)

        if rnd_range == 0:
            # Reseed generator with a random seed
            random.seed()
        elif rnd_range < 0:
            # Seed generator with the operand value and return 0
            random.seed(rnd_range)
            self._variables.set(res_var, word(0))
        else:
            rnd_num = random.randint(1, rnd_range)
            self._variables.set(res_var, rnd_num)

    def _opcode__push(self):
        val = self._operand_bytes(0)
        self._stack.push(val)

    def _sound_effect(self):
        # TODO #11: Figure out how routing out sound is going to work
        pass


class ZMachineInterpreterV3(ZMachineInterpreter):

    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen, keyboard: ZMachineInput):
        assert header.version == 3, 'invalid z-code version for version interpreter'
        super().__init__(header, memory, screen, keyboard)

    def terminate(self):
        super().terminate()

    def save_handler(self, save_data: bytes) -> bool:
        pass

    def restore_handler(self) -> Union[bytes, None]:
        pass

    def initialize(self):
        super().initialize()
        self._header.is_file_split = False
        self._header.is_transcription_on = False

    @staticmethod
    def expanded_packed_address(packed_address: int) -> int:
        return packed_address * 2

    # Version 3 specific opcodes

    def _opcode__not(self):
        # This is technically an unsigned operation, but using signed numbers to
        # leverage Python's concept of an integer. Without using signed numbers
        # the result of the operation may not fit in 16 bits
        res_var = self._read_res_var()
        val = self._signed_operand_val(0)
        self._variables.set(res_var, signed_word(~val))

    def _opcode__save(self):
        predicate_type, offset = self._read_branch()
        # TODO #12: Implement save game state
        success = self.save_handler(bytes([]))
        self._handle_branch(success == predicate_type, offset)

    def _opcode__restore(self):
        predicate_type, offset = self._read_branch()
        # TODO #12: Implement restore game state
        restore_data = self.restore_handler()

    def _opcode__pop(self):
        self._stack.pop()

    def _opcode__show_status(self):
        self._screen.is_status_displayed = True

    def _opcode__verify(self):
        # Technically supposed to verify the integrity of the game file, but not doing it
        pass

    def _opcode__call(self):
        # The first operand contains the packed address of the routine to call.
        routine_address = self.expanded_packed_address(self._operand_val(0))

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

    def _opcode__sread(self):
        text_buffer_address = self._operand_val(0)
        parse_buffer_address = self._operand_val(1)

        # The max number of characters to read is in the first byte of the text buffer
        max_chars = self._memory[text_buffer_address]
        text = self._keyboard.read_string(max_chars)

        # Put text into text buffer as ascii
        for i in range(len(text)):
            self._memory[text_buffer_address + 1 + i] = ord(text[i])

        # null-terminate the string
        self._memory[text_buffer_address + 1 + len(text)] = 0

        # tokenize
        tokenize(self._memory, self._dictionary, text_buffer_address, parse_buffer_address)

    def _opcode__pull(self):
        res_var = self._operand_val(0)
        val = self._stack.pop()
        self._variables.set(res_var, val)

    def _opcode__split_window(self):
        # TODO #9 : Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _opcode__set_window(self):
        # TODO #9 : Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _output_stream(self):
        # TODO #10: Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _input_stream(self):
        # TODO #10: Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')



class ZMachineExitException(ZMachineException):
    """ Raised then the z-machine `quit` instruction is executed. """
    pass


class ZMachineUndefinedInstruction(ZMachineException):
    """ Raised when an undefined instruction is attempted to be executed """
    pass


class ZMachineResetException(ZMachineException):
    """ Raised when the z-machine would like to restart itself """
    pass


class ZMachineRuntimeException(ZMachineException):
    """ Raised while the z-machine is running and an exception occurs.

    The exception that was thrown is wrapped in this exception
    """
    def _init_(self, interpreter: ZMachineInterpreter, instruction_pc: int):
        """
        :param interpreter: Interpreter which raised the exception
        :param instruction_pc: PC of the currently executing instruction
        """

        self._interpreter = interpreter
        self._instruction_pc = instruction_pc

    @property
    def interpreter(self) -> ZMachineInterpreter:
        return self._interpreter

    @property
    def instruction_pc(self) -> int:
        return self._instruction_pc
