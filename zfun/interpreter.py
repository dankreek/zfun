import random
from abc import ABC, abstractmethod
from typing import Union, Tuple

from .data_structures import ZWord, ZByte, ZData, PC
from .dictionary import ZMachineDictionary
from .exc import ZMachineIllegalOperation, ZMachineException
from .header import ZCodeHeader
from .input import ZMachineInput
from .opcodes import ZMachineOpcodeParserV3, ZMachineOperandTypes
from .objects import ZMachineObjectTable
from .screen import ZMachineScreen
from .stack import ZMachineStack
from .tokenize import tokenize
from .util import is_bit_set
from .variables import ZMachineVariables
from .z_string import z_string_to_str, z_string_to_str_with_next


class ZMachineInterpreter(ABC):
    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen, keyboard: ZMachineInput):
        self._header = header
        self._memory = memory
        self._screen = screen
        self._keyboard = keyboard
        self._step_count = 0

        self._stack = ZMachineStack()
        self._pc: PC = PC(header.initial_pc_value)

        # TODO: Read the version from the header to instantiate this
        self._opcode_parser = ZMachineOpcodeParserV3(memory)
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
        self._screen.initialize(self)

    @abstractmethod
    def terminate(self):
        """ Free up all resources use by the interpreter. """
        self._screen.terminate()

    @property
    def pc(self) -> PC:
        """ Current value of the PC """
        return self._pc

    @property
    def header(self) -> ZCodeHeader:
        return self._header

    @property
    def step_count(self) -> int:
        return self._step_count

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
            self._pc = PC(address)

        start_pc = self._pc

        try:
            opcode_and_operands, next_pc = self._opcode_parser.parse(self._pc)
            self._pc = next_pc

            opcode_method_name = '_opcode__' + opcode_and_operands.opcode

            if not hasattr(self, opcode_method_name):
                raise ZMachineUndefinedInstruction(f'The instruction `{opcode_and_operands.opcode}` is not defined for this interpreter.')
            else:
                self._operands = opcode_and_operands.operands
                self._operand_types = opcode_and_operands.operand_types

                # Call the opcode's handler method
                self.__getattribute__(opcode_method_name)()

                self._step_count += 1
        except (ZMachineExitException, ZMachineResetException) as e:
            # These exceptions are expected so just reraise them
            raise e
        except Exception as e:
            # Any other exception should be wrapped in a ZMachineRuntimeException
            raise ZMachineRuntimeException(self, start_pc) from e

    def run(self, breakpoint_pc: int = None):
        """ Run the Z-machine from the current PC until the machine quits.

        :param breakpoint_pc: If set, return from this method when the PC is equal to `breakpoint_pc`
        :raises ZMachineExitException: When the `quit` instruction is executed
        :raises ZMachineResetException: When the `restart` instruction is executed
        :raises ZMachineRuntimeException: When an unexpected error occurs
        """
        while True:
            self.step()

            if (breakpoint_pc is not None) and (self._pc == breakpoint_pc):
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
    def expanded_packed_address(packed_address: ZWord) -> int:
        """ Expand a packed address for the implementing version of the interpreter.

        :param packed_address: Address in packed form.
        :return: The packed_address expanded to be the actual address.
        """
        pass

    def _read_res_var(self) -> ZByte:
        """ Read a single byte at the PC, advance the PC and return the result variable number. """
        res_var = ZByte.read(self._memory, int(self._pc))
        self._pc += 1
        return res_var

    # XXX: Use ZData types internally
    def _read_branch(self) -> Tuple[bool, ZData]:
        """ Read a branch predicate and location after decoding a branch instruction.

        See section 4.7 of the Z-Machine Standards Document.

        :return: True if branch should happen on a true condition, and the offset of the branch if predicate is satisfied.
        """
        first_branch_byte = self._memory[int(self._pc)]

        # If bit 7 is set, the predicate is a True type
        if is_bit_set(self._memory, int(self._pc), 7):
            predicate = True
        else:
            predicate = False

        # If bit 6 is set, then the offset is an unsigned 6-bit number
        if is_bit_set(self._memory, int(self._pc), 6):
            # Mask off the predicate and number type bits
            offset = ZByte.from_unsigned_int(first_branch_byte & 0b0011_1111)
            self._pc += 1
        else:
            # If bit 6 is set then the offset is a 14-bit signed int, using the rest of the bits in
            # this byte and all of the the next byte. Since we can only address 8 or 16 bit numbers the
            # predicate and number type bits need to be padded with the same value as the sign bit.
            if is_bit_set(self._memory, int(self._pc), 5):
                # Pad with 1's since this is a negative number
                first_branch_byte |= 0b1110_0000
            else:
                # Pad with 0's since this is a positive number
                first_branch_byte &= 0b0001_1111

            next_branch_byte = self._memory[int(self._pc) + 1]
            self._pc += 2

            offset = ZWord(bytes([first_branch_byte, next_branch_byte]))

        return predicate, offset

    def _read_string_literal(self) -> str:
        """ Reads a literal string after and instruction and increment PC

        :return: String read after current instruction
        """
        string, next_pc = z_string_to_str_with_next(self._memory, int(self._pc), self._header.abbreviations_table_address)
        self._pc = PC(next_pc)
        return string

    def _operand_val(self, operand_num: int) -> ZData:
        """ Return the value of an operand.

        If the operand is a literal value just return it.
        If the operand is a variable type then it is read from global/local vars or the stack.

        :param operand_num:
        :return:
        """
        if self._operand_types[operand_num] == ZMachineOperandTypes.VARIABLE:
            return self._variables.val(self._operands[operand_num])
        else:
            return self._operands[operand_num]

    def _handle_branch(self, branch_pred: bool, pred_type: bool, offset: ZData):
        if branch_pred == pred_type:
            # In the case where an offset is 0 or 1, return false or true from the current routine
            if (offset.int == 0) or (offset.int == 1):
                ret_pc, res_var = self._stack.pop_routine_call()
                self._variables.set(res_var, offset)
                self._pc = ret_pc
            else:
                self._pc = self._pc + offset.dec(2).int

    # -------- Instructions are all defined below and executed via reflection --------
    # Opcode method name convention is '_opcode__' + name of opcode

    # --- 0OP instructions ---

    def _opcode__rtrue(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(1))
        self._pc = next_pc

    def _opcode__rfalse(self):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(0))
        self._pc = next_pc

    def _opcode__print(self):
        string = self._read_string_literal()
        self._screen.print(string)

    def _opcode__print_ret(self):
        string = self._read_string_literal()
        self._screen.print(string + '\n')

        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(1))
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
        self._handle_branch(self._operand_val(0).int == 0, predicate_type, offset)

    def _opcode__get_sibling(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num.unsigned_int)
        self._variables.set(res_var, ZWord.from_unsigned_int(obj.sibling))
        self._handle_branch(obj.sibling != 0, predicate_type, offset)

    def _opcode__get_child(self):
        res_var = self._read_res_var()
        predicate_type, offset = self._read_branch()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num.unsigned_int)
        self._variables.set(res_var, ZWord.from_unsigned_int(obj.child))
        self._handle_branch(obj.child != 0, predicate_type, offset)

    def _opcode__get_parent(self):
        res_var = self._read_res_var()

        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num.unsigned_int)
        self._variables.set(res_var, ZWord.from_unsigned_int(obj.parent))

    def _opcode__get_prop_len(self):
        res_var = self._read_res_var()
        prop_addr = self._operand_val(0)

        if prop_addr.int == 0:
            prop_size = 0
        else:
            # XXX: This still looks really weird
            prop_size = self._obj_table.property_at(prop_addr.unsigned_int - 1).size

        self._variables.set(res_var, ZWord.from_unsigned_int(prop_size))

    def _opcode__inc(self):
        var_num = ZByte(self._operand_val(0))
        cur_val = self._variables.val(var_num)
        self._variables.set(var_num, cur_val.inc())

    def _opcode__dec(self):
        var_num = ZByte(self._operand_val(0))
        cur_val = self._variables.val(var_num)
        self._variables.set(var_num, cur_val.dec())

    def _opcode__print_addr(self):
        zstr_addr = self._operand_val(0)
        string = z_string_to_str(self._memory, zstr_addr.unsigned_int, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__remove_obj(self):
        obj_num = self._operand_val(0)
        self._obj_table.remove_obj_from_parent(obj_num.unsigned_int)

    def _opcode__print_obj(self):
        obj_num = self._operand_val(0)
        obj = self._obj_table.object(obj_num.unsigned_int)
        self._screen.print(obj.name)

    def _opcode__ret(self):
        ret_val = self._operand_val(0)
        next_pc, res_var = self._stack.pop_routine_call()
        self._variables.set(res_var, ret_val)
        self._pc = next_pc

    def _opcode__jump(self):
        offset = self._operand_val(0)
        # The two bytes of operands need to be accounted for
        self._pc += offset.dec(2).int

    def _opcode__print_paddr(self):
        packed_addr = ZWord(self._operand_val(0))
        zstr_addr = self.expanded_packed_address(packed_addr)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__load(self):
        res_var = self._read_res_var()
        val = self._operand_val(0)
        self._variables.set(res_var, val)

    # 2OP instructions

    def _opcode__je(self):
        predicate_type, offset = self._read_branch()
        compare = self._operand_val(0)
        operand_vals = [self._operand_val(i) for i in range(1, len(self._operands))]

        for i in range(len(operand_vals)):
            # It looks like Byte vals are truncated with 0's instead of signed
            if compare.unsigned_int == operand_vals[i].unsigned_int:
                self._handle_branch(True, predicate_type, offset)
                return

        self._handle_branch(False, predicate_type, offset)

    def _opcode__jl(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._operand_val(0)
        op_1 = self._operand_val(1)
        self._handle_branch(op_0.int < op_1.int, predicate_type, offset)

    def _opcode__jg(self):
        predicate_type, offset = self._read_branch()
        op_0 = self._operand_val(0)
        op_1 = self._operand_val(1)
        self._handle_branch(op_0.int > op_1.int, predicate_type, offset)

    def _opcode__dec_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operands[0]
        cmp_val = self._operand_val(1)

        # Read variable value, decrement it and write it back
        dec_val = self._variables.val(var_num).dec()
        self._variables.set(var_num, dec_val)

        self._handle_branch(dec_val.int < cmp_val.int, predicate_type, offset)

    def _opcode__inc_chk(self):
        predicate_type, offset = self._read_branch()
        var_num = self._operands[0]
        cmp_val = self._operand_val(1)

        # Read variable value, decrement it and write it back
        dec_val = self._variables.val(var_num).inc()
        self._variables.set(var_num, dec_val)

        self._handle_branch(dec_val.int > cmp_val.int, predicate_type, offset)

    def _opcode__jin(self):
        predicate_type, offset = self._read_branch()
        child_obj_num = self._operand_val(0)
        parent_obj_num = self._operand_val(1).unsigned_int
        obj = self._obj_table.object(child_obj_num.unsigned_int)
        self._handle_branch(obj.parent == parent_obj_num, predicate_type, offset)

    def _opcode__test(self):
        predicate_type, offset = self._read_branch()
        bitmap = self._operand_val(0)
        flags = self._operand_val(1)

        if type(flags) == ZByte:
            flags = flags.pad()

        self._handle_branch((bitmap & flags.unsigned_int) == flags, predicate_type, offset)

    def _opcode__or(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1).unsigned_int
        self._variables.set(res_var, a | b)

    def _opcode__and(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1).unsigned_int

        self._variables.set(res_var, a & b)

    def _opcode__test_attr(self):
        predicate_type, offset = self._read_branch()
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num.unsigned_int)
        self._handle_branch(obj.is_attribute_set(attr_num.unsigned_int), predicate_type, offset)

    def _opcode__set_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num.unsigned_int)
        obj.update_attribute(attr_num.unsigned_int, True)

    def _opcode__clear_attr(self):
        obj_num = self._operand_val(0)
        attr_num = self._operand_val(1)
        obj = self._obj_table.object(obj_num.unsigned_int)
        obj.update_attribute(attr_num.unsigned_int, False)

    def _opcode__store(self):
        var_num = self._operands[0]
        val = self._operand_val(1)
        self._variables.set(var_num, val)

    def _opcode__insert_obj(self):
        obj_num = self._operand_val(0).unsigned_int
        parent_obj_num = self._operand_val(1).unsigned_int
        self._obj_table.insert_child(obj_num, parent_obj_num)

    def _opcode__loadw(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0).unsigned_int
        word_idx = self._operand_val(1).unsigned_int
        word_addr = arr_addr + (word_idx * 2)
        ret_word = ZWord.read(self._memory, word_addr)
        self._variables.set(res_var, ret_word)

    def _opcode__loadb(self):
        res_var = self._read_res_var()
        arr_addr = self._operand_val(0).unsigned_int
        byte_idx = self._operand_val(1).unsigned_int
        byte_addr = arr_addr + byte_idx
        ret_byte = ZByte.read(self._memory, byte_addr)
        self._variables.set(res_var, ret_byte)

    def _opcode__get_prop(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0).unsigned_int
        prop_num = self._operand_val(1).unsigned_int
        obj = self._obj_table.object(obj_num)
        prop_val = obj.properties.value_or_default(prop_num)
        self._variables.set(res_var, prop_val)

    def _opcode__get_prop_addr(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0).unsigned_int
        prop_num = self._operand_val(1).unsigned_int

        obj = self._obj_table.object(obj_num)
        prop_address = obj.properties.get(prop_num).value_address

        if prop_address is not None:
            self._variables.set(res_var, ZWord.from_unsigned_int(prop_address))
        else:
            self._variables.set(res_var, ZWord.from_int(0))

    def _opcode__get_next_prop(self):
        res_var = self._read_res_var()
        obj_num = self._operand_val(0).unsigned_int
        prop_num = self._operand_val(1).unsigned_int

        obj = self._obj_table.object(obj_num)

        if prop_num == 0:
            prop_info = obj.properties.first_property()
        else:
            prop_info = obj.properties.get(prop_num)

        if prop_info is None:
            raise ZMachineIllegalOperation(f'property #{prop_num} does not exist for object #{obj_num}')

        next_prop = self._obj_table.property_at(prop_info.next_property_address)

        if next_prop is None:
            next_prop_num = 0
        else:
            next_prop_num = next_prop.number

        self._variables.set(res_var, ZWord.from_unsigned_int(next_prop_num))

    def _opcode__add(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        self._variables.set(res_var, a + b)

    def _opcode__sub(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        self._variables.set(res_var, a - b)

    def _opcode__mul(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        self._variables.set(res_var, a * b)

    def _opcode__div(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        self._variables.set(res_var, a // b)

    def _opcode__mod(self):
        res_var = self._read_res_var()
        a = self._operand_val(0)
        b = self._operand_val(1)

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        self._variables.set(res_var, a % b)

    # VAR OP instructions

    def _opcode__storew(self):
        arr_addr = self._operand_val(0).unsigned_int
        word_offset = self._operand_val(1).unsigned_int * 2
        value = self._operand_val(2)

        if type(value) == ZByte:
            value = value.pad()

        address = arr_addr + word_offset

        if address >= self._header.static_memory_address:
            raise ZMachineIllegalOperation('attempt to write to static memory')

        value.write(self._memory, address)

    def _opcode__storeb(self):
        arr_addr = self._operand_val(0).unsigned_int
        byte_offset = self._operand_val(1).unsigned_int
        value = self._operand_val(2)

        address = arr_addr + byte_offset

        if address >= self._header.static_memory_address:
            raise ZMachineIllegalOperation('attempt to write to static memory')

        value.write(self._memory, address)

    def _opcode__put_prop(self):
        obj_num = self._operand_val(0).unsigned_int
        prop_num = self._operand_val(1).unsigned_int
        value = self._operand_val(2)

        obj = self._obj_table.object(obj_num)
        obj.properties.set(prop_num, value)

    def _opcode__print_char(self):
        char = self._operand_val(0)
        self._screen.print(chr(char.unsigned_int))

    def _opcode__print_num(self):
        num = self._operand_val(0)
        self._screen.print(str(num.int))

    def _opcode__random(self):
        res_var = self._read_res_var()
        rnd_range = self._operand_val(0).int

        if rnd_range == 0:
            # Reseed generator with a random seed
            random.seed()
        elif rnd_range < 0:
            # Seed generator with the operand value and return 0
            random.seed(rnd_range)
            self._variables.set(res_var, ZWord.from_int(0))
        else:
            rnd_num = ZWord.from_int(random.randint(1, rnd_range))
            self._variables.set(res_var, rnd_num)

    def _opcode__push(self):
        val = self._operand_val(0)
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
    def expanded_packed_address(packed_address: ZWord) -> int:
        return packed_address.unsigned_int << 1

    # Version 3 specific opcodes

    def _opcode__not(self):
        # This is technically an unsigned operation, but using signed numbers to
        # leverage Python's concept of an integer. Without using signed numbers
        # the result of the operation may not fit in 16 bits
        res_var = self._read_res_var()
        val = self._operand_val(0)
        self._variables.set(res_var, ~val)

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
        self._screen.update_status()

    def _opcode__verify(self):
        # Technically supposed to verify the integrity of the game file, but not doing it
        pass

    def _opcode__call(self):
        packed_address = ZWord(self._operand_val(0))

        # The first operand contains the packed address of the routine to call.
        routine_address = self.expanded_packed_address(packed_address)

        # The first byte of the routine header contains the number of local variables the routine has
        local_vars_count = self._memory[routine_address]

        # Each local variable's initial value is stored in the words following the word count byte
        initial_local_var_values = [
            ZWord.read(self._memory, routine_address + 1 + (i * 2))
            for i in range(local_vars_count)
        ]

        # The additional operands of the call opcode are set in the new local vars
        for local_var_num in range(len(self._operands) - 1):
            initial_local_var_values[local_var_num] = self._operand_val(local_var_num+1)

        # The return value the variable number is stored in the byte after the operands
        res_var = self._read_res_var()

        if routine_address == 0:
            self._variables.set(res_var, ZWord.from_int(0))
        else:
            # Add new frame to the stack for this routine
            self._stack.push_routine_call(self._pc, local_vars_count, res_var, *initial_local_var_values)

            # The address of the first instruction is directly after all the parameters
            self._pc = PC(routine_address + 1 + (local_vars_count * 2))

    def _opcode__sread(self):
        text_buffer_address = self._operand_val(0).unsigned_int
        parse_buffer_address = self._operand_val(1).unsigned_int

        # The max number of characters to read is in the first byte of the text buffer
        max_chars = ZByte.read(self._memory, text_buffer_address).unsigned_int
        text = self._keyboard.read_string(max_chars)

        if text_buffer_address >= self._header.static_memory_address:
            raise ZMachineIllegalOperation('attempt to write to static memory')

        # Put text into text buffer as ascii
        for i in range(len(text)):
            ZByte.from_unsigned_int(ord(text[i])).write(self._memory, text_buffer_address + 1 + i)

        # null-terminate the string
        ZByte(b'\x00').write(self._memory, text_buffer_address + 1 + len(text))

        # tokenize
        tokenize(self._memory, self._dictionary, text_buffer_address, parse_buffer_address)

    def _opcode__pull(self):
        res_var = ZByte(self._operand_val(0))
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
    def _init_(self, interpreter: ZMachineInterpreter, instruction_pc: PC):
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
    def instruction_pc(self) -> PC:
        return self._instruction_pc
