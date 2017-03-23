.data 0x10000000
Ask_Input:	.asciiz "Please enter a non negative integer: "
negative:	.asciiz "Input cannot be negative\n"
result:		.asciiz "Result of factorial is: "

		 .text
		 .globl main
	
main: 	  addi $sp, $sp, -4 # must save $ra since I’ll have a call
		  sw $ra, 4($sp) 
		  
Prompt:	  la $a0, Ask_Input # load address of Ask_Input into $a0
		  li $v0, 4 # opcode for print string
		  syscall
			
		  li $v0, 5 # opcode for read integer
		  syscall # wait for input
		  move $t0, $v0 # move input to $t0
		  
		  slt $t1, $t0, $0
		  beq $t1, $0, Else
		  la $a0, negative # load address of negative
		  li $v0, 4 # opcode for print string
		  syscall
		  j Prompt
		  
Else: 	  move $a0, $t0 # pass parameter
		  jal Factorial	# greater than 0
		  nop # execute this after factorial returns
		  move $t0, $v0 # move return value to $t0
		  
		  la $a0, result # load address of negative
		  li $v0, 4 # opcode for print string
		  syscall
		  
		  li $v0, 1 # 1 is print integer
		  add $a0, $t0, $0 # put result of factorial in $a0
		  syscall

		  lw $ra, 4($sp) # restore the return address in $ra
		  addi $sp, $sp, 4
		  jr $ra # return from main
		  
Factorial:
			subu $sp, $sp, 4
			sw $ra, 4($sp) # save the return address on stack
			beqz $a0, terminate # test for termination
			subu $sp, $sp, 4 # do not terminate yet, create room for parameter on stack
			sw $a0, 4($sp) # save the parameter
			sub $a0, $a0, 1 # will call with a smaller argument
			jal Factorial
			# after the termination condition is reached these lines
			# will be executed
			lw $t0, 4($sp) # the argument I have saved on stack
			mul $v0, $v0, $t0 # do the multiplication
			lw $ra, 8($sp) # prepare to return
			addu $sp, $sp, 8 # I’ve popped 2 words (an address and
			jr $ra # .. an argument)
terminate:
			li $v0, 1 # 0! = 1 is the return value
			lw $ra, 4($sp) # get the return address
			addu $sp, $sp, 4 # adjust the stack pointer
			jr $ra # return