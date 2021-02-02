.section .data
	input_specifier: .asciz "%[^\n]s" // input type

	string_specifier: .asciz "%s" // string type
	
	char_specifier: .asciz "%c" // char type

	str1: .space 256 // holds input string

	newline: .asciz "\n" // newline for flushing printf

	tmp_char: .space 8 // holds char for going through string

	x_char: .asciz "x" // holds x for printing

	space: .asciz " " // space for output

	input_text: .asciz "Input a string:" // prompts user input

.global main

.section .text

main:

// print text prompting input
ldr x0, =string_specifier
ldr x1, =input_text
bl printf

ldr x0, =space
bl printf

// scan in input
ldr x0, =input_specifier
ldr x1, =str1
bl scanf

// set x19 to zero so that it can serve as a counter to iterate through string
mov x19, #0
// load string into x20
ldr x20, =str1

loop:
// if character is 0 (reached end of string), exit program
ldrb w21, [x20, x19] 
cbz w21, exit 

sub w22, w21, #97 // checks if char is a
cbz w22, printx // if it is, branch to print x

sub w22, w21, #101 // checks if char is e
cbz w22, printx // if it is, branch to print x

sub w22, w21, #105 // checks if char is i
cbz w22, printx // if it is, branch to print x

sub w22, w21, #111 // checks if char is o
cbz w22, printx // if it is, branch to print x

sub w22, w21, #117 // checks if char is u
cbz w22, printx // if it is, branch to print x

sub w22, w21, #65 // checks if char is A
cbz w22, printx // if it is, branch to print x

sub w22, w21, #69 // checks if char is E
cbz w22, printx // if it is, branch to print x

sub w22, w21, #73 // checks if char is I
cbz w22, printx // if it is, branch to print x

sub w22, w21, #79 // checks if char is O
cbz w22, printx // if it is, branch to print x

sub w22, w21, #85 // checks if char is U
cbz w22, printx // if it is, branch to print x

// if this has been reached, char is not vowel, so it will be printed
ldr w0, =char_specifier
mov w1, w21
bl printf
b increment // branch to increment

printx:
// if char is a vowel, print an x in its place
ldr x0, =string_specifier
ldr x1, =x_char
bl printf

// increment x19 by 1
increment:
add x19, x19, #1
b loop // continue loop

exit:
// print newline to flush printf
ldr x0, =newline
bl printf

mov x0, #0
mov x8, #93
svc #0
