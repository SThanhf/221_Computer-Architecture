.data
	str1: .word 1,2,3,4,5,6,7,8,9,10
	str2: .word 12,	-23,	34,	-43	,56	,-65	,78	,-87,	90	,-109
	str3: .word 1234,	2345,	231,	-4567,	5678,	-423,	789	,-89,	9	,-10
	form: .asciiz "\nResult: "
	enter : .asciiz"\n"
	mssv: .asciiz"2112302 - Nguyen Sinh Thanh"
.text
main: 
#case 1
	li $v0, 4
	la $a0, form
	syscall

	la $t1, str1
	lw $t2, 16($t1)
	lw $t3, 24($t1)
	sub $a0,$t2,$t3
	
	li $v0,1
	syscall
#case 2
li $v0, 4
	la $a0, form
	syscall

	la $t1, str2
	lw $t2, 16($t1)
	lw $t3, 24($t1)
	sub $a0,$t2,$t3
	
	li $v0,1
	syscall
#case 3
li $v0, 4
	la $a0, form
	syscall

	la $t1, str3
	lw $t2, 16($t1)
	lw $t3, 24($t1)
	sub $a0,$t2,$t3
	
	li $v0,1
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall
#mssv
	la $t1, mssv
	lb $t2, 0($t1)
	lb $t3, 26($t1)
	sb $t3, 0($t1)
	sb $t2, 26($t1)
	
	li $v0, 4
	la $a0, mssv
	syscall