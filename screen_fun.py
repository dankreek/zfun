from curses import wrapper
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
    interface = ZMachineCursesScreenV3()
    interpreter = ZMachineInterpreterV3(header, data, interface, interface, interface)
    return interpreter


def run(_, game_file):
    while True:
        interpreter = new_interpreter(game_file)
        try:
            interpreter.initialize()
            interpreter.run()
        except ZMachineExitException:
            return
        except ZMachineResetException:
            pass
        finally:
            interpreter.terminate()


def main(argv):
    wrapper(run, argv[1])


if __name__ == '__main__':
    sys.exit(main(sys.argv))
