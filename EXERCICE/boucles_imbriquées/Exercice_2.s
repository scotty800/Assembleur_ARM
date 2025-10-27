.global _start

_start:
    mov R0, #1      @ compteur 1
    mov R1, #3      @ limite 1
    mov R2, #0      @ somme1 = 0

sum1_loop:
    cmp R0, R1
    bgt sum2_start
    add R2, R2, R0
    add R0, R0, #1
    b sum1_loop


sum2_start:
    mov R0, #1      @ compteur 2
    mov R1, #2      @ limite 2
    mov R3, #0      @ somme2 = 0

sum2_loop:
    cmp R0, R1
    bgt end_sum2
    add R3, R3, R0
    add R0, R0, #1
    b sum2_loop


end_sum2:
    mul R4, R2, R3  @ R4 = somme1 * somme2

    mov R0, R4      @ code de retour = produit
    mov R7, #1      @ syscall: exit
    svc #0
