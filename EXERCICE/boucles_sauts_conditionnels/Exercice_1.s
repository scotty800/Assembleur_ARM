
    .global _start

_start:
    mov R0, #0      @ compteur = 0
    mov R1, #10     @ valeur limite = 10

loop:
    cmp R0, R1      @ compare R0 et R1
    beq stop        @ si R0 == R1, on saute à stop

    ADD R0, R0, #1  @ sinon, on incrémente R0
    B loop          @ et on recommence

stop:
    mov R7, #1      @ syscall exit
    svc #0

    