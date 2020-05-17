import math
from typing import List, Union, NamedTuple

from .z_string import z_string_to_str, z_string
from .util import read_word
from .header import ZCodeHeader


class DictionaryEntry(NamedTuple):
    text: str
    encoded_text: Union[memoryview, bytes]
    data: Union[memoryview, bytes]


class ZMachineDictionary:
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
    def entry_length(self) -> int:
        """ The length, in bytes, of an entire dictionary entry """
        return self._memory[self._addr + 1 + self._separators_len]

    @property
    def word_length(self) -> int:
        """ Maximum length of a word, in characters, in a dictionary entry """
        if self._version <= 3:
            return 6
        else:
            return 9

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
    def decoded_text_len(self) -> int:
        """ Length (in bytes) of the encoded text for a dictionary entry for the Z-machine version """

        # Version 1-3 have 3 byte (4 z-chars) encoded text length
        if self._version <= 3:
            return 4
        # Versions 4-6 have 6 bytes (9 z-chars)
        else:
            return 6

    def entry_addr(self, entry_num: int) -> int:
        """ Get the memory offset of the dictionary entry number

        :param entry_num:
        :return:
        """
        assert 0 <= entry_num < self.number_of_entries

        entries_base_addr = self._addr + 1 + self._separators_len + 3
        offset = entry_num * self.entry_length
        return entries_base_addr + offset

    def entry(self, entry_num: int) -> DictionaryEntry:
        """ Get dictionary entry

        :param entry_num: Dictionary entry number
        :return: The text of the dictionary word and its associated data
        """
        assert entry_num >= 0

        if entry_num >= self.number_of_entries:
            raise ValueError(f'Out of range, dictionary contains {self.number_of_entries} entries')
        else:
            entry_addr = self.entry_addr(entry_num)
            encoded_text_len = self.entry_length - 4

            encoded_text = self._memory[entry_addr:entry_addr+encoded_text_len]
            decoded_text = z_string_to_str(self._memory, entry_addr, self._abbrev_table_addr)
            data = self._memory[entry_addr + self.decoded_text_len:entry_addr + self.entry_length]
            return DictionaryEntry(decoded_text, encoded_text, data)

    def lookup_word(self, word: str) -> int:
        """ Lookup a word in the dictionary and return its memory address.

        :param word: Word to lookup in the dictionary
        :return: The address in memory of the dictionary entry, or 0 if the word is not found
        """
        lookup_bytes = z_string(word.lower(), self.entry_length - 4)

        # Perform a binary search to find the dictionary word
        left = 0
        right = self.number_of_entries - 1
        while left <= right:
            i = (left + right) // 2
            entry = self.entry(i)
            if lookup_bytes == entry.encoded_text:
                return self.entry_addr(i)
            else:
                lookup_int = int.from_bytes(lookup_bytes, byteorder='big', signed=False)
                encoded_int = int.from_bytes(entry.encoded_text, byteorder='big', signed=False)

                if lookup_int > encoded_int:
                    left = i + 1
                else:
                    right = i - 1

        return 0

