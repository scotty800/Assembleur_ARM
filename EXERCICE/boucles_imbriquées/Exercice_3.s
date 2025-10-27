.global _start

_start:
    mov R0, #1      @ compteur externe (ligne) = 1
    mov R1, #3      @ N = 3
    mov R5, #0      @ somme totale = 0

outer_loop:
    cmp R0, R1
    bgt end         @ si R0 > N, on quitte la boucle externe

    mov R2, #1      @ compteur interne (colonne) = 1

inner_loop:
    cmp R2, R1
    bgt next_line   @ si R2 > N, on passe à la ligne suivante

    mul R4, R0, R2  @ R4 = R0 * R2
    add R5, R5, R4  @ ajoute le produit à la somme totale

    add R2, R2, #1  @ incrémente le compteur interne
    b inner_loop    @ boucle interne continue

next_line:
    add R0, R0, #1  @ incrémente le compteur externe
    b outer_loop    @ retourne à la boucle externe

end:
    mov R0, R5      @ retourne la somme totale dans R0
    mov R7, #1      @ syscall: exit
    svc #0
