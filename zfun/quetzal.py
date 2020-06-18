from abc import ABC, abstractmethod
from typing import Tuple, Union, List, NamedTuple

from .header import ZCodeHeader
from .stack import ZMachineStack, ZMachineStackFrame
from .data_structures import ZWord, ZByte, PC
from .header import get_header


class QuetzalChunk(ABC):

    @staticmethod
    @abstractmethod
    def chunk_id() -> bytes:
        """ Chunk ID for this Quetzal chunk """
        pass

    @property
    @abstractmethod
    def chunk_length(self) -> int:
        """ Length of this chunk in bytes. """
        pass

    @staticmethod
    @abstractmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        """ Read a chunk of the implementing type from the provided data at the given offset.

        :param data:
        :param offset:
        :return: An implementation of QuetzalChunk and the offset of the end of the chunk
        :rtype: Tuple[QuetzalChunk, int]
        """
        pass

    @abstractmethod
    def bytes(self) -> bytes:
        """
        :return: Byte form of this Quetzal chunk.
        """
        pass


class CMemQuetzalChunk(QuetzalChunk):
    """ Compressed Z-Machine memory """

    def __init__(self, compressed_data: bytes):
        self._compressed_data = compressed_data

    @staticmethod
    def chunk_id() -> bytes:
        return b'CMem'

    @staticmethod
    def create(original_memory: bytes, current_memory: memoryview):
        """ Create a new CMemQuetzalChunk given the original machine memory and the memory at the save point.

        :param original_memory: The z-machine's original dynamic memory
        :param current_memory: The z-machine's current dynamic memory
        :return: A new CMemQuetzalChunk containing the XOR-difference between the original and saved memory
        :rtype: CMemQuetzalChunk
        """
        header = get_header(current_memory)
        output = bytearray()

        zero_count = 0
        for i in range(header.static_memory_address):
            diff = original_memory[i] ^ current_memory[i]
            if diff == 0:
                zero_count += 1
                if zero_count == 1:
                    output.append(0)
                elif zero_count == 256:
                    output.append(zero_count - 1)
                    zero_count = 0
            else:
                if zero_count != 0:
                    output.append(zero_count - 1)
                    zero_count = 0

                output.append(diff)

        return CMemQuetzalChunk(bytes(output))

    @property
    def chunk_length(self) -> int:
        return len(self._compressed_data)

    def saved_memory(self, original_memory: bytes) -> bytes:
        """ Restore the saved memory given the original memory.

        :param original_memory:
        :return: Z-Machine memory at the time of game save.
        """
        saved_memory = bytearray(original_memory)

        output_i = 0
        reading_zeros = False
        for byte in self._compressed_data:
            if reading_zeros:
                output_i += byte+1
                reading_zeros = False
            elif byte == 0:
                reading_zeros = True
            else:
                saved_memory[output_i] = original_memory[output_i] ^ byte
                output_i += 1

        return bytes(saved_memory)

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != CMemQuetzalChunk.chunk_id():
            # XXX: make better exception
            raise RuntimeError(f'Chunk at offset {offset} is not a CMem Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=False)

        offset += 4
        compressed_data = data[offset:offset+size]

        offset += size
        return CMemQuetzalChunk(compressed_data), offset

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=False) + self._compressed_data


class UMemQuetzalChunk(QuetzalChunk):
    """ Uncompressed Z-Machine Memory """

    def __init__(self, save_memory: Union[bytes, memoryview]):
        self._saved_memory = bytes(save_memory)

    @property
    def chunk_length(self) -> int:
        return len(self._saved_memory)

    @staticmethod
    def chunk_id() -> bytes:
        return b'UMem'

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != UMemQuetzalChunk.chunk_id():
            # XXX: make better exception
            raise RuntimeError(f'Chunk at offset {offset} is not a UMem Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=False)

        offset += 4
        saved_data = data[offset:offset+size]

        offset += size
        return UMemQuetzalChunk(saved_data), offset

    def saved_memory(self) -> bytes:
        """
        :return: Z-Machine memory at the time of game save.
        """
        return self._saved_memory

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=False) + self._saved_memory


