import sys
import lorem
from io import BytesIO
from zfun import ZMachineCursesScreenV3, get_header, ZCodeHeader
from typing import Tuple


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, memoryview]:
    with open(file_path, 'rb') as f:
        data = BytesIO(f.read())
        view = data.getbuffer()

        header = get_header(view)
        return header, view


def main(argv):
    header, data = header_and_data(argv[1])
    screen = ZMachineCursesScreenV3(header)

    def more_prompt():
        screen.std_scr.getch()

    try:
        screen.initialize()
        screen.update_status('Holy Hell', 11, 1)
        screen.is_status_displayed = True

        for i in range(10):
            screen.print(f'{i}\t' + lorem.paragraph() + '\n', more_prompt)

        thing = screen.read_string()
        screen.print(f'Read: {thing}', more_prompt)
        screen.std_scr.getch()

        return 0
    finally:
        screen.terminate()


if __name__ == '__main__':
    sys.exit(main(sys.argv))
