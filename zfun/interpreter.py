import random
from abc import ABC, abstractmethod
from typing import Tuple, Optional, NamedTuple

from .data_structures import ZWord, ZByte, ZData, PC
from .dictionary import ZMachineDictionary
from .exc import ZMachineIllegalOperation, ZMachineException
from .header import ZCodeHeader
from .input import ZMachineInput
from .opcodes import ZMachineOpcodeParserV3, ZMachineOperandTypes, ZMachineLabel
from .objects import ZMachineObjectTable
from .quetzal import HeaderQuetzalChunk, UMemQuetzalChunk, CMemQuetzalChunk, StacksQuetzalChunk, IFZSContainer, QuetzalReadError, IFZSReadError
from .screen import ZMachineScreen
from .stack import ZMachineStack
from .tokenize import tokenize
from .variables import ZMachineVariables
from .z_string import z_string_to_str, z_string_to_str_with_next


class ZMachineSaveRestoreHandler(ABC):

    @abstractmethod
    def save(self, save_data: bytes):
        """ Save the provided save game data.

        :param save_data:
        :return: True if successful, False if a known failure occured
        """
        pass

    @abstractmethod
    def restore(self) -> bytes:
        """ Provide interpreter with a restored game.

        If a known error occurs, return None.

        :return: Save data for the game
        """
        pass

    @abstractmethod
    def invalid_restore_game(self, error_message: str):
        """ Called when the provided restore data is valid but is for a different game. """
        pass

    @abstractmethod
    def invalid_restore_data(self, error_message: str):
        """ Called when the provided restore data is an invalid save file """
        pass


class Operand(NamedTuple):
    """ Operand type, long, short or variable """
    data_type: ZMachineOperandTypes

    """ The literal value of the operand """
    literal_value: ZData

    """ Either the literal value of a constant, or the resolved value of a variable """
    value: ZData


