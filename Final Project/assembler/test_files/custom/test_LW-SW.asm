# Author: Kyrie Nguyen
# NOTE: the processor can handle 8-bit signed immediates
# results: values 35..40 should be in memory locations 1..6
# 	       values 36, 38, 40 should be in registers 1, 3, 5 while
#          values 35, 37, 39 should be in registers 2, 4, 6

addi $1 $0 35
addi $2 $0 36
addi $3 $2 1
addi $4 $2 2
addi $5 $1 4
addi $6 $1 5
sw   $1 1($0)
sw   $2 2($0)
sw   $3 3($0)
sw   $4 4($0)
sw   $5 5($0)
sw   $6 6($0)
lw   $1 2($0) 
lw   $2 1($0)
lw   $3 4($0)  
lw   $4 3($0)
lw   $5 6($0) 
lw   $6 5($0)