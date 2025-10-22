
.global _start

_start:
    mov R0, #7          @ nombre à tester (change cette valeur)
    and R2, R0, #1      @ garde uniquement le bit de poids faible
    cmp R2, #0          @ compare à 0
    beq pair            @ si égal à 0 → pair
    mov R1, #0          @ sinon impair → R1 = 0
    b stop

pair:
    mov R1, #1          @ si pair → R1 = 1

stop:
    mov R7, #1          @ syscall: exit
    mov R0, R1          @ mettre R1 dans R0 pour renvoyer le résultat
    svc #0
