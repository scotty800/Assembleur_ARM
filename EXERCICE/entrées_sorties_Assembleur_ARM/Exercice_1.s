
    .data
msg:   .asciz "Bonjour ARM!\n"

    .text
    .global _start

_start:
    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =msg            @ Load address of msg into r1
    mov r2, #13             @ Length of the string
    mov r7, #4              @ syscall number for sys_write
    svc 0                   @ Make the syscall

    mov r0, #0              @ Exit code 0
    mov r7, #1              @ syscall number for sys_exit
    svc 0                    @ Make the syscall