.global _start

_start:
    mov R0, #0      @ i = 0 (compteur externe)
    mov R1, #2      @ limite externe = 2
    mov R5, #0      @ compteur total = 0

outer_loop:
    cmp R0, R1      @ compare i et 2
    bgt end         @ si i > 2 → fin

    mov R2, #0      @ j = 0
    mov R3, #4      @ limite interne = 4

inner_loop:
    cmp R2, R3      @ compare j et 4
    bgt next_line   @ si j > 4 → ligne suivante

    add R5, R5, #1  @ incrémente compteur total
    add R2, R2, #1  @ j++
    b inner_loop

next_line:
    add R0, R0, #1  @ i++
    b outer_loop

end:
    mov R7, #1      @ syscall: exit
    mov R0, R5      @ retourne le compteur total dans R0
    svc #0
