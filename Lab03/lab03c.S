.global q4

q4:
	ADD X1, XZR, XZR //Sets i to 0
	ADR X2, my_array //Gets address of my_array
	MOV X4, X2 //Puts address of  my_array to register 4

loop:
	CMP X1, #10 //Comparing i to 0
	B.EQ finish //Once i is equivalent to 10, end loop
	STUR X0, [X2, #0] //Stores j value into specified my_array index
	ADD X0, X0, #1 //Increments j
	ADD X1, X1, #1 //Increments i
	ADD X2, X2, #8 //Goes to next index of my_array
	B loop //calls loop

finish:
	MOV X0, X4 //Updates my_array
	BR X30 //Returns to main

.section .data

my_array:
.space 80 //80 bytes of zeros

