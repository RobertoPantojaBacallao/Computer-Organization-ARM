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
