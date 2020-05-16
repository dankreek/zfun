import sys
from typing import Tuple
from zfun import get_header, ZCodeHeader, ZMachineDictionary, z_string


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, bytes]:
    with open(file_path, 'rb') as f:
        data = f.read()
        header = get_header(data)
        return header, data


def main(argv):
    header, data = header_and_data(argv[1])
    dictionary = ZMachineDictionary(data, header)

    for i in range(0, dictionary.number_of_entries):
        entry = dictionary.entry(i)
        dict_z_str = z_string(entry.text, dictionary.entry_length - 4)
        print(f'{i} = ${entry.encoded_text.hex()} {entry.text} ${dict_z_str.hex()}')

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
