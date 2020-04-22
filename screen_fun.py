import sys
from io import BytesIO
from zfun import ZMachineCursesScreen, get_header, ZCodeHeader
from typing import Tuple


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, memoryview]:
    with open(file_path, 'rb') as f:
        data = BytesIO(f.read())
        view = data.getbuffer()

        header = get_header(view)
        return header, view


def main(argv):
    header, data = header_and_data(argv[1])
    screen = ZMachineCursesScreen(header)

    try:
        screen.initialize()
        screen.update_status('holy HELL', 11, 1)

        for i in range(15):
            screen.print_main_win(f'{i}\n')

        screen.main_win.getch()

        return 0
    finally:
        screen.terminate()


if __name__ == '__main__':
    sys.exit(main(sys.argv))
