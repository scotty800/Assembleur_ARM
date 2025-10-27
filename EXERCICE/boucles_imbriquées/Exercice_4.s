.global _start

_start:
    mov R0, #0      @ i = 0
    mov R1, #3      @ N = 3
    mov R5, #0      @ compteur total = 0 (juste pour vérification)

outer_loop:
    cmp R0, R1
    bgt end         @ si i > 3, fin du programme

    mov R2, #0      @ j = 0

inner_loop:
    cmp R2, R1
    bgt next_line   @ si j > 3, passe à la ligne suivante

    cmp R0, R2
    beq skip_case   @ si i == j, saute cette itération

    @ Ici, on traite le cas valide (i != j)
    add R5, R5, #1  @ compte une itération valide

skip_case:
    add R2, R2, #1  @ j++
    b inner_loop    @ retour au début de la boucle interne

next_line:
    add R0, R0, #1  @ i++
    b outer_loop    @ retour au début de la boucle externe

end:
    mov R0, R5      @ on met le total dans R0 (utile pour echo $?)
    mov R7, #1      @ syscall: exit
    svc #0
