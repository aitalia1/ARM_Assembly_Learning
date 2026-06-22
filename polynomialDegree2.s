# program name: polynomialDegree2.s
# Author : Antonino Italia
# Date of copy: 12/4/2025
# Purpose: Subroutine that takes in four arguments from [r0, r1, r2, r3]. Then, 
#	   does the following math equation: ax^2 + bx + c
.text
.global main
main:
	# save return to OS on stack
	SUB sp, sp, #4      // make space on stack
	STR lr, [sp, #0]    // store return address
	
	MOV fp, sp		// set new frame pointer
	SUB sp, sp, #32		// reserve sixteen bytes for four operands

	# test case 1
	MOV r0, #4
	MOV r1, #3
	MOV r2, #6
	MOV r3, #8
	BL polyDegree2		// CALL subroutine

	MOV r1, r0		// move r0 into r1
	LDR r0, =message	// load message
	BL printf		// CALL PRINTF

	# test case 2
	MOV r0, #8
	MOV r1, #98
	MOV r2, #2
	MOV r3, #1
	BL polyDegree2		// CALL subroutine

	MOV r1, r0		// move r0 into r1
	LDR r0, =message	// load message
	BL printf		// CALL PRINTF	

	MOV sp, fp
	# return to OS 
	LDR lr, [sp, #0] // restore return address
	ADD sp, sp, #4   // clean up stack space
	MOV pc, lr       // store return address

# Pre condition:
#	store a, b, c, and x into the first four registers
# Post condition: r0 equals the result of the equation ax^2 + bx + c
polyDegree2:
# Function Prologue
	SUB sp, sp, #8
	STR fp, [sp, #4]
	STR lr, [sp, #0]
	MOV fp, sp
	
	SUB sp, sp, #16
	STR r0, [fp, #-4]	// A
	STR r1, [fp, #-8]	// B
	STR r2, [fp, #-12]	// C
	STR r3, [fp, #-16]	// X
	LDR r3, [fp, #-16]	// load value at #-16 into r3
	MUL r4, r3, r3		// x * x for the x^2


	LDR r0, [fp, #-4]	// load value at #-4 into r0
	MUL r0, r0, r4		// a * x^2

	LDR r1, [fp, #-8]
	LDR r3, [fp, #-16]
	MUL r1, r1, r3		// b * x

	ADD r0, r0, r1		// ax^2 + b
	LDR r2, [fp, #-12]	// c
	ADD r0, r0, r2		// add c to a + b
	#not really sure how to do this WITHOUT using more than 2 MULS and 1 ADD.

	# Function Epilogue
				//					
	MOV sp, fp		// CLEAR THE STACK! clears local variables
	LDR lr, [sp, #0]	// reset link register
	LDR fp, [sp, #4]	// reset frame pointer
	ADD sp, sp, #8		// pop eight bytes off of the stack
	BX lr			// return to caller
	
	# END OF "polyDegree2" SUBROUTINE


.data // data section
	message: .asciz "your result is: %d\n\n"
