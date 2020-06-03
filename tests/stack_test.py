import pytest
from zfun import ZMachineStack


@pytest.fixture
def stack() -> ZMachineStack:
    return ZMachineStack()


def test_push_peek_and_pop(stack: ZMachineStack):
    a = 42
    b = bytes([0, 69])
    c = -3

    stack.push(a)
    stack.push(b)
    stack.push(c)

    assert stack.peek_int(0) == a
    assert stack.peek_int(1) == 69
    assert stack.peek(1) == b
    assert stack.peek_signed_int(2) == c
    assert stack.peek_signed_int() == c

    assert stack.pop_signed_int() == c
    assert stack.pop() == b
    assert stack.pop_int() == a


def test_routine_calls(stack: ZMachineStack):
    ret_a = 1234
    ret_var_a = 2
    a_locals = [1, 2, 3, 4]

    ret_b = 5678
    ret_var_b = 45
    b_locals = [42, 56]

    stack.push_routine_call(ret_a, len(a_locals), ret_var_a, *a_locals)
    assert stack.local_var(0) == a_locals[0].to_bytes(2, 'big')
    assert stack.local_var(1) == a_locals[1].to_bytes(2, 'big')
    assert stack.local_var(2) == a_locals[2].to_bytes(2, 'big')
    stack.set_local_var(3, int.to_bytes(34, 2, 'big'))
    assert stack.local_var(3) == int.to_bytes(34, 2, 'big')
    stack.push(69)

    stack.push_routine_call(ret_b, len(b_locals), ret_var_b, *b_locals)
    assert stack.local_var(0) == b_locals[0].to_bytes(2, 'big')
    assert stack.local_var(1) == b_locals[1].to_bytes(2, 'big')
    stack.push(342)
    ret_pc, ret_var = stack.pop_routine_call()
    assert ret_pc == ret_b
    assert ret_var == ret_var

    # Now ensure the previous call's variables are still correct
    assert stack.local_var(0) == a_locals[0].to_bytes(2, 'big')
    assert stack.local_var(1) == a_locals[1].to_bytes(2, 'big')
    assert stack.local_var(2) == a_locals[2].to_bytes(2, 'big')
    assert stack.local_var(3) == int.to_bytes(34, 2, 'big')
    assert stack.pop_int() == 69

    ret_pc, ret_var = stack.pop_routine_call()
    assert ret_pc == ret_a
    assert ret_var == ret_var_a


