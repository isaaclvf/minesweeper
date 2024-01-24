.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0
  li $t4, 0
  move $s1, $a1
  addi $s4, $s1, 1
  addi $s1, $s1, -1
begin_for_i_it:						# int i = row - 1; i <= row + 1; ++i
  li $t0,SIZE
  bgt $s1,$s4,end_for_i_it 
  
  move $s2, $a2
  addi $s5, $s1, 1
  addi $s2, $s2, -1
  begin_for_j_it:						# int j = colum - 1; i <= colum + 1; ++i
  li $t0,SIZE
  bgt $s2,$s5,end_for_j_it
  sll $t0, $s1, 5 # i*8
  sll $t1, $s2, 2 # j
  add $t0, $t0, $t1
  add $t0, $t0, $s0
  
  lw $t2, 0($t0)
  beq $t2, -1, verf1 # board[i][j]==-1
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
  
  iftrue:
  addi $t4, $t4, 1 # cont++
  
  endif:
  addi $s2,$s2,1						# j++
  j begin_for_j_it
  end_for_j_it:
  addi $s1, $s1, 1						# i++
  j begin_for_i_it
  end_for_i_it:
  
  move $v0, $t4  # return cont
  restore_context
  jr $ra
