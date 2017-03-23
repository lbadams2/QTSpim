.data 0x10000000 
var1: .word 0x0002
var2: .word 0x0002
var3: .word 0xfffff821

		.text
		.globl main
main:	addu $s0, $ra, $0# save $31 in $16
		lw $t0, var1  #load word stored in var1 to t0
		lw $t1, var2  #load word stored in var2 to t1
		bne $t0, $t1, Else
		lw $t2, var3
		sw $t2, var1
		sw $t2, var2
		beq $0, $0, Exit

Else:	sw $t1, var1  #store word stored in t1 to var1
		sw $t0, var2  #store word stored in t0 to var4

Exit:	addu $ra, $0, $s0 # return address back in $31
		jr $ra # return from main

