
    .global _start

_start:
    mov R0, #5
    mov R1, #5
    bl addition
    b stop

addition:
    add R0, R0, R1
    bx lr

stop:
    mov R7, #1
    svc #0
