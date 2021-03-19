# assuming all registers are 0
# the loop should run five times
# and registers 3 and 4 should all contain 15
# anything else, and the branching fails

addi $1 $0 3
addi $2 $0 5
move $3 $1
move $4 $2
beq $3 $4 7   #should only be taken on fifth loop
bge $3 $4 2   
add $3 $3 $1
ble $3 $4 1
add $4 $4 $2
beq $3 $3 -8  #should always be taken, branch back to first beq
