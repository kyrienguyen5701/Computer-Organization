#   insertion.asm       Kyrie Nguyen
#   sort an array in the ascending order
#   Register use:
#	$s0: base addr of A
#	$s1: number of items in array
#   $t0, $t1, $t2: i, j, key
#   $t3, $t4: A[i], A[j]
#   $t6, $t7: offset into array and addr of A[i], A[j]

		.data                	    # FYI: start of data section
A:		.word -2, -1, -3, 20, 1 
endA:   
        .text                   	# FYI: start of code section
        .align 2                	# FYI: align to start code on a word boundary
        .globl main             	# FYI: make 'main' visible to the simulator
main:
	la $s0, A				        # $s0 = &A[0]
	la $s1, endA			        # $s1 = &endA
	sub $s1 $s1 $s0                 # $s1 = 4 * len(A)
	sra $s1 $s1 2                   # $s1 = len(A)
	addi $t0 $0 1			        # i = 0
loopI:
    bge $t0, $s1, endloopI
    sll $t6 $t0 2                   # $t6 = 4 * i
    add $t6 $s0 $t6                 # $t6 = &A[i]
    lw $t2, 0($t6)                  # key = *$t6 = A[i]
    addi $t1, $t0, -1		        # j = i - 1
loopJ:
    blt $t1, $0, endloopJ
    sll $t7 $t1 2                   # $t7 = 4 * j
    add $t7 $s0 $t7                 # $t7 = &A[j]
    lw $t4, 0($t7)                  # $t4 = *$t7 = A[j]
    ble $t4, $t2, endloopJ
    sw $t4, 4($t7)                  # 
    addi $t1 $t1 -1                 # j--
    j loopJ
endloopJ:
    sll $t7 $t1 2                   # $t7 = 4 * j
    add $t7 $s0 $t7                 # $t7 = &A[j]
    sw $t2, 4($t7)
    addi $t0 $t0 1                  # i++
    j loopI 
endloopI:
    jr $ra