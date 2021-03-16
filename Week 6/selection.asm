#   selection.asm       Kyrie Nguyen
#   sort an array in the ascending order
#   Register use:
#	$s0: base addr of A
#	$s1: number of items in array
#   $s2: numbers of iteration for the first loop
#   $t0, $t1, $t2: i, j, min_idx
#   $t3, $t4, $5: A[i], A[j], A[min_idx]
#   $t6, $t7, $t8: offset into array and addr of A[i], A[j], A[min_idx]

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
	add $t0 $0 $0			        # i = 0
    addi $s2 $s1 -1                 # $s2 = n - 1
loopI:
    bge $t0, $s2, endloopI
    sll $t6 $t0 2                   # $t6 = 4 * i
    add $t6 $s0 $t6                 # $t6 = &A[i]
    lw $t3, 0($t6)                  # $t3 = *$t6 = A[i]
    add $t2 $t0 $0		            # min_idx = i
    addi $t1 $t0 1		            # j = i + 1
loopJ:
    bge $t1, $s1, endloopJ
    sll $t7 $t1 2                   # $t7 = 4 * j
    add $t7 $s0 $t7                 # $t7 = &A[j]
    lw $t4, 0($t7)                  # $t4 = *$t7 = A[j]
    sll $t8 $t2 2                   # $t8 = 4 * min_idx
    add $t8 $s0 $t8                 # $t8 = &A[min_idx]
    lw $t5, 0($t8)                  # $t5 = *$t8 = A[min_idx]
    bge $t4, $t5, minStay
    add $t2 $t1 $0                  # min_idx = j
minStay:
    addi $t1 $t1 1                  # j++
    j loopJ
endloopJ:
    sll $t8 $t2 2                   # $t8 = 4 * min_idx
    add $t8 $s0 $t8                 # $t8 = &A[min_idx]
    lw $t5, 0($t8)                  # $t5 = *$t8 = A[min_idx]
    sw $t3, 0($t8)                  # *$t8 = A[i]
    sw $t5, 0($t6)                  # *$t6 = A[min_idx]
    addi $t0 $t0 1                  # i++
    j loopI
endloopI:
    jr $ra