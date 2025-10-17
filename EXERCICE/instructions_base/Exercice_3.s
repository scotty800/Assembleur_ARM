
    .global _start

_start:
    mov R0, #5      @ Premier nombre
    mov R1, #3      @ Deuxième nombre
    bl mulFunc      @ Appel de la fonction de multiplication
    b stop          @ Va à la fin du programme

mulFunc:
    MUL R0, R0, R1  @ r0 = r0 * r1
    bx lr           @ Retour  à l'applant

stop:
    mov R7, #1      @ syscall exit
    svc #0