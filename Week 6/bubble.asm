#   bubble.asm       Kyrie Nguyen
#   sort an array in the ascending order
#   Register use:
#	$s0: base addr of A
#	$s1: number of items in array
#   $s2, s3: numbers of iterations for each loop
#   $t0, $t1: i, j
#   $t2, $t3: A[j], A[j + 1]
#   $t6: offset into array and addr of A[j]

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
	add $t0, $0, $0			        # i = 0
    addi $s2 $s1 -1                 # $s2 = n - 1
loopI:
    bge $t0, $s2, endloopI
    sub $s3 $s2 $t0                 # $s3 = n - 1 - i
    add $t1 $0 $0		            # j = 0
loopJ:
    bge $t1, $s3, endloopJ
    sll $t6 $t1 2                   # $t6 = 4 * j
    add $t6 $s0 $t6                 # $t6 = &A[j]
    lw $t2, 0($t6)                  # $t2 = *$t6 = A[j]
    lw $t3, 4($t6)                  # $t3 = A[j + 1]
    ble $t2, $t3, noSwap
    sw $t2, 4($t6) 
    sw $t3, 0($t6)
noSwap:
    addi $t1 $t1 1                  # j++
    j loopJ
endloopJ:
    addi $t0 $t0 1                  # i++
    j loopI
endloopI:
    jr $ra