# number of bits
BITS_PER_REGISTER = 4
BITS_FOR_IMM = {
    'I': 8,
    'J': 16
}

# name for registers
REGISTERS = {
    '0': '0',
    't1': '1',
    't2': '2',
    't3': '3',
    't4': '4',
    't5': '5',
    's1': '6',
    's2': '7',
    's3': '8',
    's4': '9',
    'a0': '10',
    'a1': '11',
    'v0': '12',
    't6': '13',
    'ra': '14',
    'sp': '15'
}

# pseudo-instructions
PSEUDOES = ('move', 'blt', 'bgt', 'ble', 'bge')

# folders
TEST_FOLDER = "test_files/"
IMAGE_FOLDER = "hex_files/"

# map instructions to opcodes
OPCODES = {
    # R-type
    'add': ['00000', '0000'],
    'and': ['00000', '0001'],
    'or': ['00000', '0010'],
    'sub': ['00000', '0011'],
    'slt': ['00000', '0111'],
    'jr': ['00000', '1000'],
    # I-type
    'addi': ['01000'],
    'andi': ['01001'],
    'ori': ['01010'],
    'subi': ['01011'],
    'bne': ['01100'],
    'lw': ['01101'],
    'sw': ['01110'],
    'beq': ['01111'],
    # J-type
    'j': ['11000'],
    'jal': ['11100'],
}