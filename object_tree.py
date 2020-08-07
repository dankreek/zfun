import sys
from typing import Tuple
from zfun import get_header, ZCodeHeader, ZMachineObjectTable


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, bytes]:
    with open(file_path, 'rb') as f:
        data = f.read()
        header = get_header(data)
        return header, data


def print_obj_tree(obj_tree: dict, depth=0):
    tabs = '\t' * depth
    print(f'{tabs}{obj_tree["number"]}={obj_tree["object"].properties.name}')

    for child in obj_tree['children']:
        print_obj_tree(child, depth + 1)


def main(argv):
    header, data = header_and_data(argv[1])
    obj_table = ZMachineObjectTable(data, header)

    for i in range(1, 223):
        if obj_table.object(i).parent == 0:
            obj_tree = obj_table.obj_tree(i)
            print_obj_tree(obj_tree)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
