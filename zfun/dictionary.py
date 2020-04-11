from typing import List, Union, NamedTuple

from .z_string import z_string_to_str
from .util import read_word
from .header import ZCodeHeader


class DictionaryEntry(NamedTuple):
    text: str
    data: Union[memoryview, bytes]


class Dictionary:
    """ Z-Machine dictionary functionality """

    def __init__(self, memory: memoryview, header: ZCodeHeader):
        """
        :param memory: Memory to read dictionary from
        :param header: Z-Code header for the story
        """
        self._memory = memory
        self._addr = header.dictionary_address
        self._abbrev_table_addr = header.abbreviations_table_address
        self._version = header.version

    @property
    def _separators_len(self) -> int:
        return self._memory[self._addr]

    @property
    def _entry_length(self) -> int:
        return self._memory[self._addr + 1 + self._separators_len]

    @property
    def word_separators(self) -> List[int]:
        """ List of ZSCII input codes which are considered word separators """
        return [
            self._memory[self._addr + 1 + i]
            for i in range(self._separators_len)
        ]

    @property
    def number_of_entries(self) -> int:
        """ Number of dictionary entries """
        return read_word(self._memory, self._addr + 1 + self._separators_len + 1)

    @property
    def encoded_text_len(self) -> int:
        """ Length (in bytes) of the encoded text for a dictionary entry for the Z-machine version """

        # TODO: Should this be set as an abstract implementation for clarity later?
        # Version 1-3 have 3 byte (4 z-chars) encoded text length
        if self._version <= 3:
            return 4
        # Versions 4-6 have 6 bytes (9 z-chars)
        else:
            return 6

    def entry(self, entry_num: int) -> DictionaryEntry:
        """ Get dictionary entry

        :param entry_num: Dictionary entry number
        :return: The text of the dictionary word and its associated data
        """
        assert entry_num >= 0

        if entry_num >= self.number_of_entries:
            raise ValueError(f'Out of range, dictionary contains {self.number_of_entries} entries')
        else:
            entries_base_addr = self._addr + 1 + self._separators_len + 3
            offset = entry_num * self._entry_length
            entry_addr = entries_base_addr + offset

            encoded_text = z_string_to_str(self._memory, entry_addr, self._abbrev_table_addr)
            data = self._memory[entry_addr + self.encoded_text_len:entry_addr + self._entry_length]
            return DictionaryEntry(encoded_text, data)

