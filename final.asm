 .data 0x10010000
var1: .word 0x8192a3b4
var2: .word 0
 .text 0x40000a
 .globl main
main: subu $sp, $sp, 4
 sw $ra, 0($sp)
 jal Mistery
 lw $ra, 0($sp)
 addu $sp, $sp, 4
 jr $ra
 .text 0x400100
Mistery:
 lui $t0, 4097
 lb $t1, 3($t0)
 sw $t1, 4($t0)
 jr $ra 