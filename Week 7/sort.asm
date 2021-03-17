#   sort.asm	   Kyrie Nguyen
#   sorts numbers in three arrays using three sorting techniques
#   Register use - main
#	$s0, $s1: base addr and length of array A
#	$s2, $s3: base addr and length of array B
#	$s4, $s5: base addr and length of array C
#   Register use - findLength
#	$a0: base address of the array
#       $a1: the end of the array
#   Register use - swap
#       $a0, $a1: addr of two elements to be swapped in an array
#       $t8, $t9: temporary registers to hold the values of those elements
#   Register use - bubbleSort
#	$a0: base address of the array
#       $a1: number of items in array n
#       $s0, $s1: i, j
#       $t0, $t1: A[j], A[j + 1]
#       $t2: offset into array and addr of A[j]
#       $t3, $t4: n - 1, n - 1 - i
#   Register use - selectionSort
#	$a0: base address of the array
#       $a1: number of items in array n
#       $s0, $s1, $s2: i, j, min_idx
#       $t0, $t1, $2: A[i], A[j], A[min_idx]
#       $t3, $t4, $t5: offset into array and addr of A[i], A[j], A[min_idx]
#       $t6: n - 1
#   Register use - insertionSort
#	$a0: base address of the array
#       $a1: number of items in array n
#       $s0, $s1, $s2: i, j, key
#       $t0, $t1: A[i], A[j]
#       $t2, $t3: offset into array and addr of A[i], A[j]

		.data                	# FYI: start of data section
A:		.word -2, -1, -3, 20, 1 
endA:
B:		.word 4, 6, 17, 12, 20, 1
endB:
C:		.word 4, 10, 5, 10, 13, 1, 5
endC:

        .text     # FYI: start of code section
        .align 2  # FYI: align to start code on a word boundary
        .globl main  # FYI: make 'main' visible 


main:			   	# main() {
	la $s0, A               # $s0 = &A[0]
        la $s1, endA            # $s1 = &endA
        move $a0, $s0	        # $a0 = $s0
        move $a1, $s1	        # $a1 = $s1
# find length of A
        addi $sp $sp -12        # save $ra, $s0, $s1
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        move $a0, $s0	        # $a0 = $s0
        jal findLength
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        addi $sp $sp 12        # load $ra, $s0, $s1 and reset $sp
        move $s1, $v0           # $s1 = len(A)
        
        la $s2, B               # $s2 = &B[0]
        la $s3, endB            # $s1 = &endB
        move $a0, $s2	        # $a0 = $s2
        move $a1, $s3	        # $a1 = $s3
# find length of B
        addi $sp $sp -12        # save $ra, $s0, $s1
        sw $ra, 0($sp)
        sw $s2, 4($sp)
        sw $s3, 8($sp)
        move $a0, $s2	        # $a0 = $s2
        move $a1, $s3	        # $a1 = $s3
        jal findLength
        lw $ra, 0($sp)
        lw $s2, 4($sp)
        lw $s3, 8($sp)
        addi $sp $sp 12         # load $ra, $s0, $s1 and reset $sp
        move $s3, $v0           # $s3 = len(B)

        la $s4, C               # $s4 = &C[0]
        la $s5, endC            # $s5 = &endC
        move $a0, $s4	        # $a0 = $s4
        move $a1, $s5	        # $a1 = $s5
# find length of C
        addi $sp $sp -12        # save $ra, $s4, $s5
        sw $ra, 0($sp)
        sw $s4, 4($sp)
        sw $s5, 8($sp)
        move $a0, $s4	        # $a0 = $s4
        move $a1, $s5	        # $a1 = $s5
        jal findLength
        lw $ra, 0($sp)
        lw $s4, 4($sp)
        lw $s5, 8($sp)
        addi $sp $sp 12         # load $ra, $s4, $s5 and reset $sp
        move $s5, $v0           # $s5 = len(C)

# bubble sort A
        addi $sp $sp -12        # save $ra, $s0, $s1
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        move $a0, $s0	        # $a0 = $s0
        move $a1, $s1	        # $a1 = $s1
        jal bubbleSort
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        addi $sp $sp 12         # load $ra, $s0, $s1 and reset $sp

# selection sort B
        addi $sp $sp -12        # save $ra, $s0, $s1
        sw $ra, 0($sp)
        sw $s2, 4($sp)
        sw $s3, 8($sp)
        move $a0, $s2	        # $a0 = $s2
        move $a1, $s3	        # $a1 = $s3
        jal selectionSort
        lw $ra, 0($sp)
        lw $s2, 4($sp)
        lw $s3, 8($sp)
        addi $sp $sp 12         # load $ra, $s0, $s1 and reset $sp

# insertion sort C
        addi $sp $sp -12        # save $ra, $s4, $s5
        sw $ra, 0($sp)
        sw $s4, 4($sp)
        sw $s5, 8($sp)
        move $a0, $s4	        # $a0 = $s4
        move $a1, $s5	        # $a1 = $s5
        jal insertionSort
        lw $ra, 0($sp)
        lw $s4, 4($sp)
        lw $s5, 8($sp)
        addi $sp $sp 12          # load $ra, $s4, $s5 and reset $sp
	
        jr $ra			# return control to simulator
	               	# }

