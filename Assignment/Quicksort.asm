.data 
	arr: .space 200
	endl: .asciiz "\n"
	after_sort: .asciiz "AFTER USING QUICKSORT\n"
	space: .asciiz " "
.text
main:
	addi $sp, $sp, -32
	
	# Input 50 elements
	la $s0, arr		#iterator begin
	addi $s1, $s0, 200	#iterator end
	j CM_1
	LM_1:
		addi $v0, $0, 5
		syscall
		sw $v0, 0($s0)
		addiu $s0, $s0, 4
	CM_1:
		slt $t0, $s0, $s1
		bne $t0, $0, LM_1
	#Sort
	la $a0, arr
	addu $a1, $0, $0
	addiu $a2, $0, 49
	jal quicksort
	
	addiu $v0, $0, 4
	la $a0, after_sort
	syscall
	
	# Output 50 elements
	la $a0, arr		#iterator begin
	addiu $a1, $a0, 200	#iterator end
	jal print_arr
	addi $sp, $sp, 32
	
	j Endprogram
		
quicksort:
	
	addiu $sp, $sp, -28
	sw $a2, 36($sp)
	sw $a1, 32($sp)
	sw $a0, 28($sp)
	sw $ra, 24($sp)
	
	#if (left >= right) return;
	lw $v0, 32($sp)		#left
	lw $v1, 36($sp)		#right
	slt $t0, $v0, $v1	#left < right
	beq $t0, $0, end_func
	
	#find pivot
	lw $v0, 32($sp)		#left
	sll $v0, $v0, 2
	lw $v1, 28($sp)		#arr
	addu $t0, $v1, $v0
	
	lw $v0, 0($t0)
	sw $v0, 12($sp)
	
	
	lw $v0, 32($sp)		#int i = left
	sw $v0, 16($sp)
	
	lw $v1, 36($sp)		#int j = right
	sw $v1, 20($sp)
	
	j CF_1
		
	LF_1:
		j CF_2
		LF_2:
			lw $v0, 16($sp) 		#load i
			addiu $v0, $v0, 1	# i++
			sw $v0, 16($sp)
		CF_2:
			lw $v0, 16($sp) 	#load i
			lw $s0, 28($sp)		#load arr
			lw $v1, 12($sp)		#load pivot
			sll $v0, $v0, 2		# i * 4
			addu $v0, $s0, $v0	#arr[i] address
			lw $v0, 0($v0)		#arr[i]
			slt $t0, $v0, $v1	# arr[i] < pivot 
			bne $t0, $0, LF_2		
		
		
		j CF_3
		LF_3:
			lw $v0, 20($sp)		#load j
			addiu $v0, $v0, -1	#j--
			sw $v0, 20($sp)
		CF_3:
			lw $v0, 20($sp)		#load j
			lw $s0, 28($sp)		#load arr
			lw $v1, 12($sp)		#load pivot
			sll $v0, $v0, 2		# j * 4
			addu $v0, $s0, $v0	#arr[j]'s address
			lw $v0, 0($v0)		# arr[j]
			slt $t0, $v1, $v0	# pivot < arr[j]
			bne $t0, $0, LF_3	
		
		lw $v0, 16($sp)		#load i
		lw $v1, 20($sp)		#load j
		slt $t0, $v1, $v0	# j < i
		bne $t0, $0, CF_1
		
		lw $s0, 28($sp)		#load arr
		sll $t0, $v0, 2		# t0 = i * 4
		addu $t0, $t0, $s0	# arr[i]
		
		sll $t1, $v1, 2		#t1 = j * 4
		addu $t1, $t1, $s0	# arr[j]
		
		lw $v0, 0($t0)		#swap
		lw $v1,	0($t1)
		sw $v1, 0($t0)
		sw $v0, 0($t1)
		
		lw $v0, 16($sp)		#load i
		addiu $v0, $v0, 1	#i++
		sw $v0, 16($sp)
		
		lw $v0, 20($sp)		#load j
		addiu $v0, $v0, -1	#j--
		sw $v0, 20($sp) 
	
	CF_1:
		lw $v0, 16($sp) 	#load i
		lw $v1, 20($sp)		#load j
		slt $t0, $v1, $v0	# j < i
		beq $t0, $0, LF_1
	
	
	#call print_arr
	lw $a0, 28($sp)			#load arr
	addiu $a1, $a0, 200
	jal print_arr
	
	#call func quicksort(arr, left, j)
	lw $a0, 28($sp)			#load arr
	lw $a1, 32($sp)			#left
	lw $a2, 20($sp)			#load j
	jal quicksort
	
	#call func quicsort(arr, i, right)
	lw $a0, 28($sp)			#load arr
	lw $a1, 16($sp)			#load i
	lw $a2, 36($sp)			#right
	jal quicksort
	
	end_func:
	lw $ra, 24($sp)
	addiu $sp, $sp, 28
	jr $ra
	
	
	
print_arr:
	addu $s0, $a0, $0
	addu $s1, $a1, $0
	j CM_2
	LM_2:
		addi $v0, $0, 1		
		lw $a0,($s0)
		syscall
		
		#print space
		addiu $v0, $0, 4
		la $a0, space
		syscall
		
		addiu $s0, $s0, 4
	CM_2:
		slt $t0, $s0, $s1
		bne $t0, $0, LM_2
	
	#print endl		
	addiu $v0, $0, 4
	la $a0, endl
	syscall
	
	jr $ra	
Endprogram:
