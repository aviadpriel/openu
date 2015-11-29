# read a string from the user
# read a char from the user
# print the number chars in the given string
#
# registers being used:
# $s0 - ascii value of the char to count
# $s1 - the sum or the characters
# $t0 - loop index
# $t1 - current character in the loop
# $a0, $a1 - function arguments
# $v0 - return value from function
		.data
buffer: 	.space 1000
promptString: 	.asciiz	"Enter a string (Up to 1000 characters long)\n"	
promptChar: 	.asciiz "Enter a character to count: "
promptSum:	.asciiz "\nNumber of characters found: "



		.text
main:		#prompt the user to enter a string
		la $a0, promptString
		jal printString
		
		#read string from the user and store it's address into $s0
		la $a0, buffer
		li $a1, 1000
		jal readString
		
		#prompt the user to enter a char
		la $a0, promptChar
		jal printString
		
		#read a char from the user and store it's value into $s0
		jal readChar
		move $s0, $v0
		
		#loop through all string and count the number of characters
		li $s1, 0			# sum = 0
		li $t0, 0			# i = 0
loop:		lb $t1, buffer($t0)		# c = buffer[i]
		beqz $t1, endLoop		# while(c != '/0') 
		bne $t1, $s0, continue		# if found mached character 
		addi $s1, $s1, 1		# sum++
continue:	addi $t0, $t0, 1		# i++
		b loop			
		
endLoop:
		#print sum
		la $a0, promptSum
		jal printString
		move $a0, $s1
		jal printInt
		
		#exit
		jal exit
		

#Helper functions:
printString:	li $v0 4
		syscall
		jr $ra
		
printInt:	li $v0 1
		syscall
		jr $ra

readString:	li $v0 8
		syscall
		jr $ra

readChar:	li $v0 12
		syscall
		jr $ra
		
exit:		li $v0 10
		syscall 
