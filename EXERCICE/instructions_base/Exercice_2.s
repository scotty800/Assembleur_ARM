
    .global _start

_start:
    mov R0, #10     @ Met 10 dans R0
    mov R1, #15     @ Met 15 dans 51
    cmp R0, R1      @ Compare R0 et R1
    blt smaller     @ Si R0 < R1, saute à 'smaller'
    mov R2, #0      @ Sinon, R2 = 0
    b stop          @ Va à la fin

smaller:
    mov R2, #1      @ Si R0 < R1, R2 = 1

stop:
    mov R7, #1      @ sycall exit
    mov r0, r2      @ Code de retour = R2
    svc #0