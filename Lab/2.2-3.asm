.data

.text
main:
	li $v0, 5
	syscall
	move $t0, $v0
	li $t1, 100 #b
	li $t2, 2 #c
	
	beq $t0, 1, case1
	beq $t0, 2, case2
	beq $t0, 3, case3
	beq $t0, 4, case4
	li $a0,0
	j break
	
case1:	add $a0, $t1, $t2
	j break
	
case2:	sub $a0, $t1, $t2
	j break

case3:	mul $a0, $t1, $t2
	j break
	
case4:	div $a0, $t1, $t2
	j break
	
break:	li $v0,1
	syscall
	