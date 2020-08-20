from abc import ABC, abstractmethod
from typing import Tuple, Union, List, NamedTuple, Dict

from .header import ZCodeHeader
from .stack import ZMachineStack, ZMachineStackFrame
from .data_structures import ZWord, ZByte, PC
from .header import get_header
from .exc import ZMachineException


class QuetzalReadError(ZMachineException):
    pass


class IFZSReadError(ZMachineException):
    pass


class QuetzalChunk(ABC):

    @abstractmethod
    def chunk_id(self) -> bytes:
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

    _chunk_id = b'CMem'

    def __init__(self, compressed_data: bytes):
        self._compressed_data = compressed_data

    def chunk_id(self) -> bytes:
        return self._chunk_id

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

        if zero_count != 0:
            output.append(zero_count - 1)

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
        if chunk_id != CMemQuetzalChunk._chunk_id:
            raise QuetzalReadError(f'Chunk at offset {offset} is not a CMem Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=True)

        offset += 4
        compressed_data = data[offset:offset+size]

        offset += size
        return CMemQuetzalChunk(compressed_data), offset

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=True) + self._compressed_data


class UMemQuetzalChunk(QuetzalChunk):
    """ Uncompressed Z-Machine Memory """

    _chunk_id = b'UMem'

    def __init__(self, save_memory: Union[bytes, memoryview]):
        self._saved_memory = bytes(save_memory)

    @property
    def chunk_length(self) -> int:
        return len(self._saved_memory)

    def chunk_id(self) -> bytes:
        return UMemQuetzalChunk._chunk_id

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != UMemQuetzalChunk._chunk_id:
            raise QuetzalReadError(f'Chunk at offset {offset} is not a UMem Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=True)

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
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=True) + self._saved_memory


class StacksQuetzalChunk(QuetzalChunk):

    _chunk_id = b'Stks'

    def __init__(self, stack_bytes: bytes):
        self._stack_bytes = stack_bytes

    def chunk_id(self) -> bytes:
        return StacksQuetzalChunk._chunk_id

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
            stack_bytes += frame.result_var.as_bytes if frame.result_var is not None else b'\x00'

            # TODO: Fix this for version 4+, flags
            passed_parameters_flags = ZByte(b'\x00')
            # for i in range(len(frame.local_vars)):
            #     passed_parameters_flags = passed_parameters_flags.set_bit(i)
            stack_bytes += passed_parameters_flags.as_bytes

            # Add number of stack words used
            stack_bytes += ZWord.from_unsigned_int(len(frame.stack_data)).as_bytes

            # Add each local variable
            for var in frame.local_vars:
                stack_bytes += var.as_bytes

            # Add the evaluation stack
            for var in frame.stack_data:
                stack_bytes += var.as_bytes

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
        if chunk_id != StacksQuetzalChunk._chunk_id:
            raise QuetzalReadError(f'Chunk at offset {offset} is not a Stks Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=True)

        offset += 4
        stack_bytes = data[offset:offset+size]

        offset += size
        return StacksQuetzalChunk(stack_bytes), offset

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=True) + self._stack_bytes


class QuetzalHeaderInfo(NamedTuple):
    release_number: int
    serial_number: str
    checksum: int
    restore_pc: PC


class HeaderQuetzalChunk(QuetzalChunk):

    _chunk_id = b'IFhd'

    def __init__(self, header_info_bytes: bytes):
        self._header_info_bytes = header_info_bytes

    def chunk_id(self) -> bytes:
        return HeaderQuetzalChunk._chunk_id

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        if chunk_id != HeaderQuetzalChunk._chunk_id:
            raise QuetzalReadError(f'Chunk at offset {offset} is not a IFhd Quetzal chunk')

        offset += 4
        size = int.from_bytes(data[offset:offset+4], 'big', signed=True)

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
        output += ZWord.from_unsigned_int(header.release_number).as_bytes
        output += header.serial_code.encode('ascii')
        output += ZWord.from_unsigned_int(header.file_checksum).as_bytes
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
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=True) + self._header_info_bytes


