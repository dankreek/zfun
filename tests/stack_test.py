import pytest
from zfun import ZMachineStack, ZWord, ZByte, PC


@pytest.fixture
def stack() -> ZMachineStack:
    return ZMachineStack()


def test_push_peek_and_pop(stack: ZMachineStack):
    a = ZWord.from_int(42)
    b = ZWord(bytes([0, 69]))
    c = ZByte.from_int(-3)

    stack.push(a)
    stack.push(b)
    stack.push(c)

    assert stack.peek() == c.pad()
    assert stack.pop() == c.pad()

    assert stack.peek() == b
    assert stack.pop() == b

    assert stack.peek() == a
    assert stack.pop() == a


def test_routine_calls(stack: ZMachineStack):
    ret_a = PC(1234)
    ret_var_a = ZByte.from_int(2)
    a_locals = [ZWord.from_int(1), ZWord.from_int(2), ZWord.from_int(3), ZByte.from_int(4)]

    ret_b = PC(5678)
    ret_var_b = ZByte.from_unsigned_int(45)
    b_locals = [ZWord.from_int(42), ZWord.from_int(56)]

    stack.push_routine_call(ret_a, len(a_locals), ret_var_a, *a_locals)
    assert stack.local_var(0) == a_locals[0]
    assert stack.local_var(1) == a_locals[1]
    assert stack.local_var(2) == a_locals[2]
    stack.set_local_var(3, ZWord.from_int(34))
    assert stack.local_var(3) == ZWord.from_int(34)
    stack.push(ZWord.from_int(69))

    stack.push_routine_call(ret_b, len(b_locals), ret_var_b, *b_locals)
    assert stack.local_var(0) == b_locals[0]
    assert stack.local_var(1) == b_locals[1]
    stack.push(ZWord.from_int(342))
    ret_pc, ret_var = stack.pop_routine_call()
    assert ret_pc == ret_b
    assert ret_var == ret_var

    # Now ensure the previous call's variables are still correct
    assert stack.local_var(0) == a_locals[0]
    assert stack.local_var(1) == a_locals[1]
    assert stack.local_var(2) == a_locals[2]
    assert stack.local_var(3) == ZWord.from_int(34)
    assert stack.pop() == ZWord.from_int(69)

    ret_pc, ret_var = stack.pop_routine_call()
    assert ret_pc == ret_a
    assert ret_var == ret_var_a


