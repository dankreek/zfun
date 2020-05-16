from zfun import ZMachineDictionary, tokenize
from zfun.util import write_asciiz


# XXX: Write and actual test
def test_tokenize(zork_v3_dict: ZMachineDictionary):
    text_buffer_addr = 0
    parse_buffer_addr = 256

    memory = memoryview(bytearray(b' ' * 512))

    memory[0] = 77
    memory[parse_buffer_addr] = 10
    write_asciiz(memory, 1, 'get, lamp')

    tokenize(memory, zork_v3_dict, text_buffer_addr, parse_buffer_addr)

    assert memory[parse_buffer_addr + 1] == 3
