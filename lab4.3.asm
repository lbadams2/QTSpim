.data 0x10000000
Ask_Input:	.asciiz "Please enter an integer: "
newline:	.asciiz "\n"

		 .text
		 .globl main
	
	main: addi $sp, $sp, -4 # must save $ra since I’ll have a call
		  sw $ra, 4($sp)
		  la $a0, Ask_Input # load address of Ask_Input into $a0
		  li $v0, 4 # opcode for print string
		  syscall
			
		  li $v0, 5 # opcode for read integer
		  syscall # wait for input
		  move $t0, $v0 # move input to $t0
			
		  la $a0, Ask_Input # load address of Ask_Input into $a0
		  li $v0, 4 # opcode for print string
		  syscall
			
		  li $v0, 5 # opcode for read integer
		  syscall # wait for input
		  move $t1, $v0 # move input to $t1
		  
		  move $a0, $t0 # pass first parameter
		  move $a1, $t1 # pass second parameter
		  jal largest # call largest with 2 parameters
		  nop # execute this after largest returns
		  
		  move $t0, $v0 # move return value to $t0
		  li $v0, 1 # 1 is print integer
		  add $a0, $t0, $0 # put larger int in register used by print integer
		  syscall
		  
		  lw $ra, 4($sp) # restore the return address in $ra
		  addi $sp, $sp, 4
		  jr $ra # return from main
	
		  
largest:  slt $t2, $a0, $a1 # if $a0 is less than $a1 set $t2 to 1 else set $t2 to 0
		  beq $t2, $0, Else
		  move $v0, $a1 # $a0 is greater or equal
		  j Endif
		Else: move $v0, $a0 # $a1 is greater
		Endif:  jr $ra # return from this procedure