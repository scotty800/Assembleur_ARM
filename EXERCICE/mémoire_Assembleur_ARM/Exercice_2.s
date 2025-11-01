
    .global _start

    .text
_start:
    ldr R1, =table      @ charger l'adresse de table dans R1
    mov R5, #0          @ somme = 0
    mov R2, #0          @ index i = 0
    mov R3, #4          @ taille du tableau = 4

loop:
    cmp R2, R3          @ comparer i avec la taille du tableau
    bge end_loop        @ si i >= taille, sortir de la boucle

    ldr R4, [R1, R2, LSL #2]  @ charger table[i] dans R4
    add R5, R5, R4      @ somme += table[i]
    add R2, R2, #1      @ i++
    b loop              @ revenir au début de la boucle

   .data
table: .word 3, 6, 9, 12  @ tableau de 4 entiers

   .text
end_loop:
    mov R0, R5          @ mettre la somme dans R0 pour le retour
    mov R7, #1          @ syscall: exit
    svc #0              @ appel système
