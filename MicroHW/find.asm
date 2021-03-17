# Program to find the index of a value in an array
# $t0: number of integers in array A, n
# $a0: base address of array A
# $a1: target value to search for, target
# $s0: the index of the target value in
#      array A; -1 if not found
# $s1: a constant register that holds -1
# $t6: loop index
# $t7: offset into array

find:
    addi $s0 $0 -1          # initialize $s0 = -1
    add $s1 $s0 0           # $s1 = $s0 = -1
    add $t6 $0 $0           # i = 0
loop:                       # while ($s0 == -1 && i < n)
    bne $s0 $s1 endloop     # branch if $s0 != -1
    bge $t6 $t0 endloop     # branch if i >= n
    sll $t7 $t6 2           # $t7 = 4 * i
    add $t2 $t7 $a0         # $t2 = *A[i]
    lw $t3 0($t2)           # $t3 = A[i]
    bne $t3 $a1 notFound    # branch if A[i] != target 
    add $s0 $t6 $0          # $s0 = i, in case of no branching
notFound:
    addi $t6 $t6 1          # go to the next index
    j loop
endloop:

