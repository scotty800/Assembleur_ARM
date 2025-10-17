
    .global _start

_start:
    mov R0, #2      @ Premier nombre
    mov R1, #4      @ Deuxième nombre
    mov R2, #6      @ Troisième nombre
    bl addition     @ Appel de la fonction addition
    b stop

addition:
    ADD R3, R0, R1  @ R3 = R0 + R1
    ADD R3, R3, R2  @ R3 = R3 + R2
    bx lr           @ Retour à l'appelant

stop:
    mov R7, #1      @ syscall exit
    mov R0, R3      @ code de retour = somme
    svc #0
