# Computer-Organization-ARM
Projects for CDA3101 taken in Spring 2019

In this repository I have the three projects for Computer Organization. The three projects are written in ARM.

Project 1 is a simple four function calculator, where to do "5 + 5", you would execute 5 5 +.
Project 2 takes in a string then replaces all the vowels with x's.
Project 3 takes in two integers and recursively calculates the greatest common divisor. This one is not executed as it should have been, because it does not go back up the stack.

The .s files for each project can be found in this repository. 
The file for project 1 is titled pantoja_roberto-1.s, the file for project 2 is titled pantoja_roberto-2.s, and the file for project 3 is titled pantoja_roberto-3.s.
The text of the code for each project can also be found below.

The code for project 1:

.section .data
        string_specifier: .asciz "%s" //string type

        integer_specifier: .string "%d" // decimal integer type

        char_specifier: .asciz "%c" // character type

        divbyzero_string: .asciz "Error, cannot divide by zero." // error message for divide by zero

        int1: .space 256 // space for first integer

        int2: .space 256 // space for second integer

        operator: .space 256 // space for operator

        newline: .asciz "\n"

        illegal_operator: .asciz "Error, illegal operator. Operator must be +,-,*, or /" // error message for illegal operator

.global main

.section .text

main:

//scan in first integer
ldr x0, =integer_specifier
ldr x1, =int1
bl scanf

//scan in second integer
ldr x0, =integer_specifier
ldr x1, =int2
bl scanf

//scan in operator
ldr x0, =string_specifier
ldr x1, =operator
bl scanf

