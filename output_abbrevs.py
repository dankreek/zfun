import sys
from typing import Tuple


from zfun import get_header, z_string_to_str, ZCodeHeader, abbreviation_to_ascii


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, bytes]:
    with open(file_path, 'rb') as f:
        data = f.read()
        header = get_header(data)
        return header, data


def main(argv):
    header, data = header_and_data(argv[1])
    print(f'Abbrev table at: {hex(header.abbreviations_table_address)}')

    for i in range(96):
        abbrev_str = bytes(abbreviation_to_ascii(data, header.abbreviations_table_address, i)).decode('ascii')
        print(f'{i}: "{abbrev_str}"')

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
