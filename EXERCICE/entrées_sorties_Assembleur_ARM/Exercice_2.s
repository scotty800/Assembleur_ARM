
    .data
buffer: .space 4          @ Reserve 4 bytes for input (4 characters)

    .text
    .global _start

_start:
    mov r0, #0              @ File descriptor 0 is stdin
    ldr r1, =buffer         @ Load address of buffer into r1
    mov r2, #4              @ Number of bytes to read (4 bytes for an integer)
    mov r7, #3              @ syscall number for sys_read
    svc 0                    @ Make the syscall

    mov r0, #1              @ File descriptor 1 is stdout
    ldr r1, =buffer         @ Load address of buffer into r1
    mov r2, #4              @ Number of bytes to write (4 bytes for an integer)
    mov r7, #4              @ syscall number for sys_write
    svc 0                    @ Make the syscall

    mov r0, #0              @ Exit code 0
    mov r7, #1              @ syscall number for sys_exit
    svc 0                    @ Make the syscall