//save first integer in safe register x19
ldr x0, =int1
ldr x19, [x0,#0]

//save second integer in safe register x20
ldr x0, =int2
ldr x20, [x0, #0]

//save operator in safe register x21
ldr x0, =operator
ldr x21, [x0, #0]

bl cases //branch to label "cases"

//print result
mov w0, w27 //move type specifier to x0
mov w1, w26 //move the result (saved in x26) to x1 for printing
bl printf

ldr x0, =newline
bl printf

b exit //end program

cases:

sub x22, x21, #43 //subtract 43 (ascii value for +) from operator (saved in x21)
cbz x22, add //if result is 0 (operator is +) branch to add

sub x23, x21, #45 //subtract 43 (ascii value for -) from operator (saved in x21)
cbz x23, sub //if result is 0 (operator is -) branch to sub

sub x24, x21, #42 //subtract 43 (ascii value for *) from operator (saved in x21)
cbz x24, mul  //if result is 0 (operator is *) branch to mul

sub x25, x21, #47 //subtract 43 (ascii value for /) from operator (saved in x21)
cbz x25, div //if result is 0 (operator is /) branch to div

//if operator is not +,-,*, or /, set x26 equal to error message and x27 equal tp "%s", then return to main for printing
ldr x26, =illegal_operator
ldr x27, =string_specifier
br x30

add:

//store x19+x20 in x26 and "%d" in x27, then branch to main for printing
add x26, x19, x20
ldr x27, =integer_specifier
br x30

sub:

//store x19-x20 in x26 and "%d" in x27, then branch to main for printing
sub x26, x19, x20
ldr x27, =integer_specifier
br x30

mul:

//store x19*x20 in x26 and "%d" in x27, then branch to main for printing
mul x26, x19, x20
ldr x27, =integer_specifier
br x30

div:

//if second integer is 0, branch to divbyzero
cbz x20, divbyzero

//else store x19/x20 in x26 and "%d" in x27, then branch to main for printing

sdiv w26, w19, w20
ldr w27, =integer_specifier
br x30

divbyzero:

//set x26 equal to error message and set x27 equal to "%s", then branch to main for printing
ldr x26, =divbyzero_string
ldr x27, =string_specifier
br x30

//end program
exit:
mov x0, #0
mov x8, #93
svc #0    

cbz x23, sub //if result is 0 (operator is -) branch to sub

 

sub x24, x21, #42 //subtract 42 (ascii value for *) from operator (saved in x21)

cbz x24, mul  //if result is 0 (operator is *) branch to mul

 

sub x25, x21, #47 //subtract 47 (ascii value for /) from operator (saved in x21)

cbz x25, div //if result is 0 (operator is /) branch to div

 

//if operator is not +,-,*, or /, set x26 equal to error message and x27 equal tp "%s", then return to main for printing

ldr x26, =illegal_operator

ldr x27, =string_specifier

br x30

 

add:

 

//store x19+x20 in x26 and "%d" in x27, then branch to main for printing

add x26, x19, x20

ldr x27, =integer_specifier

br x30

 

sub:

 

//store x19-x20 in x26 and "%d" in x27, then branch to main for printing

sub x26, x19, x20

ldr x27, =integer_specifier

br x30

 

mul:

 

//store x19*x20 in x26 and "%d" in x27, then branch to main for printing

mul x26, x19, x20

ldr x27, =integer_specifier

br x30

 

div:

 

//if second integer is 0, branch to divbyzero

cbz x20, divbyzero

 

//else store x19/x20 in x26 and "%d" in x27, then branch to main for printing

sdiv x26, x19, x20

ldr x27, =integer_specifier

br x30

 

divbyzero:

 

//set x26 equal to error message and set x27 equal to "%s", then branch to main for printing

ldr x26, =divbyzero_string

ldr x27, =string_specifier

br x30

 

//end program

exit:

mov x0, #0

mov x8, #93

svc #0

The code for project 2:

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

The code for project 3:

.section .data

        integer_specifier: .asciz "%d" // integer type

        string_specifier: .asciz "%s" // string type

        char_specifier: .asciz "%c" // char type

        int1: .space 256 // holds first input int

        int2: .space 256 // holds second input int

        newline: .asciz "\n" // newline for flushing printf

        input_text: .asciz "Enter Two Integers: " // prompts user input         

.global main

.section .text

main:

//prompt user for input
ldr x0, =string_specifier
ldr x1, =input_text
bl printf

//take in first integer
ldr x0, =integer_specifier
ldr x1, =int1
bl scanf

//take in second integer
ldr x0, =integer_specifier
ldr x1, =int2
bl scanf

//load integers 1 and 2 into registers x1 and x2 respectively
ldr x19, =int1
ldrsw x19, [x19, #0]
ldr x20, =int2
ldrsw x20, [x20, #0]

//make space in stack
sub sp, sp, #48
//store integers in stack
str x19, [sp, #0]
str x20, [sp, #16]

//if x19 is less than x20, swap, else go to basecase
cmp x19, x20
b.gt baseCase

//swap int1 and int2
mov x3, x19
mov x19, x20
mov x20, x3

baseCase:

//update values
str x19, [sp, #0]
str x20, [sp, #16]

//find the mod of the two values
sdiv x21, x19, x20
mul x21, x21, x20
sub x21, x19, x21

//if the mod isn't 0, go to recursive case, else print the result
cbnz x21, recursiveCase

//move the gcd in x20 into x19
mov x19, x20
b printResult

recursiveCase:

//put x20 in x19 and x19 % x20 in x20
mov x19, x20
mov x20, x21

//make space in stack and store values
sub sp, sp, #48
str x19, [sp, #0]
str x20, [sp, #16]

bl gcd

gcd:

//make space in stack and store return address
sub sp, sp, #48
stur x30, [sp, #32]
cbz x20, printResult //if x20 is 0, print the result

//find mod
sdiv x21, x19, x20
mul x21, x21, x20
sub x21, x19, x21

//put x20 in x19 and x19 % x20 in x20
mov x19, x20
mov x20, x21

bl gcd

//load return address
ldur x30, [sp, #32]
//pop stack
add sp, sp, #48

br x30

printResult:

//if x19 is negative make it positive then print it
//else print x19
cmp x19, #0
b.gt print

neg x19, x19

//print x19
print:

ldr x0, =integer_specifier
mov x1, x19
bl printf

ldr x0, =newline
bl printf

//terminate program
exit:

mov x0, #0
mov x8, #93
svc #0
