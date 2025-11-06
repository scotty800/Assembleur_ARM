
    .data
buffer: .space 2          @ Reserve 2 bytes for two integer inputs
msg:    .asciz "Le resultat : "
result: .space 1         @ Reserve 1 byte for the result

    .text
    .global _start

_start:
    @ Read first integer from stdin
    mov r0, #0              @ File descriptor 0 is stdin
    ldr r1, =buffer         @ Load address of buffer into r1
    mov r2, #1              @ Number of bytes to read (1 byte for a character)
    mov r7, #3              @ syscall number for sys_read
    svc 0                   @ Make the syscall

    @ Read second integer from stdin
    mov r0, #0              @ File descriptor 0 is stdin
    ldr r1, =buffer + 1     @ Load address of buffer + 1 into r1
    mov r2, #1              @ Number of bytes to read (1 byte for a character)
    mov r7, #3              @ syscall number for sys_read
    svc 0                   @ Make the syscall

    @ Load the two integers from buffer
    ldr r0, =buffer         @ Load address of buffer into r0
    ldrb r1, [r0]            @ Load the first integer into r1
    ldrb r2, [r0, #1]        @ Load the second integer into r2

    @ Convert ASCII to integer
    sub r1, r1, #'0'        @ Convert first ASCII to integer
    sub r2, r2, #'0'        @ Convert second ASCII to integer

    @ Add the two integers
    add r3, r1, r2          @ Add the two integers, result in r3

    @ Convert the result back to ASCII
    add r3, r3, #'0'        @ Convert integer to ASCII

    @ Store the result in the buffer
    ldr r0, =result         @ Load address of result into r0
    strb r3, [r0]           @ Store the result byte

    @ Prepare to print the message
    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =msg            @ Load address of msg into r1
    mov r2, #14             @ Length of the message
    mov r7, #4              @ syscall number for sys_write
    svc 0                   @ Make the syscall

    @ Print the result
    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =result         @ Load address of result into r1
    mov r2, #1              @ Length of the result (1 byte)
    mov r7, #4              @ syscall number for sys_write
    svc 0                   @ Make the syscall

    @ Exit
    mov r0, #0              @ Exit code 0
    mov r7, #1              @ syscall number for sys_exit
    svc 0                   @ Make the syscall