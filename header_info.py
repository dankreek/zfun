import sys
import zfun


def main(argv):
    header = zfun.read_header(argv[1])
    print(f'Version={header.version}')
    print(f'Release number={header.release_number}')
    print(f'Paged memory address={hex(header.paged_memory_address)}')
    print(f'First instruction={hex(header.first_instruction)}')
    print(f'Status line type={header.status_line_type}')


if __name__ == '__main__':
    sys.exit(main(sys.argv))

