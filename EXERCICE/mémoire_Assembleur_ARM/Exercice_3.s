
    .global _start

_start:
    ldr R1, =table      @ charger l'adresse de table dans R1
    mov R2, #0          @ index i = 0
    mov R3, #3          @ taille du tableau = 3

loop:
    cmp R2, R3          @ comparer i avec la taille du tableau
    bge end_loop        @ si i >= taille, sortir de la boucle

    ldr R4, [R1, R2, LSL #2]  @ charger table[i] dans R4
    add R5, R4, R4            @ double la valeur (R5 = R4 * 2)
    str R5, [R1, R2, LSL #2]  @ stocker la valeur doublée dans table[i]

    add R2, R2, #1      @ i++
    b loop              @ revenir au début de la boucle

    .data
table: .word 2, 4, 6    @ tableau de 3 entiers

    .text

end_loop:
    mov R0, #0          @ mettre le produit dans R0 pour le retour
    mov R7, #1          @ syscall: exit
    svc #0              @ appel système