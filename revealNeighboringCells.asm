.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  save_context
  move $s0, $a0
  move $s1, $a1
  move $s2, $a2
  
  addi $s4, $s1, 1
  addi $s1, $s1, -1
begin_for_i_it:						# int i = row - 1; i <= row + 1; ++i
  li $t0,SIZE
  bgt $s1,$s4,end_for_i_it 
  
  addi $s5, $s2, 1
  addi $s2, $s2, -1
  begin_for_j_it:						# int j = colum - 1; i <= colum + 1; ++i
  li $t0,SIZE
  bgt $s2,$s5,end_for_j_it
  
  sll $t0, $s1, 5 # i*8
  sll $t1, $s2, 2 # j
  add $t0, $t0, $t1
  add $t0, $t0, $s0
  
  lw $t2, 0($t0)
  beq $t2, -2, verf1 # board[i][j]==-2
  j endif
  
  verf1:
  bge $s2, 0, verf2 # j>=0
  j endif
  
  verf2:
  bge $s1, 0, verf3 # i>=0
  j endif
  
  verf3:
  blt $s2, SIZE, verf4 # j<SIZE
  j endif
  
  verf4:
  blt $s1, SIZE, iftrue # i<SIZE
  j endif
  
  iftrue:
  move $s6, $t0
  move $a1, $s1
  move $a2, $s2
  jal countAdjacentBombs
  sw $v0, 0($s6)
  
  bnez $v0, skip_recursion
  
  jal revealNeighboringCells
  
  skip_recursion:
  endif:
  addi $s2,$s2,1						# j++
  j begin_for_j_it
  end_for_j_it:
  addi $s1, $s1, 1						# i++
  j begin_for_i_it
  end_for_i_it:
  restore_context
  
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
