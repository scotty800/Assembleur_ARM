
    .global _start

_start:
    mov R0, #1      @ compteur (i = 1)
    mov R1, #4      @ N = 4
    mov R2, #0      @ somme = 0

sum_loop:
    add R2, R2, R0  @ somme += i
    add R0, R0, #1  @ i++
    cmp R0, R1
    ble sum_loop    @ tant que i <= N, continuer

stop:
    mov R7, #1      @ tant que i <= N, continuer
    mov R0, R2      @ placer la somme dans R0 pour exit
    svc #0