.text 0x4000fc 
		 .globl main
	
main: 	  lui $t0, 1023 

 ori $t0, $t0, 2048 

 andi $t1, $t0, 125

 sw $t0, 121($t1) 

 slti $t2, $t1, 5