from typing import Union, List
from .exc import ZMachineStackUnderflow
from .util import read_word, read_signed_word


# TODO: Use raw memory to keep the stack to closer emulate how an 8-bit computer would implement a stack
class ZMachineStack:

    def __init__(self):
        self._stack: List[Union[bytes, memoryview]] = []
        self._frame_i = 0

    def push(self, x: Union[int, bytes, memoryview]):
        if type(x) == int:
            assert -32768 <= x <= 65535, 'integer must be with range of a signed or unsigned word'
            if x < 0:
                # store as a signed int
                is_signed = True
            else:
                # store as an unsigned int
                is_signed = False

            x = x.to_bytes(2, 'big', signed=is_signed)
        else:
            assert len(x) == 2, 'stack values must be 2 bytes long'

        self._stack.append(x)

    def pop(self) -> Union[bytes, memoryview]:
        if len(self._stack) == 0:
            raise ZMachineStackUnderflow
        else:
            return self._stack.pop()

    def pop_int(self) -> int:
        """ Pop the top of the stack and return an unsigned integer value """
        return read_word(self.pop(), 0)

    def pop_signed_int(self) -> int:
        """ Pop the top of the stack and return a signed integer value """
        return read_signed_word(self.pop(), 0)

    def peek(self, index: int = None) -> Union[bytes, memoryview]:
        """ Peek at a value on the stack at the given index.

        Bottom of stack is 0, top of stack is the last element in the list.

        :param index: Index of stack to peek at, if None then returns value at the top of the stack.
        :return: Value at stack index
        """
        if index is None:
            index = len(self._stack) - 1

        assert 0 <= index < len(self._stack), f'{index} is out of range for stack with size {len(self._stack)}'

        return self._stack[index]

    def peek_int(self, index: int = None) -> int:
        """ Peek at a value on the stack at the given index and return as an unsigned integer.

        :param index: Index of stack to peek at
        :return: Value at stack index
        """
        return read_word(self.peek(index), 0)

    def peek_signed_int(self, index: int = None) -> int:
        """ Peek at a value on the stack at the given index and return as a signed integer.

        :param index: Index of stack to peek at
        :return: Value at stack index
        """
        return read_signed_word(self.peek(index), 0)

    def local_var(self, var_num: int) -> Union[bytes, memoryview]:
        """ Return the value of the current routine's local variable.

        :param var_num: Number of local variable to return
        :return: Value of the local variable.
        """
        assert 0 <= var_num <= 15, 'var_num must be between 0 and 15'
        return self.peek(self._frame_i + 2 + var_num)

    def set_local_var(self, var_num: int, val: Union[int, bytes, memoryview]):
        """ Set a value of the current routine's local variables.

        :param var_num: Local variable number
        :param val: Value to set the variable to
        """
        assert 0 <= var_num <= 15, 'var_num must be between 0 and 15'

        if type(val) == int:
            assert -32768 <= val <= 65535, 'integer must be with range of a signed or unsigned word'
            if val < 0:
                # store as a signed int
                is_signed = True
            else:
                # store as an unsigned int
                is_signed = False

            val = val.to_bytes(2, 'big', signed=is_signed)

        self._stack[self._frame_i + 2 + var_num] = val

    def push_routine_call(self, ret_addr: int, num_locals: int, *local_vals: Union[int, bytes, memoryview]):
        """ Push a routine call onto the stack.

        This is used to mark the position in the stack where the routine's local variables are stored.

        :param ret_addr: Address to return to after this routine is finished.
        :param num_locals: Number of local variables for the routine
        :param local_vals: Initial values of all local variables. If no values are available, they will be set to 0.0
        """
        new_frame_i = len(self._stack)
        self.push(ret_addr)
        self.push(self._frame_i)
        self._frame_i = new_frame_i

        for i in range(num_locals):
            try:
                self.push(local_vals[i])
            except IndexError:
                self.push(0)

    def pop_routine_call(self) -> int:
        """ Remove the current routine's stack frame.

        :return: The address to return to after cleaning up the current routine.
        """
        ret_addr = self.peek_int(self._frame_i)
        prev_frame_i = self.peek_int(self._frame_i + 1)

        # Shrink stack back down to its size before this routine call
        self._stack = self._stack[:self._frame_i]
        self._frame_i = prev_frame_i

        return ret_addr





