.data
	TC: .asciiz "Computer Science and Engineering, HCMUT\n"
	FC: .asciiz "Computer Architecture 2022\n"
	
.text	
main:
	li $v0, 5
	syscall
	
	move $t0, $v0
	bltz $t0, nega
nega:	mul $t0, $t0, -1
	j module
module:	div $t1, $t0, 2
	mul $t1, $t1, 2
	sub $t2, $t0, $t1
	beq $t2, 1, true
	
	la $a0, FC
	li $v0, 4
	syscall
	j end

true:	la $a0, TC
	li $v0, 4
	syscall 
	j end
	
end:	li $v0, 10
	syscall
	

	
