
def read_word(memory: bytes, offset: int):
    return int(memory[offset]) * 256 + int(memory[offset+1])