import pytest

from zfun import (
    CMemQuetzalChunk, UMemQuetzalChunk, StacksQuetzalChunk, ZMachineObjectTable, ZWord, ZMachineStack, PC, ZByte,
    get_header, HeaderQuetzalChunk, IFZSContainer
)


def test_cmem_quetzal_chunk(zork_v3_obj_table: ZMachineObjectTable):
    original_memory = bytes(zork_v3_obj_table._memory)

    cretin = zork_v3_obj_table.object(4)
    cretin.properties.set(18, ZWord(bytes.fromhex('ffff')))
    prop_address = cretin.properties.get(18).value_address

    cmem_chunk = CMemQuetzalChunk.create(original_memory, zork_v3_obj_table._memory)

    restored_chunk, offset = CMemQuetzalChunk.read(cmem_chunk.bytes())
    assert offset == len(cmem_chunk.bytes())
    restored_memory = restored_chunk.saved_memory(original_memory)

    for i in range(len(restored_memory)):
        if i not in [prop_address, prop_address+1]:
            assert restored_memory[i] == original_memory[i], f'memory different at {hex(i)} should be different at {hex(prop_address)}'
        else:
            assert restored_memory[i] != original_memory[i], f'memory should be different at {hex(i)} for prop at address {hex(prop_address)}'


def test_umem_quetzal_chunk(zork_v3_obj_table: ZMachineObjectTable):
    original_memory = bytes(zork_v3_obj_table._memory)

    cretin = zork_v3_obj_table.object(4)
    cretin.properties.set(18, ZWord(bytes.fromhex('ffff')))
    prop_address = cretin.properties.get(18).value_address

    cmem_chunk = UMemQuetzalChunk(zork_v3_obj_table._memory)

    restored_chunk, offset = UMemQuetzalChunk.read(cmem_chunk.bytes())
    assert offset == len(cmem_chunk.bytes())
    restored_memory = restored_chunk.saved_memory()

    for i in range(len(restored_memory)):
        if i not in [prop_address, prop_address+1]:
            assert restored_memory[i] == original_memory[i], f'memory different at {hex(i)} should be different at {hex(prop_address)}'
        else:
            assert restored_memory[i] != original_memory[i], f'memory should be different at {hex(i)} for prop at address {hex(prop_address)}'


def test_stacks_quetzal_chunk_with_initial_dummy_stack():
    new_stack = ZMachineStack()

    quetzal_stack = StacksQuetzalChunk.create(new_stack)
    restored_stack_chunk, next_chunk = StacksQuetzalChunk.read(quetzal_stack.bytes())

    assert next_chunk == len(quetzal_stack.bytes())
    assert new_stack.frames == restored_stack_chunk.saved_stack().frames, 'initial stack and saved stack are not the same'


def test_stack_quetzal_chunk_with_routine_calls():
    new_stack = ZMachineStack()
    new_stack.push_routine_call(PC(0x1234), 2, ZByte.from_int(0), *[ZWord.from_int(1), ZWord.from_int(2)])
    new_stack.push(ZWord.from_int(1955))
    new_stack.push(ZWord.from_int(1985))

    quetzal_stack = StacksQuetzalChunk.create(new_stack)
    restored_stack_chunk, next_chunk = StacksQuetzalChunk.read(quetzal_stack.bytes())

    assert next_chunk == len(quetzal_stack.bytes())
    assert restored_stack_chunk.saved_stack().frames == new_stack.frames, 'initial stack and saved stack are not the same'


def test_header_quetzal_chunk(zork1_v3_data: memoryview):
    header = get_header(zork1_v3_data)
    saved_pc = PC(0x1234)

    quetzal_header_chunk = HeaderQuetzalChunk.create(header, saved_pc)
    stored_header_chunk, offset = HeaderQuetzalChunk.read(quetzal_header_chunk.bytes())

    assert offset == len(quetzal_header_chunk.bytes())
    saved_header_info = stored_header_chunk.header_info()
    assert saved_header_info.restore_pc == saved_pc
    assert saved_header_info.release_number == header.release_number
    assert saved_header_info.checksum == header.file_checksum
    assert saved_header_info.serial_number == header.serial_code


def test_ifzs_container(zork1_v3_data: memoryview):
    header = get_header(zork1_v3_data)
    saved_pc = PC(0x1234)
    new_stack = ZMachineStack()

    quetzal_stack_chunk = StacksQuetzalChunk.create(new_stack)
    quetzal_header_chunk = HeaderQuetzalChunk.create(header, saved_pc)

    quetzal_data = IFZSContainer([quetzal_stack_chunk, quetzal_header_chunk]).bytes()

    parsed_quetzal_data = IFZSContainer.read(quetzal_data)

    stacks_chunk: StacksQuetzalChunk = parsed_quetzal_data.chunk('Stks')
    assert new_stack.frames == stacks_chunk.saved_stack().frames

    header_chunk: HeaderQuetzalChunk = parsed_quetzal_data.chunk('IFhd')

    saved_header_info = header_chunk.header_info()
    assert saved_header_info.restore_pc == saved_pc
    assert saved_header_info.release_number == header.release_number
    assert saved_header_info.checksum == header.file_checksum
    assert saved_header_info.serial_number == header.serial_code


