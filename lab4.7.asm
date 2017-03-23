.data 0x10000000
Ask_Input:	.asciiz "Please enter a non negative integer: "
negative:	.asciiz "Input cannot be negative\n"
result:		.asciiz "Result of ackermann is: "

		 .text
		 .globl main
	
main: 	  addi $sp, $sp, -4 # must save $ra since I’ll have a call
		  sw $ra, 4($sp) 
		  
Prompt1:  la $a0, Ask_Input # load address of Ask_Input into $a0
		  li $v0, 4 # opcode for print string
		  syscall
			
		  li $v0, 5 # opcode for read integer
		  syscall # wait for input
		  move $t0, $v0 # move input to $t0
		  
		  slt $t1, $t0, $0
		  beq $t1, $0, Prompt2 # $t0 is not negative if $t1 set to 0
		  
		  la $a0, negative # load address of negative
		  li $v0, 4 # opcode for print string
		  syscall
		  j Prompt1
		  
Prompt2:  la $a0, Ask_Input # load address of Ask_Input into $a0
		  li $v0, 4 # opcode for print string
		  syscall
			
		  li $v0, 5 # opcode for read integer
		  syscall # wait for input
		  move $t2, $v0 # move input to $t0
		  
		  slt $t1, $t2, $0
		  beq $t1, $0, Else
		  
		  la $a0, negative # load address of negative
		  li $v0, 4 # opcode for print string
		  syscall
		  j Prompt2
		  
Else:	  move $a0, $t0 # pass parameter
		  move $a1, $t2 # pass parameter
		  jal Ackermann	# greater than 0
		  nop # execute this after ackermann returns
		  move $t0, $v0 # move return value to $t0
		  
		  la $a0, result # load address of ackermann
		  li $v0, 4 # opcode for print string
		  syscall
		  
		  li $v0, 1 # 1 is print integer
		  add $a0, $t0, $0 # put result of ackermann in $a0
		  syscall

		  lw $ra, 4($sp) # restore the return address in $ra
		  addi $sp, $sp, 4
		  jr $ra # return from main
		  
Ackermann:
		  subu $sp, $sp, 12 # create space on stack for ra and args
		  sw $ra, 4($sp) # save the return address on stack
		  sw $a0, 8($sp) # save x on the stack
		  sw $a1, 12($sp) # save y on the stack
		  beqz $a0, terminate # test for termination
		  beqz $a1, single # test for single recursion
		  j double # else double recursion
		  
single:	  subu $a0, $a0, 1 # call with smaller x
		  li $a1, 1 # call with y as 1
		  jal Ackermann
		  lw $ra, 4($sp) # get the return address
		  addu $sp, $sp, 12 # adjust the stack pointer, don't care about args
		  jr $ra # return		  
			
double:	  subu $a1, $a1, 1	 #  call with smaller y 
		  jal Ackermann		# calculate second argument first		  
		  
		  lw $a0, 8($sp) # get x from stack
		  subu $a0, $a0, 1 # call with smaller x
		  addi $a1, $v0, 0 # y is return value
		  jal Ackermann
		  lw $ra, 4($sp) # get the return address
		  addu $sp, $sp, 12 # adjust the stack pointer, don't care about args
		  jr $ra # return		  
		  
terminate:
			lw $t0, 12($sp) # y 3rd thing pushed to stack
			addi $v0, $t0, 1 # y + 1 is return value
			lw $ra, 4($sp) # get the return address
			addu $sp, $sp, 12 # adjust the stack pointer, don't care about x
			jr $ra # return		  