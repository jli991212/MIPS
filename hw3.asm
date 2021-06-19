.data
	prompt:.asciiz " please enter a machie code: "
	userinput: .space 20
	emptystr: .asciiz "\n"
	toolong: .asciiz "your input was too long! only allow 8 characters. \n"
	tooshort: .asciiz "your input was too short! need 8 characters. \n"
	inval: .asciiz "your input contains invalid value\n"
	noop: .asciiz "the opcode was not recognized\n"
	lwop: .asciiz "the lw opcode is 35 in decimal\n"
	swop: .asciiz "the sw opcode is 43 in decimal\n"
	alop: .asciiz "the  opcode is 0 in decimal\n"
	
.text
main:
	
outloop:
	li $v0, 4
	la $a0, prompt # get prompt information
	syscall	
checkempty:	
	li $v0,8
	la $a0, userinput #get user input
	li $a1, 20
	syscall
	move $a2, $a0
	lb $t1, 0($a0) # load first byte of user input
	la $a0, emptystr 
	lb $t0, 0($a0) # load the empty str which is a newline character
	beq $t0, $t1,exit #comapre user input if is a null string exit
	li $t2, 0
   	j lengthloop # after check empty string go to check user input string's length	
lengthloop:
	lb   $a3,0($a2) # load first byte of user input
    	beqz $a3,length # if find the input already fully counted go to length 
	j checkvalid
 continueloop:
    	addi $t2,$t2,1 #the count +1
    	addi $a2,$a2,1 # move to next address
    	j     lengthloop
checkvalid:
	beq $a3, 'a', continueloop #check each character if is valid
	beq $a3, 'b', continueloop
	beq $a3, 'c', continueloop
	beq $a3, 'd', continueloop
	beq $a3, 'e', continueloop
	beq $a3, 'f', continueloop
	beq $a3, 'A', continueloop
	beq $a3, 'B', continueloop
	beq $a3, 'C', continueloop
	beq $a3, 'D', continueloop
	beq $a3, 'E', continueloop
	beq $a3, 'F', continueloop
	beq $a3, '0', continueloop
	beq $a3, '1', continueloop
	beq $a3, '2', continueloop
	beq $a3, '3', continueloop
	beq $a3, '4', continueloop
	beq $a3, '5', continueloop
	beq $a3, '6', continueloop
	beq $a3, '7', continueloop
	beq $a3, '8', continueloop
	beq $a3, '9', continueloop
	beq $a3, '\n', length
	j invalid
length:
	addi $t4, $zero, 8# set $t4=9
	add $a0, $zero, $t2 # comapre with userinput with $t4 if it is 8 character + a null terminator
	#slt $a2,$a0,$t4
	blt $a0, $t4,short # if less than $t4 go to short to print  too short error message
	bgt $a0, $t4, long # if greater than $t4 go to long to print  too long error message
	j opcode
opcode:
	lb $t0, -8($a2) #load first nibble of user input
	lb $t1, -7($a2) # load second nibble of user input
	beq $t0, '0',checkalop #check opcpde
	beq $t0, '8',checklwop
	beq $t0, 'A',checkswop
	beq $t0, 'a',checkswop
	j unop
	
checklwop:
	beq $t1, 'c',lwopcode
	beq $t1, 'd',lwopcode
	beq $t1, 'e',lwopcode
	beq $t1, 'f',lwopcode
	beq $t1, 'C',lwopcode
	beq $t1, 'D',lwopcode
	beq $t1, 'E',lwopcode
	beq $t1, 'F',lwopcode
	j unop
checkswop:
	beq $t1, 'c',swopcode
	beq $t1, 'd',swopcode
	beq $t1, 'e',swopcode
	beq $t1, 'f',swopcode
	beq $t1, 'C',swopcode
	beq $t1, 'D',swopcode
	beq $t1, 'E',swopcode
	beq $t1, 'F',swopcode
	j unop
checkalop:
	beq $t1, '0',alopcode
	beq $t1, '1',alopcode
	beq $t1, '2',alopcode
	beq $t1, '3',alopcode
	j unop
unop:
	li $v0, 4
	la $a0, noop # print noop message when find the opcode is unrecoginzed
	syscall
	j outloop
lwopcode:
	li $v0, 4
	la $a0, lwop # print lwop message when find the opcode is lw instruction
	syscall
	j outloop
swopcode:
	li $v0, 4
	la $a0, swop # print swop message when find the opcode is sw instruction
	syscall
	j outloop
	
alopcode:
	li $v0, 4
	la $a0, alop # print alop message when find the opcode is  some rithmetic and logical instruction
	syscall
	j outloop

invalid:
	li $v0, 4
	la $a0, inval # print invalid message when find user input contain invalid characters
	syscall
	j outloop
	
long:
	li $v0, 4
	la $a0, toolong # print too long message when find user input more than 8 character
	syscall
	j outloop
short:
	li $v0, 4
	la $a0, tooshort # print too short message when find user input less than 8 character
	syscall
	j outloop
exit: 
 	li $v0 10 # exit
	syscall

		
	

	
