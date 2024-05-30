.data
	out: asciiz "invalid input"
.text
main:
	li $v0,5
	syscall
	
	move $a0, $v0
	bltz $a0, wr
	
	li $s0, 0	#n-2
	li $s1, 1	#n-1
	li $s2, 1	#n
	li $t0, 2 	#i
	
LOOP:	beq $a0, 0, basic0
	beq $a0, 1, basic1
	beq $t0, $a0,true
	add $s2, $s0, $s1
	add $s0, $s1, $0
	add $s1, $s2, $0
	addi $t0,$t0,1
	j LOOP
basic0:	li $v0, 0
	j exit
	
basic1:	li $v0,1
	syscall	
	j exit
	
true: 	add $s2, $s0, $s1
	move $a0, $s2
	li $v0,1
	syscall
	
exit:	li $v0,10
	syscall
	
wr:	la $a0, out
	li $v0, 4
	syscall