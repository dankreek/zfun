import sys
from typing import Tuple
from zfun import get_header, ZCodeHeader, ZMachineDictionary


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, bytes]:
    with open(file_path, 'rb') as f:
        data = f.read()
        header = get_header(data)
        return header, data


def main(argv):
    header, data = header_and_data(argv[1])
    dictionary = ZMachineDictionary(data, header)

    for i in range(1, dictionary.number_of_entries+1):
        entry = dictionary.entry(i)
        print(f'{i} = {entry.text}')

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
