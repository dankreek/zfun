import pytest
from zfun import ZMachineOpcodeParserV3, ZMachineOperandTypes, ZWord, ZByte


@pytest.fixture
def opcodes_v3(zork1_v3_data: memoryview):
    return ZMachineOpcodeParserV3(zork1_v3_data)


def test_short_form_opcodes(opcodes_v3: ZMachineOpcodeParserV3):
    # One operand of type LARGE_CONSTANT
    jump, next_pc = opcodes_v3.parse(0x85ab)
    assert jump.opcode == 'jump'
    assert len(jump.operand_types) == 1
    assert len(jump.operands) == 1
    assert jump.operand_types[0] == ZMachineOperandTypes.LARGE_CONSTANT
    assert jump.operands[0] == ZWord(bytes([0x00, 0x0b]))
    assert next_pc == 0x85ab + 3

    # One operand of type VARIABLE
    load, next_pc = opcodes_v3.parse(0x7d58)
    assert load.opcode == 'load'
    assert len(load.operand_types) == 1
    assert len(load.operands) == 1
    assert load.operand_types[0] == ZMachineOperandTypes.VARIABLE
    assert load.operands[0] == ZByte(b'\x00')
    assert next_pc == 0x7d58 + 3

    # Zero operands
    print_ret, next_pc = opcodes_v3.parse(0x4fb1)
    assert print_ret.opcode == 'print_ret'
    assert print_ret.operand_types is None
    assert print_ret.operands is None
    assert next_pc == 0x4fb2


def test_long_form_opcodes(opcodes_v3: ZMachineOpcodeParserV3):
    add, next_pc = opcodes_v3.parse(0x4e83)
    assert add.opcode == 'add'
    assert len(add.operand_types) == 2
    assert len(add.operands) == 2
    assert add.operand_types == (ZMachineOperandTypes.VARIABLE, ZMachineOperandTypes.SMALL_CONSTANT)
    assert add.operands == (ZByte(b'\x01'), ZByte(b'\x02'))
    assert next_pc == 0x4e83 + 4


def test_variable_form_opcodes(opcodes_v3: ZMachineOpcodeParserV3):
    # Test variable form of 2OP opcode instructions
    call, next_pc = opcodes_v3.parse(0x5157)
    assert call.opcode == 'je'
    assert len(call.operand_types) == 3
    assert call.operand_types == (
        ZMachineOperandTypes.VARIABLE,
        ZMachineOperandTypes.SMALL_CONSTANT,
        ZMachineOperandTypes.SMALL_CONSTANT
    )
    assert call.operands == (ZByte(b'\x88'), ZByte(b'\x32'), ZByte(b'\x12'))
    assert next_pc == 0x5157 + 5

    # Test unique variable opcode instructions
    call, next_pc = opcodes_v3.parse(0x4f05)
    assert call.opcode == 'call'
    assert len(call.operand_types) == 3
    assert call.operand_types == (
        ZMachineOperandTypes.LARGE_CONSTANT,
        ZMachineOperandTypes.LARGE_CONSTANT,
        ZMachineOperandTypes.LARGE_CONSTANT
    )
    assert len(call.operands) == 3

    assert call.operands == (
        ZWord(bytes([0x2a, 0x39])),
        ZWord(bytes([0x80, 0x10])),
        ZWord(bytes([0xff, 0xff]))
    )
    assert next_pc == 0x4f05 + 9


