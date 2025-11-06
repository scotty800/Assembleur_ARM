
    .data
buffer: .space 1         @ Reserve 1 byte for an integer input
msg:    .asciz "Le produit: "
result: .space 4         @ Reserve 4 bytes for the result

    .text
    .global _start

_start:
    @ Read integer from stdin
    mov r0, #0              @ File descriptor 0 is stdin
    ldr r1, =buffer         @ Load address of buffer into r1
    mov r2, #1              @ Number of bytes to read (1 byte for a character)
    mov r7, #3              @ syscall number for sys_read
    svc 0                   @ Make the syscall

    @ Load the integer from buffer
    ldr r0, =buffer         @ Load address of buffer into r0
    ldrb r1, [r0]           @ Load the byte from buffer into r1
    sub r1, r1, #'0'        @ Convert ASCII to integer

    @ Multiply the integer by 3
    mov r2, #3              @ Load 3 into r2
    mul r1, r1, r2          @ Multiply r1 by r2, result in r1

    @ Convert the result back to ASCII
    add r1, r1, #'0'        @ Convert integer back to ASCII

    @store the result
    ldr r0, =result        @ Load address of result into r0
    strb r1, [r0]          @ Store the result byte

    @ Prepare to print the message
    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =msg            @ Load address of msg into r1
    mov r2, #13             @ Length of the message
    mov r7, #4              @ syscall number for sys_write
    svc 0                   @ Make the syscall

    @ print the result
    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =result         @ Load address of result into r1
    mov r2, #1              @ Length of the result (1 byte)
    mov r7, #4              @ syscall number for sys_write
    svc 0                   @ Make the syscall


    @ Exit
    mov r0, #0              @ Exit code 0
    mov r7, #1              @ syscall number for sys_exit
    svc 0                   @ Make the syscall

