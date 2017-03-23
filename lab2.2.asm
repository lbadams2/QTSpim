.data 0x10010000 
var1: .word 0x0000
var2: .word 0x0001
var3: .word 0xabcd
var4: .word 0x10000001
first: .byte 'l'   # use a letter from your own name
last: .byte 'a'   # use a letter from your own name

		.text
		.globl main
main:	addu $s0, $ra, $0# save $31 in $16

		#la $t0, var2  load address of var2 into t0
		#lw $t1, var2  load value of var2 into t1 
		#sw $t2, var1
		li $v0, 1 # system call for print_int
		la $a0, var1
		syscall
		
# restore now the return address in $ra and return from main
		addu $ra, $0, $s0 # return address back in $31
		jr $ra # return from main
		