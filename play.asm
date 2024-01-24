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
  
  beq $t0, -1, verf1
  beq $t0, -2, verf2
  
verf1:
  li $v0, 0		# return 0
  j finish
  
verf2:
  jal countAdjacentBombs	# int x = countAdjacentBombs(board, row, column);
  or $t0, $zero, $v0		# board[row][column] = x;
  
  # TODO: revealNeighboringCells
  
  li $v0, 1			# return 1
finish:
  restore_context
  jr $ra