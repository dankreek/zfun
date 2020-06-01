import sys
import lorem
from io import BytesIO
from zfun import get_header, ZCodeHeader, ZMachineInterpreterV3
from typing import Tuple

from tests.curses_screen import ZMachineCursesScreenV3


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, memoryview]:
    with open(file_path, 'rb') as f:
        data = BytesIO(f.read())
        view = data.getbuffer()

        header = get_header(view)
        return header, view


def main(argv):
    header, data = header_and_data(argv[1])
    screen = ZMachineCursesScreenV3()
    interpreter = ZMachineInterpreterV3(header, data, screen, screen)

    try:
        interpreter.initialize()
        interpreter.run()
    finally:
        interpreter.terminate()


if __name__ == '__main__':
    sys.exit(main(sys.argv))
