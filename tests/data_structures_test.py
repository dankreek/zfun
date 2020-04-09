from zfun import parse_z_string, z_string


def test_z_string():
    val = z_string('aaa')
    assert val == bytes([0x98, 0xc6])


def test_lowercase_single_word():
    test_str = '%a!aaA#q=%'
    test_z_str = z_string(test_str)
    output = parse_z_string(test_z_str, 0)

    assert output == test_str


