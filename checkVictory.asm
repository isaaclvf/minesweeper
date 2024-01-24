.include "macros.asm"
.globl checkVictory

.eqv MAX_EMPTY_CELLS 54 # SIZE * SIZE - BOMB_COUNT

checkVictory:
	save_context
	move $s0, $a0						# $s0 contains the board
	
  li $s3, 0 							# count = 0
  li $s1,0 # i = 0
  begin_for_i_it:						# for (int i = 0; i < SIZE; ++i) {
  li $t0,SIZE
  bge $s1,$t0,end_for_i_it 
  
  li $s2,0 # j = 0
  begin_for_j_it:						# for (int j = 0; j < SIZE; ++j) {
  li $t0,SIZE
  bge $s2,$t0,end_for_j_it
  sll $t0, $s1, 5 # i*8
  sll $t1, $s2, 2 # j
  add $t0, $t0, $t1
  add $t0, $t0, $s0
  
  bltz $t1, skip_count
  addi $s3, $s3, 1						# if (board[i][j] >= 0) count++;
  
  skip_count:
  addi $s2,$s2,1						# j++
  j begin_for_j_it
  end_for_j_it:
  addi $s1, $s1, 1						# i++
  j begin_for_i_it
  end_for_i_it:
  
  li $v0, 0
  blt $s3, MAX_EMPTY_CELLS, finish				# if (count < SIZE * SIZE - BOMB_COUNT) return 0;
  li $v1, 1							# All valid cells have been revealed
  
  finish:
  restore_context
  jr $ra 
