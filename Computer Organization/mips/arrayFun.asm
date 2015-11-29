# Loop through all array, print it and then sum it

		.data
list:		.word 2,3,5,7,11,13,17,19,23,29
newLine:	.asciiz "\n"
separator:	.asciiz ", "
sumString:	.asciiz "\nSum of the array = "

		.text
main:		
		#load list address in $s0
		la $s0, list
		
		#load first value of the list to $a0 and print it
		lw $a0, 0($s0)
		jal printInt
		jal printNewLine
		
		#load second value of the list to $a0 and print it
		lw $a0, 4($s0)
		jal printInt
		jal printNewLine
		
		#print all values of the array
		li $t0, 0	 	# i = 0
loop:		bge $t0, 10, endLoop	# while i<10
		mul $t7, $t0, 4		# $t7 = i * 4
		lw $a0, list($t7)	# $a0 = list[$t7]
		jal printInt
		jal printSeparator
		addi $t0, $t0, 1 	# i++
		b loop
endLoop:

		#sum all values of the array
		li $t0, 0		# i = 0
		li $s0, 0		# sum = 0
sumLoop:	bge $t0, 10, printSum	# while i<10
		mul $t7, $t0, 4		# $t7 = i * 4
		lw $t1, list($t7)	# $t1 = list[$t7]
		add $s0, $s0, $t1	# $s0 += $t1
		addi $t0, $t0, 1 	# i++
		b sumLoop
		
printSum:
		#print sum
		la $a0, sumString
		jal printStr
		move $a0, $s0
		jal printInt

		#finish
end:		jal exit
		

#Helper functions:
printNewLine:	li $v0 4
		la $a0 newLine
		syscall
		jr $ra
		
printSeparator:	li $v0 4
		la $a0 separator
		syscall
		jr $ra
		
printInt:	li $v0 1
		syscall
		jr $ra
		
printStr:	li $v0 4
		syscall
		jr $ra

exit:		li $v0 10
		syscall 