# Maman date check.
# This method uses a special function atoi which parses string and returns integer.
# I use the fact that atoi function stops and returns when it founds a non digit character.
#
# registers being used:
# $s0 - input day
# $s1 - input month
# $s2 - input year

# $s5 - due day
# $s6 - due month
# $s7 - due year

# $a0, $a1 - function arguments
# $v0 - return value from function


		.data
dueDate:	.asciiz "16.11.2015"
dueDateMsg: 	.asciiz	"Maman due date is "	
promptDay:	.asciiz "\nEnter maman day (1-31): "
promptMonth:	.asciiz "Enter maman month (1-12): "
promptYear:	.asciiz "Enter maman year (0-4999): "
errorMsg:	.asciiz "error!\n"
okMsg:		.asciiz "o.k.\n"
tooLateMsg:	.asciiz "too late!\n"
anotherDateMsg: .asciiz "Another date? "
buffer:		.space 8

		.text
main:		
		# convert due date to integer and store it's parts to $s5, $s6, $s7
		# parse and store day into $s5 (atoi will stop converting on the first '.' char)
		la $a0, dueDate
		jal atoi
		move $s5, $v0
		
		# parse and store month into $s6 (atoi will stop converting on the second '.' char)
		la $a0, dueDate
		addi $a0,$a0, 3
		jal atoi
		move $s6, $v0
		
		# parse and store year7 into $s7 (atoi will stop converting when string ends)
		la $a0, dueDate
		addi $a0,$a0, 6
		jal atoi
		move $s7, $v0
		
		# print due date
		la $a0, dueDateMsg
		jal printString
		la $a0, dueDate
		jal printString

beginInput:	# prompt user for day input
		la $a0, promptDay
		jal printString
		# read user day input
		la $a0, buffer
		li $a1, 8
		jal readString
		#save day input as integer
		la $a0, buffer
		jal atoi
		move $s0, $v0
		
		#prompt user for month input
		la $a0, promptMonth
		jal printString
		#read user month input
		la $a0, buffer
		li $a1, 8
		jal readString
		#save month input as integer
		la $a0, buffer
		jal atoi
		move $s1, $v0
		
		#prompt user for year input
		la $a0, promptYear
		jal printString
		#read user year input
		la $a0, buffer
		li $a1, 8
		jal readString
		#save year input as integer
		la $a0, buffer
		jal atoi
		move $s2, $v0
		
		#check if the date is valid
		move $a0, $s0
		move $a1, $s1
		move $a2, $s2
		
		jal checkDate
		beq $v0, 1, validDate
		la $a0, errorMsg
		jal printString
		b anotherDate
		
validDate:
		# now the date is valid, check if the maman due date is already passed
		
		bgt $s2, $s7, tooLate	# late by years
		blt $s2, $s7, ok	# early by years
		
		# equal years, check month:
		bgt $s1, $s6, tooLate	# late by months
		blt $s1, $s6, ok	# early by months
		
		# equal years and months, check day:
		bgt $s0, $s5, tooLate	# late by days
		blt $s0, $s0, ok	# early by days
		
		# equal dates. also ok!
		b ok
		
tooLate:	
		la $a0, tooLateMsg
		jal printString
		b anotherDate
		
ok:	
		la $a0, okMsg
		jal printString
		b anotherDate	
		
anotherDate:	
		# print Another date?
		la $a0, anotherDateMsg
		jal printString
		
		# get input from the user:
		la $a0, buffer
		li $a1, 8
		jal readString
		
		# check if 'no'
		la $t0, buffer	
		lb $t1, 0($t0)	# first char
		lb $t2, 1($t0)  # second char
		lb $t3, 2($t0)  # third char
		
		# finish program if the first 2 chars are 'n' & 'o' and the third char is either null or new line
		bne $t1, 'n', beginInput
		bne $t2, 'o', beginInput
		beq $t3, '\0', finish
		beq $t3, '\n', finish
		
		# else ask for a new date
		b beginInput
		
		#exit
finish:		jal exit
		
		

# convert ascii to integer (non-negative integers only. Result is stored in $v0
# conversion process stops until the first non-digit character or NULL
# if the string contains not only digits, the function will convert only the first sequance of digits.
#
# $a0 - address of the string
# $t0 - the current char to process.
# $v0 - the integer value of the given string.

atoi:		li $v0, 0
atoi_loop:	lb $t0, ($a0)			# char $t0 = *($a0)
		beqz $t0, atoi_end		# while $t0 != '/0'
		
		sub $t0, $t0, '0'		#try to convert it to digit
		
		# return if the char is not a digit
		blt $t0, 0, atoi_end
		bgt $t0, 9, atoi_end
		
		#add the digit to the end of the result integer
		mul $v0, $v0, 10
		add $v0, $v0, $t0
		
		#next char: *($a0)++
	 	addi $a0, $a0, 1		
		b atoi_loop
	
atoi_end:	jr $ra



# checkDate procedure gets a date and checks if its a valid date
# store in $v0 1 if the date is valid. 0 if the date is invalid
# $a0 - day
# $a1 - month
# $a2 - year
checkDate:	
		# check day (between 1 to 31)
		blt $a0, 1, checkDate_err
		bgt $a0, 31, checkDate_err
		
		# check month (between 1 to 12)
		blt $a1, 1, checkDate_err
		bgt $a1, 12, checkDate_err
		
		#check year (less than 5000)
		bgt $a2, 4999, checkDate_err
		
		#all checkas are passed. the date is valid!
		li $v0, 1
		b checkDate_end
		
checkDate_err:	li $v0, 0

checkDate_end:	jr $ra


# helper system functions:
printString:	li $v0 4
		syscall
		jr $ra

readString:	li $v0 8
		syscall
		jr $ra
		
exit:		li $v0 10
		syscall 
		
		beq $s1, $t3, exit
