.section .text
.globl lab02d

lab02d:
	ADD X0, X0, #1000
	ADR X1, myvalue
	STUR X0, [X1, 0]
	LDUR X2, [X1, 0]
	BR X30

.section	.data
myvalue: .quad 0