class ZMachineInterpreter(ABC):
    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen, keyboard: ZMachineInput, save_restore: ZMachineSaveRestoreHandler):
        self._header = header
        self._memory = memory
        self._original_memory = bytes(memory)
        self._screen = screen
        self._keyboard = keyboard
        self._save_restore = save_restore
        self._step_count = 0

        # The result variable for the currently executing opcode method
        self._res_var: Optional[ZByte] = None

        # The branch label for the current executing opcode method
        self._branch_label: Optional[ZMachineLabel] = None

        self._stack = ZMachineStack()
        self._pc: PC = PC(header.initial_pc_value)
        self._start_pc: PC = self._pc

        # TODO: Read the version from the header to instantiate this
        self._opcode_parser = ZMachineOpcodeParserV3(memory)
        self._dictionary = ZMachineDictionary(memory, header)
        self._variables = ZMachineVariables(memory, header, self._stack)
        self._obj_table = ZMachineObjectTable(memory, header)

        # Store the operands and types for the currently executing instruction here
        # I wouldn't normally pass around arguments in global fashion but this is to better
        # simulate my later implementation for the Commodore 128, as well as simplify the signatures
        # for the opcode handling methods.
        self._operands = Optional[Tuple[bytes]]
        self._operand_types = Optional[Tuple[ZMachineOperandTypes]]

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

        self._start_pc = self._pc

        try:
            opcode, next_pc = self._opcode_parser.parse(self._pc)
            self._pc = next_pc

            opcode_method_name = '_opcode__' + opcode.name

            if not hasattr(self, opcode_method_name):
                raise ZMachineUndefinedInstruction(f'The instruction `{opcode.name}` is not defined for this interpreter.')
            else:
                # Resolve each variable operand and create a tuple of named tuples to pass into each handler method
                operands = tuple([
                    Operand(opcode.operand_types[i],
                            opcode.operands[i],
                            self._operand_val(opcode.operand_types[i], opcode.operands[i]))
                    for i in range(len(opcode.operands) if opcode.operands else 0)
                ])

                # Is this opcode a routine call?
                is_call = opcode.name.startswith('call')

                # Store the result variable in case any opcode methods need it (mostly call opcodes)
                self._res_var = opcode.result_var
                self._branch_label = opcode.label

                # XXX: Use the *operands form so that opcode method handler signatures reflect the number of operands they expect
                # Call the opcode's handler method
                res_val = self.__getattribute__(opcode_method_name)(operands)

                # XXX: if this is a branching instruction, check if the branch handler was called?

                # call opcodes don't actually return their result, it is stored on the stack instead
                if opcode.result_var is not None and not is_call:
                    if res_val is None:
                        raise ZMachineRuntimeException(f'The {opcode.name} opcode required a return value')
                    elif not issubclass(type(res_val), ZData):
                        raise ZMachineRuntimeException(f'Result returned from opcode {opcode.name} is not of type ZData')

                    self._variables.set(opcode.result_var, res_val)

                self._res_var = None
                self._step_count += 1

        except (ZMachineExitException, ZMachineResetException) as e:
            # These exceptions are expected so just reraise them
            raise e
        except Exception as e:
            # Any other exception should be wrapped in a ZMachineRuntimeException
            raise ZMachineRuntimeException(self, self._start_pc) from e

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

    @staticmethod
    @abstractmethod
    def expanded_packed_address(packed_address: ZWord) -> int:
        """ Expand a packed address for the implementing version of the interpreter.

        :param packed_address: Address in packed form.
        :return: The packed_address expanded to be the actual address.
        """
        pass

    def _read_string_literal(self) -> str:
        """ Reads a literal string after and instruction and increment PC

        :return: String read after current instruction
        """
        string, next_pc = z_string_to_str_with_next(self._memory, int(self._pc), self._header.abbreviations_table_address)
        self._pc = PC(next_pc)
        return string

    def _operand_val(self, operand_type: ZMachineOperandTypes, operand_literal_val: ZData) -> ZData:
        """ Return the value of an operand.

        If the operand is a literal value just return it.
        If the operand is a variable type then it is read from global/local vars or the stack.

        :param operand_type The type of operand to evaluate
        :param operand_literal_val: The literal value of the operand
        :return: Evaluated operand data
        """
        if operand_type == ZMachineOperandTypes.VARIABLE:
            return self._variables.val(ZByte(operand_literal_val))
        else:
            return operand_literal_val

    def _handle_branch(self, branch_pred: bool):
        if self._branch_label is None:
            raise ZMachineRuntimeException('no branch info for opcode')

        if branch_pred == self._branch_label.predicate_type:
            # In the case where an offset is 0 or 1, return false or true from the current routine
            if (self._branch_label.offset == 0) or (self._branch_label.offset == 1):
                ret_pc, res_var = self._stack.pop_routine_call()
                self._variables.set(res_var, ZWord.from_int(self._branch_label.offset))
                self._pc = ret_pc
            else:
                self._pc = self._pc + (self._branch_label.offset - 2)

    # -------- Instructions are all defined below and executed via reflection --------
    # Opcode method name convention is '_opcode__' + name of opcode

    # --- 0OP instructions ---

    def _opcode__rtrue(self, _):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(1))
        self._pc = next_pc

    def _opcode__rfalse(self, _):
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(0))
        self._pc = next_pc

    def _opcode__print(self, _):
        string = self._read_string_literal()
        self._screen.print(string)

    def _opcode__print_ret(self, _):
        string = self._read_string_literal()
        self._screen.print(string + '\n')

        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ZWord.from_int(1))
        self._pc = next_pc

    def _opcode__nop(self, _):
        pass

    def _opcode__restart(self, _):
        raise ZMachineResetException()

    def _opcode__ret_popped(self, _):
        ret_val = self._stack.pop()
        next_pc, ret_var = self._stack.pop_routine_call()
        self._variables.set(ret_var, ret_val)
        self._pc = next_pc

    def _opcode__quit(self, _):
        # When the quit instruction is executed, simply raise the exit exception.
        raise ZMachineExitException()

    def _opcode__new_line(self, _):
        self._screen.print('\n')

    # 1OP instructions

    def _opcode__jz(self, operands: Tuple[Operand]):
        self._handle_branch(operands[0].value.int == 0)

    def _opcode__get_sibling(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        self._handle_branch(obj.sibling != 0)
        return ZWord.from_unsigned_int(obj.sibling)

    def _opcode__get_child(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        self._handle_branch(obj.child != 0)
        return ZWord.from_unsigned_int(obj.child)

    def _opcode__get_parent(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        return ZWord.from_unsigned_int(obj.parent)

    def _opcode__get_prop_len(self, operands: Tuple[Operand]):
        prop_addr = operands[0].value.unsigned_int

        # TODO: Put this logic in the object table class?
        if prop_addr == 0:
            prop_size = 0
        else:
            if self._header.version <= 3:
                prop_addr -= 1
            else:
                if self._memory[prop_addr] & 128:
                    prop_addr -= 1
                else:
                    prop_addr -= 2

            prop_size = self._obj_table.property_at(prop_addr).size

        return ZWord.from_unsigned_int(prop_size)

    def _opcode__inc(self, operands: Tuple[Operand]):
        var_num = ZByte(operands[0].value)
        cur_val = self._variables.val(var_num)
        self._variables.set(var_num, cur_val.inc())

    def _opcode__dec(self, operands: Tuple[Operand]):
        var_num = ZByte(operands[0].value)
        cur_val = self._variables.val(var_num)
        self._variables.set(var_num, cur_val.dec())

    def _opcode__print_addr(self, operands: Tuple[Operand]):
        zstr_addr = operands[0].value
        string = z_string_to_str(self._memory, zstr_addr.unsigned_int, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__remove_obj(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        self._obj_table.remove_obj_from_parent(obj_num)

    def _opcode__print_obj(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        self._screen.print(obj.name)

    def _opcode__ret(self, operands: Tuple[Operand]):
        ret_val = operands[0].value
        next_pc, res_var = self._stack.pop_routine_call()
        self._variables.set(res_var, ret_val)
        self._pc = next_pc

    def _opcode__jump(self, operands: Tuple[Operand]):
        offset = operands[0].value
        # The two bytes of operands need to be accounted for
        self._pc += offset.dec(2).int

    def _opcode__print_paddr(self, operands: Tuple[Operand]):
        packed_addr = ZWord(operands[0].value)
        zstr_addr = self.expanded_packed_address(packed_addr)
        string = z_string_to_str(self._memory, zstr_addr, self._header.abbreviations_table_address)
        self._screen.print(string)

    def _opcode__load(self, operands: Tuple[Operand]):
        return operands[0].value

    # 2OP instructions

    def _opcode__je(self, operands: Tuple[Operand]):
        compare = operands[0].value
        operand_vals = [operands[i].value for i in range(1, len(operands))]

        for i in range(len(operand_vals)):
            # It looks like Byte vals are truncated with 0's instead of signed
            if compare.unsigned_int == operand_vals[i].unsigned_int:
                self._handle_branch(True)
                return

        self._handle_branch(False)

    def _opcode__jl(self, operands: Tuple[Operand]):
        op_0 = operands[0].value.int
        op_1 = operands[1].value.int
        self._handle_branch(op_0 < op_1)

    def _opcode__jg(self, operands: Tuple[Operand]):
        op_0 = operands[0].value.int
        op_1 = operands[1].value.int
        self._handle_branch(op_0 > op_1)

    def _opcode__dec_chk(self, operands: Tuple[Operand]):
        var_num = ZByte(operands[0].literal_value)
        cmp_val = operands[1].value

        # Read variable value, decrement it and write it back
        dec_val = self._variables.val(var_num).dec()
        self._variables.set(var_num, dec_val)
        self._handle_branch(dec_val.int < cmp_val.int)

    def _opcode__inc_chk(self, operands: Tuple[Operand]):
        var_num = ZByte(operands[0].literal_value)
        cmp_val = operands[1].value

        # Read variable value, decrement it and write it back
        dec_val = self._variables.val(var_num).inc()
        self._variables.set(var_num, dec_val)

        self._handle_branch(dec_val.int > cmp_val.int)

    def _opcode__jin(self, operands: Tuple[Operand]):
        child_obj_num = operands[0].value
        parent_obj_num = operands[1].value.unsigned_int
        obj = self._obj_table.object(child_obj_num.unsigned_int)
        self._handle_branch(obj.parent == parent_obj_num)

    def _opcode__test(self, operands: Tuple[Operand]):
        bitmap = operands[0].value
        flags = operands[1].value

        if type(flags) == ZByte:
            flags = flags.pad()

        self._handle_branch((bitmap & flags.unsigned_int) == flags)

    def _opcode__or(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value.unsigned_int
        return a | b

    def _opcode__and(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value.unsigned_int
        return a & b

    def _opcode__test_attr(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        attr_num = operands[1].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        self._handle_branch(obj.is_attribute_set(attr_num))

    def _opcode__set_attr(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        attr_num = operands[1].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, True)

    def _opcode__clear_attr(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        attr_num = operands[1].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        obj.update_attribute(attr_num, False)

    def _opcode__store(self, operands: Tuple[Operand]):
        var_num = ZByte(operands[0].literal_value)
        val = operands[1].value
        self._variables.set(var_num, val)

    def _opcode__insert_obj(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        parent_obj_num = operands[1].value.unsigned_int
        self._obj_table.insert_child(obj_num, parent_obj_num)

    def _opcode__loadw(self, operands: Tuple[Operand]):
        arr_addr = operands[0].value.unsigned_int
        word_idx = operands[1].value.unsigned_int
        word_addr = arr_addr + (word_idx * 2)
        ret_word = ZWord(self._memory, word_addr)
        return ret_word

    def _opcode__loadb(self, operands: Tuple[Operand]):
        arr_addr = operands[0].value.unsigned_int
        byte_idx = operands[1].value.unsigned_int
        byte_addr = arr_addr + byte_idx
        ret_byte = ZByte(self._memory, byte_addr)
        return ret_byte

    def _opcode__get_prop(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        prop_num = operands[1].value.unsigned_int
        obj = self._obj_table.object(obj_num)
        prop_val = obj.properties.value_or_default(prop_num)
        return prop_val

    def _opcode__get_prop_addr(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        prop_num = operands[1].value.unsigned_int

        obj = self._obj_table.object(obj_num)
        property_info = obj.properties.get(prop_num)

        if property_info is not None:
            return ZWord.from_unsigned_int(property_info.value_address)
        else:
            return ZWord.from_int(0)

    def _opcode__get_next_prop(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        prop_num = operands[1].value.unsigned_int

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

        return ZWord.from_unsigned_int(next_prop_num)

    def _opcode__add(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        return a + b

    def _opcode__sub(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        return a - b

    def _opcode__mul(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        return a * b

    def _opcode__div(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        return a // b

    def _opcode__mod(self, operands: Tuple[Operand]):
        a = operands[0].value
        b = operands[1].value

        if type(a) == ZByte:
            a = a.pad()

        if type(b) == ZByte:
            b = b.pad()

        return a % b

    # VAR OP instructions

    def _opcode__storew(self, operands: Tuple[Operand]):
        arr_addr = operands[0].value.unsigned_int
        word_offset = operands[1].value.unsigned_int * 2
        value = operands[2].value

        if type(value) == ZByte:
            value = value.pad()

        address = arr_addr + word_offset

        if address >= self._header.static_memory_address:
            raise ZMachineIllegalOperation('attempt to write to static memory')

        value.write(self._memory, address)

    def _opcode__storeb(self, operands: Tuple[Operand]):
        arr_addr = operands[0].value.unsigned_int
        byte_offset = operands[1].value.unsigned_int * 2
        value = operands[2].value

        address = arr_addr + byte_offset

        if address >= self._header.static_memory_address:
            raise ZMachineIllegalOperation('attempt to write to static memory')

        value.write(self._memory, address)

    def _opcode__put_prop(self, operands: Tuple[Operand]):
        obj_num = operands[0].value.unsigned_int
        prop_num = operands[1].value.unsigned_int
        value = operands[2].value

        obj = self._obj_table.object(obj_num)
        obj.properties.set(prop_num, value)

    def _opcode__print_char(self, operands: Tuple[Operand]):
        char = operands[0].value.unsigned_int
        self._screen.print(chr(char))

    def _opcode__print_num(self, operands: Tuple[Operand]):
        num = operands[0].value.int
        self._screen.print(str(num))

    def _opcode__random(self, operands: Tuple[Operand]):
        rnd_range = operands[0].value.int

        if rnd_range == 0:
            # Reseed generator with a random seed
            random.seed()
        elif rnd_range < 0:
            # Seed generator with the operand value and return 0
            random.seed(rnd_range)
            return ZWord.from_int(0)
        else:
            rnd_num = ZWord.from_int(random.randint(1, rnd_range))
            return rnd_num

    def _opcode__push(self, operands: Tuple[Operand]):
        val = operands[0].value
        self._stack.push(val)

    def _opcode__sound_effect(self, operands: Tuple[Operand]):
        # TODO #11: Figure out how routing out sound is going to work
        pass


class ZMachineInterpreterV3(ZMachineInterpreter):

    def __init__(self, header: ZCodeHeader, memory: memoryview, screen: ZMachineScreen, keyboard: ZMachineInput, save_restore: ZMachineSaveRestoreHandler):
        assert header.version == 3, 'invalid z-code version for version interpreter'
        super().__init__(header, memory, screen, keyboard, save_restore)

    def terminate(self):
        super().terminate()

    def initialize(self):
        super().initialize()
        self._header.is_file_split = False
        self._header.is_transcription_on = False

    @staticmethod
    def expanded_packed_address(packed_address: ZWord) -> int:
        return packed_address.unsigned_int << 1

    # Version 3 specific opcodes

    def _opcode__not(self, operands: Tuple[Operand]):
        # This is technically an unsigned operation, but using signed numbers to
        # leverage Python's concept of an integer. Without using signed numbers
        # the result of the operation may not fit in 16 bits
        val = operands[0].value
        return ~val

    def _opcode__save(self, _):
        # For V3 interpreters save the PC right before the branch info is read
        save_pc = self._pc - self._branch_label.size

        chunks = [
            HeaderQuetzalChunk.create(self._header, save_pc),
            CMemQuetzalChunk.create(self._original_memory, self._memory),
            StacksQuetzalChunk.create(self._stack)
        ]

        ifzs = IFZSContainer(chunks)
        success = self._save_restore.save(ifzs.bytes())
        self._handle_branch(success)

    def _opcode__restore(self, _):
        restore_data = self._save_restore.restore()

        if restore_data is None:
            self._handle_branch(False)
            return

        try:
            ifzs = IFZSContainer.read(restore_data)
        except (QuetzalReadError, IFZSReadError) as e:
            self._save_restore.invalid_restore_data(f'invalid save gamedata: {e.message}')
            self._handle_branch(False)
            return

        header_chunk: HeaderQuetzalChunk = ifzs.chunk('IFhd')
        cmem_chunk: CMemQuetzalChunk = ifzs.chunk('CMem')
        umem_chunk: UMemQuetzalChunk = ifzs.chunk('UMem')
        stacks_chunk: StacksQuetzalChunk = ifzs.chunk('Stks')

        # ensure all chunks required are available
        data_error_message = None
        if header_chunk is None:
            data_error_message = 'no header found in save data'
        elif stacks_chunk is None:
            data_error_message = 'no stack found in save data'
        elif cmem_chunk is None and umem_chunk is None:
            data_error_message = 'no game memory found in save data'
        else:
            # check the header chunk against the current game's header
            header_info = header_chunk.header_info()
            if header_info.release_number != self._header.release_number:
                data_error_message = 'save data was not generated from this game'
            elif header_info.serial_number != self._header.serial_code:
                data_error_message = 'save data was not generated from this game'
            elif header_info.checksum != self._header.file_checksum:
                data_error_message = 'save data was not generated from this game'

        if data_error_message:
            self._save_restore.invalid_restore_data(data_error_message)
            self._handle_branch(False)
        else:
            if cmem_chunk is not None:
                saved_memory = cmem_chunk.saved_memory(self._original_memory)
            else:
                saved_memory = umem_chunk.saved_memory()

            # replace the memory, stack and PC
            self._pc = header_chunk.header_info().restore_pc

            # Consume the branch byte(s) but no need to store them
            _, next_pc = self._opcode_parser._read_label(int(self._pc))
            self._pc = PC(next_pc)

            self._stack.replace_frames(stacks_chunk.saved_stack().frames)
            self._memory[:len(saved_memory)] = saved_memory

    def _opcode__pop(self, _):
        self._stack.pop()

    def _opcode__show_status(self, _):
        self._screen.update_status()

    def _opcode__verify(self, _):
        # Technically supposed to verify the integrity of the game file, but not doing it
        pass

    def _opcode__call(self, operands: Tuple[Operand]):
        packed_address = ZWord(operands[0].value)

        # The first operand contains the packed address of the routine to call.
        routine_address = self.expanded_packed_address(packed_address)

        # The first byte of the routine header contains the number of local variables the routine has
        local_vars_count = self._memory[routine_address]

        # Each local variable's initial value is stored in the words following the word count byte
        initial_local_var_values = [
            ZWord(self._memory, routine_address + 1 + (i * 2))
            for i in range(local_vars_count)
        ]

        # The additional operands of the call opcode are set in the new local vars
        for local_var_num in range(len(operands) - 1):
            initial_local_var_values[local_var_num] = operands[local_var_num+1].value

        if routine_address == 0:
            self._variables.set(self._res_var, ZWord.from_int(0))
        else:
            # Add new frame to the stack for this routine
            self._stack.push_routine_call(self._pc, local_vars_count, self._res_var, *initial_local_var_values)

            # The address of the first instruction is directly after all the parameters
            self._pc = PC(routine_address + 1 + (local_vars_count * 2))

    def _opcode__sread(self, operands: Tuple[Operand]):
        text_buffer_address = operands[0].value.unsigned_int
        parse_buffer_address = operands[1].value.unsigned_int

        # The max number of characters to read is in the first byte of the text buffer
        max_chars = ZByte(self._memory, text_buffer_address).unsigned_int
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

    def _opcode__pull(self, operands: Tuple[Operand]):
        res_var = ZByte(operands[0].value)
        val = self._stack.pop()
        self._variables.set(res_var, val)

    def _opcode__split_window(self, operands: Tuple[Operand]):
        # TODO #9 : Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _opcode__set_window(self, operands: Tuple[Operand]):
        # TODO #9 : Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _output_stream(self, operands: Tuple[Operand]):
        # TODO #10: Figure out how this works
        raise NotImplemented('Still not sure how this works in V3')

    def _input_stream(self, operands: Tuple[Operand]):
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
