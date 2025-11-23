
    .global _start

_start:
    mov R0, #1
    mov R1, #5
    bl addition
    b stop

addition:
    push {R1, R2}
    mov R2, #0

loop:
    cmp R0, R1
    bgt end_loop
    add R2, R2, R0
    add R0, R0, #1
    b loop

end_loop:
    mov R0, R2
    pop {R1, R2}
    bx lr

stop:
    mov R7, #1
    svc #0
