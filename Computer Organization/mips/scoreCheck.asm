# score checker
# s0 - the exam score

		.data
scorePrompt: 	.asciiz	"Enter Your exam score: "	
failMessage:	.asciiz "You failed the class..."
successMessage:	.asciiz "You passed the class!"
invalidMessage:	.asciiz "Invalid score input"

		.text
main:		
		#print 'enter your score' message
		la $a0, scorePrompt
		jal printStr
		
		#read score from the user
		jal readInt
		move $s0, $v0
		
		#if score is less then 0 or bigger then 100 print error message
		blt $s0, 0, invalidInput
		bgt $s0, 100, invalidInput
		
		#if score is less then 60 print failed message
		blt $s0, 60, failed
		
		#id score is 60 or bigger print success message
		bge $s0, 60, passed

failed:		la $a0, failMessage
		jal printStr
		b end
		
passed:		la $a0, successMessage
		jal printStr
		b end
		
invalidInput:	la $a0, invalidMessage
		jal printStr
		b end
	
		#finish
end:		jal exit
		

#Helper functions:

printStr:	li $v0 4
		syscall
		jr $ra

readInt:	li $v0 5
		syscall
		jr $ra

exit:		li $v0 10
		syscall 