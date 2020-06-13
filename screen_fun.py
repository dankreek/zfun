import sys
from io import BytesIO
from zfun import get_header, ZCodeHeader, ZMachineInterpreterV3, ZMachineExitException, ZMachineResetException
from typing import Tuple

from tests.curses_screen import ZMachineCursesScreenV3


def header_and_data(file_path: str) -> Tuple[ZCodeHeader, memoryview]:
    with open(file_path, 'rb') as f:
        data = BytesIO(f.read())
        view = data.getbuffer()

        header = get_header(view)
        return header, view


def new_interpreter(file_name: str):
    header, data = header_and_data(file_name)
    screen = ZMachineCursesScreenV3()
    interpreter = ZMachineInterpreterV3(header, data, screen, screen)
    return interpreter


def main(argv):
    interpreter = new_interpreter(argv[1])
    while True:
        try:
            interpreter.initialize()
            interpreter.run()
        except ZMachineExitException:
            interpreter.terminate()
            sys.exit(0)
        except ZMachineResetException:
            interpreter.terminate()
            interpreter = new_interpreter(argv[1])
        except Exception as e:
            interpreter.terminate()
            raise e


if __name__ == '__main__':
    sys.exit(main(sys.argv))
