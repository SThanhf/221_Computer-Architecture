.data

.text
main:
	li $v0,5
	syscall 
	move $t0, $v0 #a
	
	li $v0,5
	syscall 
	move $t1, $v0 #b
	
	li $v0,5
	syscall 
	move $t2, $v0 #c
	
	blt $t0, -3, true
	bge $t0, 7, true
	
	mul $t0, $t1, $t2
	j end
	
true:	add $t0, $t1, $t2
	j end
	
end:	move $a0, $t0
	li $v0, 1
	syscall