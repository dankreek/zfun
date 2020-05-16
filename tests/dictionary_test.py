import pytest

from zfun import ZMachineDictionary, get_header


@pytest.fixture
def zork_v5_dict(zork1_v5_data: memoryview) -> ZMachineDictionary:
    header = get_header(zork1_v5_data)
    yield ZMachineDictionary(zork1_v5_data, header)


@pytest.fixture
def zork_v3_dict(zork1_v3_data: memoryview) -> ZMachineDictionary:
    header = get_header(zork1_v3_data)
    yield ZMachineDictionary(zork1_v3_data, header)


def test_dictionary_word_separators(zork_v3_dict: ZMachineDictionary):
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
def test_dictionary_entries(entry_num: int, expected_text: str, zork_v3_dict: ZMachineDictionary):
    entry = zork_v3_dict.entry(entry_num)
    assert entry.text == expected_text
    assert len(entry.data) == 3


word_lookup_test_cases_v3 = [
    ('zzmgck', 696, 'Finds last word'),
    ('a', 4, 'Finds first alphabetical word'),
    ('lid', 350, 'Finds the middlest word'),
    ('Air', 10, 'Finds capitalized words'),
    ('air-p', 11, 'Finds words with symbols in them'),
    ('bracelet', 73, 'Finds a word that needs to be truncated'),
    (',', 2, 'Finds a word separator character'),
]


@pytest.mark.parametrize('word,expected_entry_num,desc', word_lookup_test_cases_v3)
def test_word_lookup_v3(word: str, expected_entry_num: int, desc: str, zork_v3_dict: ZMachineDictionary):
    word_addr = zork_v3_dict.lookup_word(word)
    assert word_addr == zork_v3_dict.entry_addr(expected_entry_num), desc


word_lookup_test_cases_v5 = [
    ('zzmgck', 691, 'Finds last word'),
    ('a', 8, 'Finds first alphabetical word'),
    ('ledge', 341, 'Finds the middlest word'),
    ('Air', 15, 'Finds capitalized words'),
    ('air-pump', 16, 'Finds words with symbols in them'),
    ('disenchant', 165, 'Finds a word that needs to be truncated'),
    (',', 2, 'Finds a word separator character'),
]


@pytest.mark.parametrize('word,expected_entry_num,desc', word_lookup_test_cases_v5)
def test_word_lookup_v5(word: str, expected_entry_num: int, desc: str, zork_v5_dict: ZMachineDictionary):
    word_addr = zork_v5_dict.lookup_word(word)
    assert word_addr == zork_v5_dict.entry_addr(expected_entry_num), desc


def test_word_lookup_not_found(zork_v3_dict: ZMachineDictionary, zork_v5_dict: ZMachineDictionary):
    assert 0 == zork_v3_dict.lookup_word('poop')
    assert 0 == zork_v5_dict.lookup_word('pistolgrippump')