findLength:			# start of findLength function
        sub $a1 $a1 $a0         # $a1 = 4 * len(arr)
        sra $a1 $a1 2           # $a1 = len(arr)
        move $v0, $a1		# $v0 = a1
        jr $ra

swap:                           # swap arr[i] and arr[j]
        lw $t8, 0($a0)          # $t8 = *$a0 = *&arr[i] = arr[i]
        lw $t9, 0($a1)          # $t9 = *$a1 = *&arr[j] = arr[j]
        sw $t8, 0($a1)          # *$a1 = arr[i]
        sw $t9, 0($a0)          # *$a0 = arr[j]
        jr $ra                  # return control to simulator

bubbleSort:                             # start of bubbleSort function
        add $s0, $0, $0			# i = 0
        addi $t3 $a1 -1                 # $t3 = n - 1
bLoopI:
        bge $s0, $t3, bEndloopI
        sub $t4 $t3 $s0                 # $t4 = n - 1 - i
        add $s1 $0 $0		        # j = 0
bLoopJ:
        bge $s1, $t4, bEndloopJ
        sll $t2 $s1 2                   # $t2 = 4 * j
        add $t2 $a0 $t2                 # $t2 = &arr[j]
        lw $t0, 0($t2)                  # $t0 = *$t2 = arr[j]
        lw $t1, 4($t2)                  # $t1 = arr[j + 1]
        ble $t0, $t1, bNoSwap
        addi $sp $sp -20                # save $ra, $a0, $a1, $s0, $s1
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $a0, 12($sp)
        sw $a1, 16($sp)
        move $a0 $t2                    # $a0 = &arr[j]
        move $a1 $t2
        addi $a1 $a1 4                  # $a1 = &arr[j + 1]
        jal swap                        # swap arr[j] and arr[j + 1]
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $a0, 12($sp)
        lw $a1, 16($sp)
        addi $sp $sp 20                 # load $ra, $a0, $a1, $s0, $s1 and reset $sp
bNoSwap:
        addi $s1 $s1 1                  # j++
        j bLoopJ
bEndloopJ:
        addi $s0 $s0 1                  # i++
        j bLoopI
bEndloopI:
        jr $ra

selectionSort:                          # start of selectionSort function
        add $s0 $0 $0			# i = 0
        addi $t6 $a1 -1                 # $t6 = n - 1
sLoopI:
        bge $s0, $t6, sEndloopI
        sll $t3 $s0 2                   # $t3 = 4 * i
        add $t3 $a0 $t3                 # $t3 = &arr[i]
        lw $t0, 0($t3)                  # $t0 = *$t3 = arr[i]
        add $s2 $s0 $0		        # min_idx = i
        addi $s1 $s0 1		        # j = i + 1
sLoopJ:
        bge $s1, $a1, sEndloopJ
        sll $t4 $s1 2                   # $t4 = 4 * j
        add $t4 $a0 $t4                 # $t4 = &arr[j]
        lw $t1, 0($t4)                  # $t1 = *$t4 = arr[j]
        sll $t5 $s2 2                   # $t5 = 4 * min_idx
        add $t5 $a0 $t5                 # $t5 = &arr[min_idx]
        lw $t2, 0($t5)                  # $t2 = *$t5 = arr[min_idx]
        bge $t1, $t2, minStay
        move $s2 $s1                    # min_idx = j
minStay:
        addi $s1 $s1 1                  # j++
        j sLoopJ
sEndloopJ:
        sll $t5 $s2 2                   # $t5 = 4 * min_idx
        add $t5 $a0 $t5                 # $t5 = &arr[min_idx]
        addi $sp $sp -24                # save $ra, $a0, $a1, $s0, $s1, $s2
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)
        sw $a0, 16($sp)
        sw $a1, 20($sp)
        move $a0 $t3                    # $a0 = &arr[i]
        move $a1 $t5                    # $a1 = &arr[min_idx]
        jal swap                        # swap arr[i] and arr[min_idx]
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        lw $a0, 16($sp)
        lw $a1, 20($sp)
        addi $sp $sp 24                 # load $ra, $a0, $a1, $s0, $s1, $s2 and reset $sp
        addi $s0 $s0 1                  # i++
        j sLoopI
sEndloopI:
        jr $ra
        
insertionSort:                          # start of insertionSort function
        addi $s0 $0 1			# i = 0
iLoopI:
        bge $s0, $a1, iEndloopI
        sll $t2 $s0 2                   # $t2 = 4 * i
        add $t2 $a0 $t2                 # $t2 = &arr[i]
        lw $s2, 0($t2)                  # key = *$t2 = arr[i]
        addi $s1, $s0, -1		# j = i - 1
iLoopJ:
        blt $s1, $0, iEndloopJ
        sll $t3 $s1 2                   # $t3 = 4 * j
        add $t3 $a0 $t3                 # $t3 = &arr[j]
        lw $t1, 0($t3)                  # $t1 = *$t3 = arr[j]
        ble $t1, $s2, iEndloopJ
        sw $t1, 4($t3)                  
        addi $s1 $s1 -1                 # j--
        j iLoopJ
iEndloopJ:
        sll $t3 $s1 2                   # $t3 = 4 * j
        add $t3 $a0 $t3                 # $t3 = &arr[j]
        sw $s2, 4($t3)
        addi $s0 $s0 1                  # i++
        j iLoopI 
iEndloopI:
        jr $ra