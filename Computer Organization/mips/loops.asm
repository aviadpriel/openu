# print all numbers from 1 to 20
		.data
separator:	.asciiz ", "

		.text
main:				
		#loop: print all numbers from 1 to 20
		li $t0 1		 # i = 0
loop:		bgt $t0, 20, endLoop	 # while i <= 20
		move $a0, $t0
		jal printInt
		jal printSeparator
		addi $t0, $t0, 1 	 # i++
		b loop			 # repeat loop

		#finish
endLoop:	jal exit
		

#Helper functions:
printSeparator:	li $v0 4
		la $a0 separator
		syscall
		jr $ra

printInt:	li $v0 1
		syscall
		jr $ra

exit:		li $v0 10
		syscall 