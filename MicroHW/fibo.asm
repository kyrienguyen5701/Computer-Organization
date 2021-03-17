        .data                	# FYI: start of data section
n:		.word 10

        .text     # FYI: start of code section
        .align 2  # FYI: align to start code on a word boundary
        .globl main  # FYI: make 'main' visible 


main:			   	# main() {
    addi $sp $sp -4
    sw $ra 0($sp)
    lw $a0 n
    jal fibo
    move $s0 $v0
    lw $ra 0($sp)
    addi $sp $sp 4
    move $t1 $v0
    jr $ra

fibo:
    addi $t0 $0 1
    beq $a0 $0 ifBody
    bne $a0 $t0 else
ifBody:
    move $v0 $t0
    j return

else:
    addi $sp $sp -8
    sw $ra 0($sp)
    sw $a0 4($sp)
    addi $a0 $a0 -1
    jal fibo
    move $t1 $v0
    lw $ra 0($sp)
    lw $a0 4($sp)
    addi $sp $sp 8
    addi $sp $sp -12
    sw $ra 0($sp)
    sw $a0 4($sp)
    sw $t1 8($sp)
    addi $a0 $a0 -2
    jal fibo
    move $t2 $v0
    lw $ra 0($sp)
    lw $a0 4($sp)
    lw $t1 8($sp)
    addi $sp $sp 12
    add $v0 $t1 $t2

return:
    jr $ra
