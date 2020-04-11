import pytest

from zfun import Dictionary, get_header


@pytest.fixture
def zork_v3_dict(zork1_v3_data: memoryview) -> Dictionary:
    header = get_header(zork1_v3_data)
    yield Dictionary(zork1_v3_data, header)


def test_dictionary_word_separators(zork_v3_dict: Dictionary):
    separators = zork_v3_dict.word_separators
    assert separators == [ord(','), ord('.'), ord('"')]


dict_entries_test_cases = [
    (0, '$ve'),
    (242, 'fuck'),
    (534, 'shit'),
    (237, 'froboz'),
    (696, 'zzmgck')
]


@pytest.mark.parametrize('entry_num,expected_text', dict_entries_test_cases)
def test_dictionary_entries(entry_num: int, expected_text: str, zork_v3_dict: Dictionary):
    entry = zork_v3_dict.entry(entry_num)
    assert entry.text == expected_text
    assert len(entry.data) == 3



