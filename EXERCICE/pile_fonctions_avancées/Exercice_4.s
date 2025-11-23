
    .global _start

_start:
    mov R0, #5
    mov R1, #3
    bl addition
    
    mov R1, #2
    bl multiplication

    b stop

addition:
    push {lr}
    add R0, R0, R1
    pop {lr}
    bx lr

multiplication:
    push {lr}
    mul R0, R0, R1
    pop {lr}
    bx lr

stop:
    mov R7, #1
    svc #0