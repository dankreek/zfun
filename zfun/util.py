import io


def read_word(memory: memoryview, offset: int):
    return int(memory[offset]) * 256 + int(memory[offset+1])