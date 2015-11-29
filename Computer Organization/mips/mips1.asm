#my first program

		.data
strMsg: 	.asciiz	"Enter your string: "	
chrMsg: 	.asciiz "Enter a char: "


		.text
main:		la $a0, strMsg
		jal print
		
		la $a0, chrMsg
		jal readString
		jal print
		
		jal exit

print:		li $v0 4
		syscall
		jr $ra

readString:	li $v0 8
		li $a1 1000
		syscall

exit:		li $v0 10
		syscall 