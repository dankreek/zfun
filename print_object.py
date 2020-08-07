import sys
from typing import Tuple
from zfun import get_header, ZCodeHeader, ZMachineObjectTable, ZMachineObject


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, bytes]:
    with open(file_path, 'rb') as f:
        data = f.read()
        header = get_header(data)
        return header, data


def print_object(num: int, obj: ZMachineObject):
    print(f'Object #{num}: {obj.properties.name}')
    print(f'Attributes: #{obj.attributes}')
    print(f'Properties:')

    for num, value in obj.properties.own_properties.items():
        print(f'\t#{num}: {value.hex()}')

def main(argv):
    header, data = header_and_data(argv[1])
    obj_table = ZMachineObjectTable(data, header)

    obj_num = int(argv[2])
    obj = obj_table.object(obj_num)
    print_object(obj_num, obj)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
