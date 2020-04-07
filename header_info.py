import sys
import zfun


def main(argv):
    header = zfun.read_header(argv[1])
    print(f'Version={header.version}')

    try:
        print(f'Status line type={header.status_line_type}')
    except zfun.UnsupportedVersionError:
        pass

    print(f'Release number={header.release_number}')
    print(f'Paged memory address={hex(header.paged_memory_address)}')
    print(f'Dictionary address={hex(header.dictionary_address)}')
    print(f'Object table address={hex(header.object_table_address)}')
    print(f'Global vars address={hex(header.global_vars_address)}')
    print(f'Static memory address={hex(header.static_memory_address)}')
    print(f'First instruction={hex(header.first_instruction)}')
    print(f'Serial code={header.serial_code}')

    try:
        print(f'File length={header.file_length}')
    except zfun.UnsupportedVersionError:
        pass


if __name__ == '__main__':
    sys.exit(main(sys.argv))

