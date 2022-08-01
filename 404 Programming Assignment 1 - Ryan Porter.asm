.data

#ascii 
prompt1:	.asciiz "Enter 0 to sort in descending order.\n"
prompt2:	.asciiz "Any number different than 0 will sort in ascending order.\n"
beforesort:	.asciiz "Before Sort:\n"
aftersort:	.asciiz "\n\nAfter Sort:\n"
newline:	.asciiz "\n"
space:		.asciiz " "
list: .word 7, 9 , 4, 3, 8, 1, 6, 2, 5


.text
.globl main

main:
	li $s0, 9 							# s0 = length
	
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 4
	la $a0, prompt2
	syscall

	li $v0, 5
	syscall 
	move $s1,$v0 						# s1 = direction
	
	li $v0, 4
	la $a0, beforesort
	syscall
	
	la $a1, list
	jal printData						# call printData function
	
	
	li $t0, 0							# t0 = k = 0
	addi $t1, $s0, -1					# t1 = length-1
	
	la $a1, list
	loop1:
		bge $t0, $t1, loop1Exit
		
		move $t2, $t0						# t2(min) = t0(k)
		
		addi $t3, $t0, 1					# t3(j) = t0(k) + 1	
		loop2:
			bge $t3, $s0, loop2Exit
			sll $t4, $t2, 2					# t4 = min multiplied by 4
			sll $t5, $t3, 2					# t5 = j multiplied by 4
			lw	$t4, list($t4)
			lw	$t5, list($t5)
			jal check
			beq $t6, $zero, skip
			move $t2, $t3
			skip:
			addi $t3, $t3, 1
			j loop2
		loop2Exit:
		
		beq $t2, $t0, next
		
		
		#sll $t3, $t2, 2					#t3 = min multiplied by 4
		#lw $t4, list($t3)				# t4 = list[min]
		
		#sll $t5, $t0, 2					# t5 = k multiplied by 4
		#lw $t6, list($t5)				# t6 = list[k]
		
		#sw $t6, list($3)				# list[min] = (old)list[k]
		#sw $t4, list($5)				# list[k] = (old)list[min]
		
		
		
		
		
		next:	
	addi $t0, $t0, 1
	j loop1
	loop1Exit:
	
	
	
	j exit


printData:
	bge $t0, $s0, exitPrintData			# if iterator >= size then exit
	
	lw	$t1, 0($a1)						
	
	addi $a1, $a1, 4					# increment array
	
	li $v0, 1						
	move $a0, $t1
	syscall
	
	li $v0, 4							# print space
	la $a0, space
	syscall
	
	addi $t0, $t0, 1					# increment loop by 1
	j printData
	
exitPrintData:
	jr $ra
	
check:
	bne $s1, $zero, else
	sgt $t6, $t5, $t4
	jr $ra
	else:
	slt $t6, $t5, $t4
	jr $ra
	
	
exit:
	li $v0, 10
	syscall
	




 