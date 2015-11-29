# Reverse register value:
# Ask from the user to enter a decimal number
# print the number in binary
# reverse the bits of the number
# print the new reversed number in binary.
#
# registers being used:
# $s0 - the original number
# $s1 - the reversed number result
# $t0 - the modulo result of the division
# $t2 - the base to convert to (=2)
# $a0, $a1 - function arguments
# $v0 - return value from function

		.data
promptString: 	.asciiz	"Enter a number: "	
newLine:	.asciiz "\n"



		.text
main:		
		#print prompt to the user
		la $a0, promptString
		jal printString
		
		#read integer from the user and store it in $s0
		jal readInt
		move $s0, $v0
		
		#print the integer in binary
		move $a0, $s0
		jal printBinary
		
		#reverse register $s0, store the result in $s1
		li $s1, 0
		li $t1, 0
		li $t2, 2
		
reverseLoop:	bge $t1,32 endReverseLoop	# while ($t1 < 32)
		divu $s0,$t2			# perform division
		mflo $s0			# $s0 = $s0 / 2
		mfhi $t0			# $t0 = $s0 % 2
		sll $s1, $s1, 1			# $s1 = $s1 << 1
		or  $s1, $s1, $t0		# $s1 = $s1 | $t0
		addi $t1, $t1, 1		# $t1++
		j reverseLoop
		
endReverseLoop: 
		
		# print reverse register
		la $a0, newLine
		jal printString
		
		move $a0, $s1
		jal printBinary
		
		#exit
		jal exit
		

#print binary procedure: It prints the binary number from right to left
# $t0 - Starts with the actual number. Gets divided by 2 every iteration
# $t1 - bit counter from o to 32
# $t2 - constant 2. The base number
printBinary:	
		# save return address in stack
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		#process loop
		li $t1, 0			# i = 0
		li $t2, 2			# base = 2
		move $t0, $a0
digitLoop:	bge $t1,32, endDigitLoop	# while (num != 0)
		divu $t0, $t2
		mflo $t0			# num = num /2
		mfhi $a0
		jal printInt
		addi $t1, $t1, 1		# i++
		b digitLoop
		
		# recover return address from stack and return
endDigitLoop:	lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

		

#Helper functions:
printString:	li $v0 4
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