class UnknownQuetzalChunk(QuetzalChunk):

    def __init__(self, chunk_id: bytes, data: bytes):
        assert len(chunk_id) == 4, 'Quetzal chunk id must be 4 bytes'
        self._chunk_id = chunk_id
        self._data = data

    def chunk_id(self) -> bytes:
        return self._chunk_id

    def chunk_data(self) -> bytes:
        return self._data

    @property
    def chunk_length(self) -> int:
        return len(self._data)

    @staticmethod
    def read(data: bytes, offset: int = 0) -> Tuple:
        chunk_id = data[offset:offset+4]
        offset += 4

        size = int.from_bytes(data[offset:offset+4], 'big', signed=True)
        offset += 4

        chunk_data = data[offset:offset+size]
        offset += size

        return UnknownQuetzalChunk(chunk_id, chunk_data), offset

    def bytes(self) -> bytes:
        return self.chunk_id() + self.chunk_length.to_bytes(4, 'big', signed=True) + self._data


class IFZSContainer:

    supported_chunks = {
        CMemQuetzalChunk._chunk_id: CMemQuetzalChunk,
        UMemQuetzalChunk._chunk_id: UMemQuetzalChunk,
        StacksQuetzalChunk._chunk_id: StacksQuetzalChunk,
        HeaderQuetzalChunk._chunk_id: HeaderQuetzalChunk
    }

    def __init__(self, chunks: List[QuetzalChunk]):
        self._chunks = chunks

    def _compile_quetzal_chunks(self) -> bytes:
        output = bytearray()
        for chunk in self._chunks:
            output += chunk.bytes()

            # chunks must start on an even-numbered offset, so pad with a 0 if length is odd
            if len(output) % 2 != 0:
                output += b'\x00'

        return bytes(output)

    @staticmethod
    def parse_quetzal_chunk(data: bytes, offset: int) -> Tuple[QuetzalChunk, int]:
        chunk_id = data[offset:offset+4]

        if chunk_id in IFZSContainer.supported_chunks:
            chunk, next_offset = IFZSContainer.supported_chunks[chunk_id].read(data, offset)
        else:
            chunk, next_offset = UnknownQuetzalChunk.read(data, offset)

        return chunk, next_offset

    @staticmethod
    def parse_quetzal_chunks(data: bytes) -> List[QuetzalChunk]:
        offset = 0
        chunks = list()

        while offset < len(data):
            chunk, offset = IFZSContainer.parse_quetzal_chunk(data, offset)
            chunks.append(chunk)

            # chunk offsets can only occur on even numbered offsets
            if offset % 2 != 0:
                offset += 1

        return chunks

    def bytes(self) -> bytes:
        """
        :return: Binary representation of the IFF file
        """
        chunks_binary = self._compile_quetzal_chunks()

        # Total size is size of all chunks, plus 4 for the form indicator
        total_size = len(chunks_binary) + 4

        output = bytearray()
        output += b'FORM'
        output += total_size.to_bytes(4, 'big', signed=True)
        output += b'IFZS'
        output += chunks_binary

        return bytes(output)

    @staticmethod
    def read(ifzs_data: bytes):
        """ Read data and create a new IFZSContainer object from IFZS data.

        :param ifzs_data: Raw data for the IFZS file
        :return: An IFZSContainer object populated with chunks
        :rtype: IFZSContainer
        """
        if ifzs_data[:4] != b'FORM' or ifzs_data[8:12] != b'IFZS':
            raise IFZSReadError('Not a valid IFZS container')

        chunks = IFZSContainer.parse_quetzal_chunks(ifzs_data[12:])

        return IFZSContainer(chunks)

    @property
    def chunks(self) -> List[QuetzalChunk]:
        return self._chunks

    def chunk(self, chunk_id: str) -> Union[None, QuetzalChunk, UnknownQuetzalChunk, HeaderQuetzalChunk, UMemQuetzalChunk, CMemQuetzalChunk, StacksQuetzalChunk]:
        """ Get the first chunk found with the given id

        :param chunk_id: Chunk ID in string
        :return: The first chunk found with the provided id, or None if not found
        """
        chunk_id = chunk_id.encode('ascii')

        for chunk in self._chunks:
            if chunk.chunk_id() == chunk_id:
                return chunk

