# test sp and function via recursion
# find the sum of numbers from 0 to n
# Register use:
# $1: sample input
# Passes if $v0 holds value 10

addi $sp $sp -1
addi $1 $0 4
move $a0 $1         # $a0 = $t1
jal 5
j 21
addi $sp $sp -2     # start of 0ToNSum
sw $ra 0($sp)
sw $a0 1($sp)
bne $a0 $0 5         
move $v0 $a0        # $v0 = $a0
lw $ra 0($sp)
lw $a0 1($sp)
addi $sp $sp 2
jr $ra
addi $a0 $a0 -1
jal 5
lw $ra 0($sp)
lw $a0 1($sp)
addi $sp $sp 2
add $v0 $a0 $v0
jr $ra