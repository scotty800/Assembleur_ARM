
    .global _start

_start:
    mov r0, #4          @ Premier nombre
    mov r1, #9          @ Deuxième nombre
    bl addition         @ Appelle la fonction addition
    b stop              @ Fin du programme

addition:
    add r2, r0, r1      @ r2 = r0 + r1
    bx lr               @ Retour à l'appelant

stop:
    mov r7, #1          @ syscall exit
    mov r0, r2          @ code de retour = somme
    svc #0
