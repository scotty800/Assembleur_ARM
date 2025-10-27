
    .global _start

_start:
    mov R0, #8      @ compteur = 8

loop:
    cmp R0, #0      @ comparer R0 à 0
    Beq stop        @ si R0 == 0, on sort
    sub R0, R0, #1  @ R0 = R0 - 1
    b loop

stop:
    mov R7, #1    @ syscall exit
    svc #0