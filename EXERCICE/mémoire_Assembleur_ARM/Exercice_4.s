
    .global _start

    .text
_start:
    ldr R1, =table      @ charger l'adresse de table dans R1
    mov R2, #0          @ index i = 0
    mov R3, #4          @ taille du tableau = 4
    ldr R6, [R1]        @ charger la première valeur du tableau dans R6

loop:
    cmp R2, R3          @ comparer i avec la taille du tableau
    bge end_loop        @ si i >= taille, sortir de la boucle

    ldr R4, [R1, R2, LSL #2]  @ charger table[i] dans R4
    cmp R4, R6                @ comparer i avec la première valeur du tableau
    ble skip_increment        @ si i <= table[0], sauter l'incrément
    mov R6, R4                @ mettre à jour la nouvelle valeur maximale

skip_increment:
    add R2, R2, #1      @ i++
    b loop              @ revenir au début de la boucle

    .data
table: .word 8, 3, 10, 4      @ tableau de 4 entiers

    .text

end_loop:
    mov R0, R6         @ mettre la valeur maximale dans R0 pour le retour
    mov R7, #1          @ syscall: exit
    svc #0              @ appel système