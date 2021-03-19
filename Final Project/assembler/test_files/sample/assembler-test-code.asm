# This example assumes the 14-bit instruction word used in Lab 4.
# You'll need to make changes that correspond to your own instruction word.
# add $1 $2 $3  # should become 00000 001 010 011 = 0000 0000 0101 0011 = 0x0053
# sub $7 $5 $2  # should become 00011 111 101 010 = 0000 0111 1110 1010 = 0x07ea
# addi $1 $2 10
# addi $sp $sp 4
# lw $6 76($4)
# move $9 $10
blt $1 $3 10