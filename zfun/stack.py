import copy
from typing import Union, List, Tuple, NamedTuple
from .exc import ZMachineException, ZMachineIllegalOperation
from .data_structures import ZWord, ZByte, ZData, PC


class ZMachineStackFrame(NamedTuple):
    return_pc: Union[None, PC]
    result_var: Union[None, ZByte]
    local_vars: List[ZData]
    stack_data: List[ZData]


# TODO: Use raw memory to keep the stack to closer emulate how an 8-bit computer would implement a stack
class ZMachineStack:

    RET_PC_OFFSET = 0
    RES_VAR_OFFSET = 1
    PREV_FRAME_I_OFFSET = 2

    def __init__(self, init_frames: List[ZMachineStackFrame] = None):
        """ Create a new Z-Machine stack.

        :param init_frames: A list of initial stack frames (newest frames last).
                            If no frames are specified, an empty non-returnable frame is added
        """
        if init_frames is None:
            init_frames = [ZMachineStackFrame(None, None, [], [])]
        else:
            init_frames = copy.copy(init_frames)

        self._frames: List[ZMachineStackFrame] = init_frames

    def push(self, x: ZData):
        assert issubclass(type(x), ZData), 'can only push ZData types on to the stack'
        if type(x) == ZByte:
            x = x.pad(is_signed=False)

        self._frames[-1].stack_data.append(x)

    def pop(self) -> ZData:
        if len(self._frames[-1].stack_data) == 0:
            raise ZMachineStackUnderflow
        else:
            return self._frames[-1].stack_data.pop()

    def peek(self) -> ZData:
        """ Peek at the value on top of the data stack.

        :return: Value of top of stack
        """
        if len(self._frames[-1].stack_data) == 0:
            raise ZMachineStackUnderflow('Current frame has no stack data')

        return self._frames[-1].stack_data[-1]

    def _verify_var_num_range(self, var_num: int):
        num_locals = len(self._frames[-1].local_vars)

        if not 0 <= var_num < num_locals:
            raise ZMachineIllegalOperation(f'Local variable {var_num} is out of range for frame with {num_locals} local variables')

    def local_var(self, var_num: int) -> ZData:
        """ Return the value of the current routine's local variable.

        :param var_num: Number of local variable to return
        :return: Value of the local variable.
        """
        self._verify_var_num_range(var_num)
        return self._frames[-1].local_vars[var_num]

    def set_local_var(self, var_num: int, val: ZData):
        """ Set a value of the current routine's local variables.

        :param var_num: Local variable number
        :param val: Value to set the variable to
        """
        self._verify_var_num_range(var_num)
        self._frames[-1].local_vars[var_num] = val

    def push_routine_call(self, ret_addr: PC, num_locals: int, res_var: ZByte, *local_var_vals: ZData):
        """ Push a routine call onto the stack.

        This is used to mark the position in the stack where the routine's local variables are stored.

        :param ret_addr: Address to return to after this routine is finished.
        :param num_locals: Number of local variables for the routine
        :param res_var: Variable number to put the result value in
        :param local_var_vals: Initial values of all local variables. If no values are available, they will be set to 0.0
        """
        local_vars = [ZWord.from_int(0)] * num_locals

        for i in range(len(local_var_vals)):
            if len(local_var_vals[i]) == 1:
                val = local_var_vals[i].pad(False)
            else:
                val = local_var_vals[i]

            local_vars[i] = val

        new_frame = ZMachineStackFrame(ret_addr, res_var, local_vars, [])
        self._frames.append(new_frame)

    def pop_routine_call(self) -> Tuple[PC, ZByte]:
        """ Remove the current routine's stack frame.

        :return: The address to return to after cleaning up the current routine,
                 and the variable number to store the result value in b
        """
        if len(self._frames) == 0:
            raise ZMachineStackUnderflow('Can not return from main routine')

        cur_frame = self._frames.pop()
        return cur_frame.return_pc, cur_frame.result_var

    @property
    def frame(self) -> ZMachineStackFrame:
        """ Current routine's stack frame """
        return self._frames[-1]


class ZMachineStackUnderflow(ZMachineException):
    pass


