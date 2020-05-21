from typing import Union, List


class ZMachineStack:

    def __init__(self):
        self._stack: List[Union[bytes, memoryview]] = []

    def push(self, x: Union[bytes, memoryview]):
        assert len(x) == 2, 'stack values must be 2 bytes long'
        self._stack.append(x)

    def pop(self) -> Union[bytes, memoryview]:
        return self._stack.pop()

    def peek(self, depth: int) -> Union[bytes, memoryview]:
        """ Peek at a value on the stack at the given depth.

        A depth of 0 is the top of the stack, 1 would be the next-recently pushed value, etc.

        :param depth: Depth of stack to peek at
        :return: Value at stack depth
        """
        assert 0 <= depth < len(self._stack), f'{depth} is out of range for stack with size {len(self._stack)}'
        return self._stack[-(depth + 1)]
