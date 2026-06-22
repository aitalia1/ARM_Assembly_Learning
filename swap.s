# program name: swap.s
# Author : Antonino Italia
# Date of copy: 12/4/2025
# Purpose: Program that replicates swap(int &a, int &b) function from C/C++
.text
.global main
main:
	# save return to OS on stack
	SUB sp, sp, #4      // make space on stack
	STR lr, [sp, #0]    // store return address
	
	MOV fp, sp		// set new frame pointer
	SUB sp, sp, #32		// reserve sixteen bytes for four operands
	
	LDR r1, =aVal		// aVal loaded in r1
	MOV r0, #67		// mov 67 into ro
	STR r0, [r1]		// str r1 into r0

	LDR r1, =bVal		// bVal loaded into r1
	MOV r0, #20		// move 20 into r0
	STR r0, [r1]		// str r1 into r0

	
	LDR r0, =aVal		// load aVal into r0
	LDR r1, =bVal		// load bVal into r1
	BL swap			// CALL Swap
	

	# print message
	LDR r0, =message
	LDR r1, =aVal
	LDR r1, [r1]
	LDR r2, =bVal
	LDR r2, [r2]
	BL printf

	MOV sp, fp
	# return to OS 
	LDR lr, [sp, #0] // restore return address
	ADD sp, sp, #4   // clean up stack space
	MOV pc, lr       // store return address
# Pre condition:
#	store r0 as a, store r1 as b
# Post condition: r1 and r0 are swapped value-wise
swap:
# Function Prologue
	SUB sp, sp, #8
	STR fp, [sp, #4]
	STR lr, [sp, #0]
	MOV fp, sp

	# load registers into other registers
	LDR r2, [r0]		// A
	LDR r3, [r1]		// B

	# swap
	STR r2, [r1]		// B
	STR r3, [r0]		// A
	
	# Function Epilogue
				//					
	MOV sp, fp		// CLEAR THE STACK! clears local variables
	LDR lr, [sp, #0]	// reset link register
	LDR fp, [sp, #4]	// reset frame pointer
	ADD sp, sp, #8		// pop eight bytes off of the stack
	BX lr			// return to caller
	
	# END OF "swap" SUBROUTINE


.data // data section

	message: .asciz "swapped numbers: a: %d. b %d.\n\n"
	format: .asciz "%d"
	aVal: .skip 4
	bVal: .skip 4
