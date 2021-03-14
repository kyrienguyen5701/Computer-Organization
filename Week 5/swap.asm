#   swap.asm	Kyrie Nguyen	15 February 2021
#   Elementary program to swap in-place two elements in an array.
#   Register use:
#	$t0: temporarry storage for the base address of the array
#       $t1, t2: temporary registers to store the address of elements at chosen indices
#	$t3, t4: temporary registers to store the value at chosen indices
#	$v0, $a0: hold parameters to syscall

        .data
arr:    .word 1, 2, 4, 8, 16, 32, 64, 128       # an eight-element arrray
idx1:   .word 5                 # swapping index 5
idx2:   .word 3                 # with index 3

        .text
        .align 2
        .globl main
main:
        la $t0, arr             # $t0 = &arr[0]
        lw $t1, idx1            # $t1 = idx1
        sll $t1, $t1, 2
        add $t1, $t1, $t0       # $t1 = idx1 + &arr[0]
        lw $t2, idx2            # $t2 = idx2
        sll $t2, $t2, 2
        add $t2, $t2, $t0       # $t2 = idx2 + &arr[0]
        lw $t3, 0($t1)          # $t3 = $t1 = &arr[idx1]
        lw $t4, 0($t2)          # $t4 = $t2 = &arr[idx2]
        sw $t4, 0($t1)          # arr[idx1] = $t4
        sw $t3, 0($t2)          # arr[idx2] = $t3
        jr $ra                  # return control to the simulator