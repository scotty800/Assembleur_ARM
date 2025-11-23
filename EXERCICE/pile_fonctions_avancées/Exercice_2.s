
    .global _start

_start:
    mov R0, #5
    mov R1, #5
    bl addition
    b stop

addition:
    push {R2, R3}
    mov R2, R0
    mov R3, #0
    add R3, R2, R1
    mov R0, R3
    pop {R2, R3}
    bx lr

stop:
    mov R7, #1
    svc #0