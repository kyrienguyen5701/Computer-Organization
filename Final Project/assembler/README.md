# Python assembler for this CPU
This assembler can:
1. Take in a .asm file from the input (you only need to specify the name of the file) and convert lines of assembly code into a file of hexadecimal machine instruction words
2. Decipher either addresses or names of registers - available names in [config.py](config.py). More information are noted here:
- Register 0: dedicated for constant 0
- Register 1-5 ($t1-$t5): temporary variables
- Register 6-9 ($s1-$s4): saved variables
- Register 10 and 11 ($a0-$a1): function arguments
- Register 12 ($v0): function return value
- Register 13 ($t6): semi-dedicated to be the destination register in the slt instruction generated by pseudo-instructions; you can use it to assign a temporary variable but be aware.
- Register 14 ($ra): function return address
- Register 15 ($sp): stack pointer
3. Ignore any comments (a.k.a anything behind #)
4. Convert pseudo-instructions move, bge, ble, bgt, blt into ordinary instructions

Note that while the CPU requires the $sp to be initially set at ffff, the assembler HAS NOT accounted for that, so make sure to do it at the beginning of the .asm file if you ever need to use $sp.