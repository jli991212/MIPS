.data	
	zip: .asciiz "Give me your zip code (0 to stop):"
	userinput: .space 5
	sum: .asciiz "The sum of all digits in your zip code is: \n\n"
	ite: .asciiz "ITERATIVE: "
	enter: .asciiz"\n"
	rec: .asciiz "RECURSIVE: "


.text

main:
	li $v0, 4
	la $a0, zip
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	move $t3, $v0
	beq $t0, $zero, wrong
	li $s0, 0
int_digits_sum: 
	blez $t0, display_sum
	div $t1,$t0,10
	mfhi $t2
	add $s0, $s0, $t2
	div $t0, $t0, 10
	j int_digits_sum
display_sum:
	li $v0, 4
	la $a0, sum
	syscall
	li $v0, 4
	la $a0, ite
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	
	jal rec_digits_sum
	move $t4, $v0
	#move $s2, $s1
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 4
	la $a0, rec
	syscall
	li $v0,1
	move $a0, $t4
	syscall	
	li $v0, 4
	la $a0, enter
	syscall
	j main
#	li $v0, 10
#	syscall
	#jr $ra

rec_digits_sum: 
	div $t3, $t3, 10
	mfhi $t2
	addi $sp,$sp,-8	 # allocate	space	on	stack
	sw $ra,	0($sp)	# store	the	return	address
	sw $a0,	4($sp)	# store	the	argument
	move $a0, $t2
	bgt $t3, 0, recursive
	add $v0, $zero, $zero
	addi $sp,$sp,8
	jr $ra
recursive:
	div $a0,$a0, 10
	jal rec_digits_sum
	lw $ra, 0($sp)
    	lw $a0,4($sp)
    	addi $sp,$sp,8
    	add $v0,$a0, $v0
    	jr $ra
		
wrong:
	li $v0, 10
	syscall
			
				
	
	
	
	
