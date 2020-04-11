import pytest
import os.path as path
import io

from zfun import z_string_to_str, z_string, abbreviation_to_ascii, get_header


def test_to_z_string():
    val = z_string('aaa')
    assert val == bytes([0x98, 0xc6])


simple_z_string_cases = [
    ('a', 'single lower case letter'),
    ('ab', 'length 2 lower case letters'),
    ('abc', 'length 3 lower case letters'),
    ('abcd', 'length 4 lower case letters'),
    ('The', 'mixed case string'),
    ('The 0-bomb!', 'mixed case with special chars'),
    ('The 100%', 'special chars and literal ZSCII')
]


@pytest.mark.parametrize('test_str,desc', simple_z_string_cases)
def test_parsing_simple_z_strings(test_str, desc):
    test_z_str = z_string(test_str)
    output = z_string_to_str(test_z_str, 0)
    assert output == test_str, desc


abbreviation_to_ascii_cases = [(0, 'the '), (12, '. '), (49, 'staircase ')]


@pytest.mark.parametrize('index, expected', abbreviation_to_ascii_cases)
def test_abbreviation_to_ascii(index, expected, zork1_v3_data: memoryview):
    abbrev_table_addr = get_header(zork1_v3_data).abbreviations_table_address
    ascii_list = abbreviation_to_ascii(zork1_v3_data, abbrev_table_addr, index)
    assert bytes(ascii_list).decode('ascii') == expected


def test_interpolating_abbreviations():
    pass
