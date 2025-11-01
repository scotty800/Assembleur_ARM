    .global _start

    .text
_start:
    mov r0, #12          @ mettre 12 dans R0
    ldr r1, =val         @ charger l'adresse de val dans R1
    str r0, [r1]         @ stocker R0 à l'adresse val
    ldr r1, [r1]         @ charger la valeur de val dans R1
    b end

    .data
val: .word 0             @ variable initialisée à 0

    .text
end:
    mov r7, #1            @ syscall: exit
    svc #0