class StacksQuetzalChunk(QuetzalChunk):

    def __init__(self, stack_bytes: bytes):
        self._stack_bytes = stack_bytes

    @staticmethod
    def chunk_id() -> bytes:
        return b'Stks'

    @property
    def chunk_length(self) -> int:
        return len(self._stack_bytes)

    @staticmethod
    def create(stack: ZMachineStack):
        stack_bytes = bytearray()

        for frame in stack.frames:
            # Add return PC
            stack_bytes += frame.return_pc.bytes if frame.return_pc is not None else b'\x00\x00\x00'

            # TODO: Fix this for version 4+, need to set the p flag
            # Add flags
            stack_bytes.append(len(frame.local_vars))

            # Add routine result variable
            stack_bytes += frame.result_var.bytes if frame.result_var is not None else b'\x00'

            # TODO: Fix this for version 4+, flags
            passed_parameters_flags = ZByte(b'\x00')
            for i in range(len(frame.local_vars)):
                passed_parameters_flags = passed_parameters_flags.set_bit(i)
            stack_bytes += passed_parameters_flags.bytes

            # Add number of stack words used
            stack_bytes += ZWord.from_unsigned_int(len(frame.stack_data)).bytes

            # Add each local variable
            for var in frame.local_vars:
                stack_bytes += var.bytes

            # Add the evaluation stack
            for var in frame.stack_data:
                stack_bytes += var.bytes

        return StacksQuetzalChunk(bytes(stack_bytes))

    def saved_stack(self) -> ZMachineStack:
        frames: List[ZMachineStackFrame] = []

        stack_bytes_i = 0
        while stack_bytes_i < len(self._stack_bytes):
            return_pc = PC.read(self._stack_bytes, stack_bytes_i)
            if int(return_pc) == 0:
                return_pc = None
            stack_bytes_i += 3

            # TODO: Fix this for version 4+, need to read the p flag
            num_local_vars = self._stack_bytes[stack_bytes_i] & 0x0f
            stack_bytes_i += 1

            if return_pc is None:
                res_var = None
            else:
                res_var = ZByte(self._stack_bytes, stack_bytes_i)
            stack_bytes_i += 1

            # TODO: Fix this for version 4+, read arguments supplied
            stack_bytes_i += 1

            num_stack_words = ZWord(self._stack_bytes, stack_bytes_i).unsigned_int
            stack_bytes_i += 2

            local_vars = [
                ZWord(self._stack_bytes, stack_bytes_i + (i * 2))
                for i in range(num_local_vars)
            ]
            stack_bytes_i += num_local_vars * 2

            stack_data = [
                ZWord(self._stack_bytes, stack_bytes_i + (i * 2))
                for i in range(num_stack_words)
            ]
            stack_bytes_i += num_stack_words * 2

            frames.append(ZMachineStackFrame(return_pc, res_var, local_vars, stack_data))

        return ZMachineStack(frames)

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != StacksQuetzalChunk.chunk_id():
            # XXX: make better exception
            raise RuntimeError(f'Chunk at offset {offset} is not a Stks Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=False)

        offset += 4
        stack_bytes = data[offset:offset+size]

        offset += size
        return StacksQuetzalChunk(stack_bytes), offset

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=False) + self._stack_bytes


class QuetzalHeaderInfo(NamedTuple):
    release_number: int
    serial_number: str
    checksum: int
    restore_pc: PC


class HeaderQuetzalChunk(QuetzalChunk):

    def __init__(self, header_info_bytes: bytes):
        self._header_info_bytes = header_info_bytes

    @staticmethod
    def chunk_id() -> bytes:
        return b'IFhd'

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != HeaderQuetzalChunk.chunk_id():
            # XXX: make better exception
            raise RuntimeError(f'Chunk at offset {offset} is not a IFhd Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=False)

        offset += 4
        header_data = data[offset:offset+size]

        offset += size
        return HeaderQuetzalChunk(header_data), offset

    @staticmethod
    def create(header: ZCodeHeader, save_pc: PC):
        """ Create a new IFhd chunk from a Z-Machine header

        :param header: Header to read data from
        :param save_pc: PC of the machine at save time
        :return: IFhd chunk from a Z-Machine header
        :rtype: HeaderQuetzalChunk
        """
        output = bytearray()
        output += ZWord.from_unsigned_int(header.release_number).bytes
        output += header.serial_code.encode('ascii')
        output += ZWord.from_unsigned_int(header.file_checksum).bytes
        output += save_pc.bytes
        return HeaderQuetzalChunk(bytes(output))

    def header_info(self) -> QuetzalHeaderInfo:
        return QuetzalHeaderInfo(
            ZWord(self._header_info_bytes).unsigned_int,
            self._header_info_bytes[2:8].decode('ascii'),
            ZWord(self._header_info_bytes, 8).unsigned_int,
            PC.read(self._header_info_bytes, 10)
        )

    @property
    def chunk_length(self) -> int:
        return 13

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=False) + self._header_info_bytes

