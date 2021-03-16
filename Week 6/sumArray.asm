#   sumArray.asm	   Chris Fernandes
#   sums numbers in array A
#   Register use:
#	$s0: base addr of A
#	$t1: next array elmt to add
#	$t2: loop index
#	$t4: accumulates sum
#	$t5: number of items in array
#	$t6: offset into array
#	sum: memory location for $t1

		.data                	# FYI: start of data section
A:		.word -2, -1, -3, 20, 1 
endA:     
sum:		.space    4          	# $t4 written to memory here

        .text                   	# FYI: start of code section
        .align 2                	# FYI: align to start code on a word boundary
        .globl main             	# FYI: make 'main' visible to the simulator
main:                           	# main() {
	la $s0, A				# $s0 = &A[0]
	la $t5, endA			# $t5 = &endA
	sub $t5 $t5 $s0
	sra $t5 $t5 2
	add $t4, $0, $0			# $t4 = sum
	add $t2, $0, $0			# $t2 = index
loop:
	bge  $t2, $t5, endloop
	sll  $t6, $t2, 2			# $t6 = 4*y
	add  $t6, $t6, $s0		# $t6 = &A[y]
	lw   $t1, 0($t6)
	add  $t4, $t4, $t1
	addi $t2, $t2, 1
	j loop
endloop:
	sw   $t4, sum			# sum = $t4
	jr   $ra                	# return control to simulator
	                        	# }