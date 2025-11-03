# program name: helloWorld.s
# Author : Antonino ITalia
# Date : 11/3/2025
# Purpose : This program is a simple "Hello World" program coded inside of ARM Assembly
.text
.global main
main:
	# save return to OS on stack
	SUB sp, sp, #4      // make space on stack
	STR lr, [sp, #0]    // store return address

	# print hello world
	LDR r0, =hWrld		// load hWrld into register 0
	BL printf		// call PRINTF

	# return to OS 
	LDR lr, [sp, #0] // restore return address
	ADD sp, sp, #4   // clean up stack space
	MOV pc, lr       // store return address

.data // data section 
	hWrld: .asciz "Hello, World?\n"
