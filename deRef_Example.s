# program name: deRef_Example.s
# Author : Antonino ITalia
# Date : 11/3/2025
# Purpose : This program will grab an input from the user using BL scanf, once begotten; prints out 2 different outputs, one with the result !dereferenced, and then two different ways to dereference for numbers
.text
.global main
main:
	# save return to OS on stack
	SUB sp, sp, #4      // make space on stack
	STR lr, [sp, #0]    // store return address

	# print prompt to user
	LDR r0, =prompt
	BL printf

	# intake user input using BL scanf
	LDR r0, =format
	LDR r1, =number
	BL scanf

	# First output
	LDR r0, =output
	LDR r1, =number
	BL printf
	
	# Second output
	LDR r0, =output
	LDR r1, =number
	LDR r1, [r1, #0]	// DE-REFERENCE
	BL printf


	# return to OS 
	LDR lr, [sp, #0] // restore return address
	ADD sp, sp, #4   // clean up stack space
	MOV pc, lr       // store return address

.data // data section 
	prompt: .asciz "Please input a number: \n"
	format: .asciz "%d"
	output: .asciz "Result: %d\n"

.bss // bss section
	number: .skip 4
