import sys
import zfun


def main(argv):
    header = zfun.read_header(argv[1])
    print(f'Version={header.version}')

    if header.version == 3:
        print(f'Status line type={header.status_line_type}')
        print(f'File split? {header.is_file_split}')
        print(f'High memory address={hex(header.high_memory_address)}')
        print(f'First instruction={hex(header.initial_pc_value)}')
        print(f'Dictionary address={hex(header.dictionary_address)}')
        print(f'Object table address={hex(header.object_table_address)}')
        print(f'Global vars address={hex(header.global_var_table_address)}')
        print(f'Static memory address={hex(header.static_memory_address)}')
        print(f'Abbreviations table address={hex(header.abbreviations_table_address)}')
        print(f'File length={header.file_length}')
        print(f'Rev #{header.std_rev_number}')


if __name__ == '__main__':
    sys.exit(main(sys.argv))

