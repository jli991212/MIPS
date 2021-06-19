.data 
 	intx: .asciiz "Enter a 32-bit integer X: "
 	inty: .asciiz "\n Enter another 32-bit integer Y:"
 	result: .asciiz "\n The difference between X and Y is:"
 	X: .space 4 # give the label 4 byte space
 	Y: .space 4 # give the label 4 byte space
 	D: .space 4 # give the label 4 byte space
.text   
main:

	# prompt user enter an integer X 
	li $v0, 4 # tell computer would print a string
	la $a0, intx # load 32-bit X address into $a0
	syscall
	
	#get the integer X
	li $v0, 5 # tell system read an integer
	syscall
	move $t0, $v0# store the number the vaule of X in $t0
	sb $t0, X # store the integer to label X's address
	# prompt user enter an integer Y
	li $v0, 4 # tell computer would print a string
	la $a0, inty# load 32-bit Y address into $a0 
	syscall
	
	#get the integer Y

	li $v0, 5 # tell system read an integer
	syscall
	move $t1, $v0 # store the number the vaule of X in $t1
	sb $t1, Y # store the integer to label Y's address
	sub $t2,$t0, $t1  # do the subtract function and store the result to $t2
	
	#dsiplay the result
	li $v0, 4 # tell computer would print a string
	la $a0, result
	syscall
	li $v0, 1 #tell system would print an integer
	move $a0, $t2 # store the result to $a0 which related label D to make it can be printed
	sb $t2, D # store the integer to label D's address
	syscall
