#sum 2 numbers
# t0 - first number
# t1 - second number
# t2 = sum of the numbers

		.data
strMsg1: 	.asciiz	"Enter first number: "	
strMsg2: 	.asciiz "Enter second number: "
strMsg3:	.asciiz "The Sum is "


		.text
main:		
		#print first message
		la $a0, strMsg1
		jal printStr
		
		#read first number
		jal readInt
		move $t0, $v0
		
		#print second message
		la $a0, strMsg2
		jal printStr
		
		#read second number
		jal readInt
		move $t1, $v0
		
		#calculate sum
		add $t2, $t0, $t1
		
		#print sum message
		la $a0, strMsg3
		jal printStr
		
		#print sum
		move $a0, $t2
		jal printInt
		
		
		#exit
		jal exit
		

#Helper functions:
printStr:	li $v0 4
		syscall
		jr $ra
		
printInt:	li $v0 1
		syscall
		jr $ra

readInt:	li $v0 5
		syscall
		jr $ra

exit:		li $v0 10
		syscall 