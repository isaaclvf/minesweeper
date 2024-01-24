.include "macros.asm"

.globl play

play:
	save_context
	move $s0, $a0	# board
	move $s1, $a1	# row
	move $s2, $a2	# column
  sll $t0, $s1, 5 # i*8
  sll $t1, $s2, 2 # j
  add $t0, $t0, $t1
  add $t0, $t0, $s0
  
  lw $t3, 0($t0)
  beq $t3, -1, verf1
  beq $t3, -2, verf2
  
  j return_1
  
verf1:
  li $v0, 0		# return 0
  j finish
  
verf2:
  move $s4, $t0
  jal countAdjacentBombs	# int x = countAdjacentBombs(board, row, column);
  sw $v0, 0($s4)		# board[row][column] = x;
  beqz $v0, return_1
  jal revealNeighboringCells
  
 
return_1:
  li $v0, 1			# return 1
finish:
  restore_context
  jr $ra
