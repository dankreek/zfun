import pytest

from zfun import ZMachineDictionary, get_header, z_string


def test_dictionary_word_separators(zork_v3_dict: ZMachineDictionary):
    separators = zork_v3_dict.word_separators
    assert separators == [ord(','), ord('.'), ord('"')]


dict_entries_test_cases = [
    (1, '$ve'),
    (243, 'fuck'),
    (535, 'shit'),
    (238, 'froboz'),
    (697, 'zzmgck')
]


@pytest.mark.parametrize('entry_num,expected_text', dict_entries_test_cases)
def test_dictionary_entries(entry_num: int, expected_text: str, zork_v3_dict: ZMachineDictionary):
    entry = zork_v3_dict.entry(entry_num)
    assert entry.text == expected_text
    assert len(entry.data) == 3


# ('leaves', 347, 'why doesn\'t this work?')
def test_word_lookup_v3_leaves_bug(zork_v3_dict: ZMachineDictionary):
    word_addr = zork_v3_dict.lookup_word('leave')
    assert word_addr == zork_v3_dict.entry_addr(347)

    word_addr = zork_v3_dict.lookup_word('leaves')
    assert word_addr == zork_v3_dict.entry_addr(348)


word_lookup_test_cases_v3 = [
    ('zzmgck', 697, 'Finds last word'),
    ('zorkmi', 696, 'Second-to-last word'),
    ('a', 5, 'Finds first alphabetical word'),
    ('lid', 351, 'Finds the middlest word'),
    ('Air', 11, 'Finds capitalized words'),
    ('air-p', 12, 'Finds words with symbols in them'),
    ('bracelet', 74, 'Finds a word that needs to be truncated'),
    (',', 3, 'Finds a word separator character'),
]


@pytest.mark.parametrize('word,expected_entry_num,desc', word_lookup_test_cases_v3)
def test_word_lookup_v3(word: str, expected_entry_num: int, desc: str, zork_v3_dict: ZMachineDictionary):
    word_addr = zork_v3_dict.lookup_word(word)
    assert word_addr == zork_v3_dict.entry_addr(expected_entry_num), desc


word_lookup_test_cases_v5 = [
    ('zzmgck', 692, 'Finds last word'),
    ('a', 9, 'Finds first alphabetical word'),
    ('ledge', 342, 'Finds the middlest word'),
    ('Air', 16, 'Finds capitalized words'),
    ('air-pump', 17, 'Finds words with symbols in them'),
    ('disenchant', 166, 'Finds a word that needs to be truncated'),
    (',', 3, 'Finds a word separator character'),
]


@pytest.mark.parametrize('word,expected_entry_num,desc', word_lookup_test_cases_v5)
def test_word_lookup_v5(word: str, expected_entry_num: int, desc: str, zork_v5_dict: ZMachineDictionary):
    word_addr = zork_v5_dict.lookup_word(word)
    assert word_addr == zork_v5_dict.entry_addr(expected_entry_num), desc


def test_word_lookup_not_found(zork_v3_dict: ZMachineDictionary, zork_v5_dict: ZMachineDictionary):
    assert 0 == zork_v3_dict.lookup_word('poop')
    assert 0 == zork_v5_dict.lookup_word('pistolgrippump')
