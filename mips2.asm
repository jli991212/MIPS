.data	
	zip: .asciiz "Give me your zip code (0 to stop):"
.text
	li $v0, 4
	la $a0, zip
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $s0, 0
int_digits_sum: 
	div $t1,$t0,10
	mfhi $t2
	add $s0, $s0, $t2
	div $t0, $t0, 10
	li $v0, 1
	move $a0, $s0
	syscall