.text
.global test2

test2:
	SUB X0, X0, X1
	MOV X1, X0
	ADR X0, string
	STR X30, [SP, #-16]!
	BL printf
	LDR X30, [SP, #0]
	ADD SP, SP, #16
	BR X30

.section .data

string:
.asciz "Result of test2(6, 5) = %lld\n"