.global q3

q3:
	ADD X0, XZR, XZR //Sets i = 0
	ADR X1, UIN //Sets memory address of UIN to register 1
	LDUR X2, [X1, #0] //Loads the value of 20 to register 2

loop:
	CMP X0, #10 //Compares i to the number 10
	B.EQ finish //Once i is equivalent to 10, end loop
	SUB X2, X2, #1 //Subtract 1 from UIN value
	ADD X0, X0, #1 //Increments i
	B loop //Go to loop

finish:
	STUR X2, [X1, #0] //Stores UIN in memory to address in register 1
	MOV X0, X2 //Moves UIN to return register
	BR X30 //Returns to main

.section .data

UIN:
.quad 20 //double word

