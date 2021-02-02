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