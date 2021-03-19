# Assembler written by Kyrie Nguyen
# Adopted from John Rieffel

from helperfunctions import *
from config import *

def convertPseudoInstruction(opcode, operands):
    '''
    convert a pseudo-instruction to a list of instructions
    '''
    instructions = []
    if opcode == 'move':
        instructions.append('addi {} {} 0'.format(operands[0], operands[1]))
    else:
        if opcode == 'bgt' or opcode == 'ble':
            opcode = 'blt' if opcode == 'bgt' else 'bge'
            operands[0], operands[1] = operands[1], operands[0]
        if opcode == 'blt':
            instructions.append('slt $13 {} {}'.format(operands[0], operands[1]))
            instructions.append('bne $13 $0 {}'.format(operands[2]))
        if opcode == 'bge':
            instructions.append('slt $13 {} {}'.format(operands[0], operands[1]))
            instructions.append('beq $13 $0 {}'.format(operands[2]))
    return instructions

def convertAssemblyToMachineCode(instruction):
    '''
	given a string corresponding to a line of assembly,
	strip out all the comments, parse it, and convert it into
	a string of binary values
	'''

    outstring = ''

    if instruction.find('#') != -1:
        instruction = instruction[0:instruction.find('#')]  # get rid of anything after a comment
    if instruction != '':
        # pre-process lw and sw instructions
        if '(' in instruction:
            instruction = instruction.replace('(', ' ')
            instruction = instruction.replace(')', '')
        words = instruction.split()  # assuming syntax words are separated by space, not comma
        operation = words[0]
        operands = words[1:]
        if operation in PSEUDOES:
            instructions = convertPseudoInstruction(operation, operands)
            for i in instructions:
                outstring += convertAssemblyToMachineCode(i) + ' '
            return outstring
        opcode = OPCODES[operation][0]
        outstring += opcode
        # check the type of the instruction
        if len(OPCODES[operation]) == 2:
            funct = OPCODES[operation][1]
            if operation != 'jr':
                for operand in operands:
                    register = operand[1:]
                    if register in REGISTERS.keys():
                        register = REGISTERS[register]
                    outstring += int2bs(register, BITS_PER_REGISTER)
            else:
                src1 = operands[0]
                register = src1[1:]
                if register in REGISTERS.keys():
                    register = REGISTERS[register]
                outstring += f'0000{int2bs(register, BITS_PER_REGISTER)}0000'
            outstring += funct
        else:
            if opcode[0] == '0':
                dest, src, imm = operands[0], operands[1], operands[2]
                if operation in ('lw', 'sw'):
                    src, imm = imm, src
                operands = (dest, src, imm)
                for operand in operands:
                    if operand[0] == '$':
                        register = operand[1:]
                        if register in REGISTERS.keys():
                            register = REGISTERS[register]
                        outstring += int2bs(register, BITS_PER_REGISTER)
                    else:
                        outstring += int2bs(imm, BITS_FOR_IMM['I'])
            else:
                outstring += int2bs(operands[0], BITS_FOR_IMM['J'])
    print(outstring)
    return outstring


def assemblyToHex(infileName, outfileName):
    '''
	given an ascii assembly file , read it in line by line and convert each line of assembly to machine code
	and hex. Then save that hex to an outputFile
	'''

    outlines = []
    f = open(infileName)
    lines = []
    for line in f:
        lines.append(line.strip())

    for curline in lines:
        outstring = convertAssemblyToMachineCode(curline)
        if outstring != '':
            outlines += outstring.split()
    f.close()

    out = open(outfileName, 'w')
    out.write("v2.0 raw\n")  # Logisim .hex files need this as 1st line
    for outline in outlines:
        out.write("  " + bs2hex(outline))
        out.write("\n")
    out.close()


if __name__ == "__main__":
    name = input()
    inputFile = TEST_FOLDER + name + ".asm"
    outputFile = IMAGE_FOLDER + name + ".hex"
    assemblyToHex(inputFile, outputFile)
