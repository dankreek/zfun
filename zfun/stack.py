import copy
from typing import Union, List, Tuple, NamedTuple
from .exc import ZMachineException, ZMachineIllegalOperation
from .util import read_word, read_signed_word
from .data_structures import ZWord, ZByte, ZData


class ZMachineStackFrame(NamedTuple):
    return_pc: Union[None, ZWord]
    result_var: Union[None, ZByte]
    prev_frame_i: Union[None, int]
    local_vars: Union[None, List[ZData]]
    data: List[ZData]


# TODO: Use raw memory to keep the stack to closer emulate how an 8-bit computer would implement a stack
class ZMachineStack:

    RET_PC_OFFSET = 0
    RES_VAR_OFFSET = 1
    PREV_FRAME_I_OFFSET = 2

    def __init__(self):
        self._stack: List[ZData] = []
        self._frame_i = 0

        # Keep info about each routine call for debugging purposes
        self._routine_num_vars: List[int] = []

    def push(self, x: ZData):
        self._stack.append(x)

    def pop(self) -> ZData:
        if len(self._stack) == 0:
            raise ZMachineStackUnderflow
        else:
            return self._stack.pop()

    def peek(self, index: int = None) -> ZData:
        """ Peek at a value on the stack at the given index.

        Bottom of stack is 0, top of stack is the last element in the list.

        :param index: Index of stack to peek at, if None then returns value at the top of the stack.
        :return: Value at stack index
        """
        assert (index is None) or (index >= 0), 'index must be equal or greater than 0'

        if len(self._stack) == 0:
            raise ZMachineStackUnderflow('can not peek at an empty stack')

        if index is None:
            index = len(self._stack) - 1

        if index >= len(self._stack):
            raise ZMachineStackUnderflow(f'{index} is out of range for stack with size {len(self._stack)}')

        return self._stack[index]

    def _verify_var_num_range(self, var_num: int):
        assert 0 <= var_num <= 15, 'var_num must be between 0 and 15'

        if len(self._routine_num_vars) == 0:
            raise ZMachineIllegalOperation('can not access local variables when no routine is on the stack')

        num_local_vars = self._routine_num_vars[-1]
        if var_num >= num_local_vars:
            raise ZMachineIllegalOperation(f'local variable {var_num} is out of range, routine only has {num_local_vars} local variables')

    def local_var(self, var_num: int) -> ZData:
        """ Return the value of the current routine's local variable.

        :param var_num: Number of local variable to return
        :return: Value of the local variable.
        """
        self._verify_var_num_range(var_num)
        return self.peek(self._frame_i + 3 + var_num)

    def set_local_var(self, var_num: int, val: ZData):
        """ Set a value of the current routine's local variables.

        :param var_num: Local variable number
        :param val: Value to set the variable to
        """
        self._verify_var_num_range(var_num)
        self._stack[self._frame_i + 3 + var_num] = val

    def push_routine_call(self, ret_addr: ZWord, num_locals: int, res_var: ZByte, *local_var_vals: ZData):
        """ Push a routine call onto the stack.

        This is used to mark the position in the stack where the routine's local variables are stored.

        :param ret_addr: Address to return to after this routine is finished.
        :param num_locals: Number of local variables for the routine
        :param res_var: Variable number to put the result value in
        :param local_var_vals: Initial values of all local variables. If no values are available, they will be set to 0.0
        """
        new_frame_i = len(self._stack)
        self.push(ret_addr)
        self.push(res_var)
        self.push(ZWord.from_unsigned_int(self._frame_i))
        self._frame_i = new_frame_i

        for i in range(num_locals):
            try:
                self.push(local_var_vals[i])
            except IndexError:
                # Push on a 0 if local var is not predefined
                self.push(ZWord.from_int(0))

        self._routine_num_vars.append(num_locals)

    def pop_routine_call(self) -> Tuple[ZWord, ZByte]:
        """ Remove the current routine's stack frame.

        :return: The address to return to after cleaning up the current routine,
                 and the variable number to store the result value in b
        """
        if len(self._stack) == 0:
            raise ZMachineStackUnderflow('Can not return from main routine')

        ret_addr = self.peek(self._frame_i)
        res_var = self.peek(self._frame_i + 1)
        prev_frame_i = self.peek(self._frame_i + 2).unsigned_int

        # Shrink stack back down to its size before this routine call
        self._stack = self._stack[:self._frame_i]
        self._frame_i = prev_frame_i

        # Remove previous routine's debug info
        self._routine_num_vars.pop()

        return ZWord(ret_addr), ZByte(res_var)

    def stack_frames(self) -> List[ZMachineStackFrame]:
        local_var_counts = copy.copy(self._routine_num_vars)
        frames = []
        frame_i = self._frame_i
        last_frame_i = len(self._stack)

        while last_frame_i != 0:
            var_count = local_var_counts.pop()
            frames.insert(0, ZMachineStackFrame(
                ZWord(self._stack[frame_i + self.RET_PC_OFFSET]),
                ZByte(self._stack[frame_i + self.RES_VAR_OFFSET]),
                self._stack[frame_i + self.PREV_FRAME_I_OFFSET].unsigned_int,
                self._stack[frame_i+3:frame_i + 3 + var_count],
                self._stack[frame_i + 3 + var_count + 1:last_frame_i]
            ))
            last_frame_i = frame_i
            frame_i = self._stack[frame_i + self.PREV_FRAME_I_OFFSET].unsigned_int

        if last_frame_i != 0:
            frames.insert(0, ZMachineStackFrame(
                None, None, None, None,
                self._stack[:last_frame_i]
            ))

        return frames


class ZMachineStackUnderflow(ZMachineException):
    pass


