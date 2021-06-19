.data
	input: .asciiz "0134abcd"
	hexsign: .asciiz "0x"
	imme: .space 8
	fout: .asciiz "output.txt"
	buffer: .space 1024
	newline: .asciiz "\n"
	error1: .asciiz "error"
.text

	la $s7 , buffer
	la $a0, input
	move $t8, $a0
writestring1:
	lb $t9, ($t8)
	beqz $t9, back1
	sb $t9, ($s7)
	addi $s7, $s7 ,1
	addi, $t8, $t8 ,1
	j writestring1
back1:
	li $a0,0
	li $t9,0
	li $t8,0
	la $a0, hexsign
	move $t8, $a0
writestring2:
	lb $t9, ($t8)
	beqz $t9, back2
	sb $t9, ($s7)
	addi $s7, $s7 ,1
	addi, $t8, $t8 ,1
	j writestring2
back2:
	li   $v0, 13       # system call for open file
	la   $a0, fout     # output file name
	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
	li   $a2, 0        # mode is ignored
	syscall   
	beq $v0 ,-1, error         # open a file (file descriptor returned in $v0)
	move $s6, $v0      # save the file descriptor 
	li   $v0, 15       # system call for write to file
	move $a0, $s6      # file descriptor 
	la $a1, buffer      # address of buffer from which to write
	li   $a2, 20     # hardcoded buffer length
	syscall 
	li   $v0, 16       # system call for close file
	move $a0, $s6      # file descriptor to close
	syscall  

	li $v0, 10
	syscall

error:
	li $v0, 4
	la $a0 , error1
	syscall