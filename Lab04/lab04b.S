.global n_fact

n_fact:
	CBZ X0, base_case
	STP FP, X30, [SP, #-16]!
	SUB SP, SP, #16
	STR X0, [SP, #0]
	SUB X0, X0, #1
	BL n_fact
	MOV X1, X20
	LDR X0, [SP, #0]
	ADD SP, SP, #16
	BL my_mul
	MOV X20, X0
	LDP FP, X30, [SP], #16
	BR X30

base_case:
	MOVZ X20, #1
	BR X30
