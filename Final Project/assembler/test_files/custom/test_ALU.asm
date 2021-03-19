# Author: Kyrie Nguyen
# Description: this program should put the values 2..-3 into registers 1..6 and value 120 into register 7
# Note: the processor can handle 8-bit signed immediates
addi $1 $0 2
addi $2 $0 1
andi $3 $1 -3
ori  $4 $1 -3
sub $5 $3 $1
sub $6 $4 $1
addi $7 $7 120