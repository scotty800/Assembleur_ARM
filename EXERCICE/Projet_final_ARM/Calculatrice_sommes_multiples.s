    .data
msgN:          .asciz "Combien de nombres voulez-vous entrer ? "
msgEntrer:     .asciz "Entrez un nombre : "
msgSomme:      .asciz "Somme totale : "
msgMoy:        .asciz "Moyenne : "
msgMax:        .asciz "Maximum : "

table:         .space 100   @ tableau max 25 nombres

    .text
    .global _start

_start:

    @ --- Demande du N ---
    ldr r0, =msgN
    bl print_string

    bl read_digit       @ N dans r0
    mov r5, r0          @ r5 = N

    ldr r1, =table      @ r1 = address du tableau

    @ ----- Boucle de lecture ----
    mov r2, #0              @ i = 0

loop_read
    cmp r2, r5
    beq end_read

    ldr r0, =msgEntrer
    bl print_string

    bl read_digit @ r0 = valeur entrée

    str r0, [r1, r2, LSL #2] @ table[i] = r0

    add r2, r2, #1
    b loop_read

end_read:

    @ ---- Calcul somme ----
    ldr r0, =table
    mov r1, r5
    bl sum_table
    mov r6, r0      @ somme

    @ ---- Calcul max ----
    ldr r0, =table
    mov r1, r5
    bl max_table
    mov r7, r0     @ max

    @ ---- Calcul moyenne ----
    mov r0, r6
    mov r1, r5
    bl average
    mov r8, r0  @ moyenne

    @ ---- Affichage ----
    ldr r0, =msgSomme
    bl print_string
    mov r0, r6
    bl print_digit

    ldr r0, =msgMoy
    bl print_string
    mov r0, r8
    bl print_digit

    ldr r0, =msgMax
    bl print_string
    mov r0, r7
    bl print_digit

    b stop


@ ======= FONCTIONS =======

@ ------- sum_table -------
sum_table:
    push {r4, r5, lr}

    mov r4, r0      @ address
    mov r5, r1      @ N

    mov r0, #0      @ somme = 0
    mov r1, #0      @ i = 0

sum_loop:
    cmp r1, r5
    beq sum_end

    ldr r2, [r4, r1, LSL #2]
    add r0, r0, r2

    add r1, r1, #1
    b sum_loop

sum_end:
    pop {r4, r5, pc}

@ ------- max_table -------
max_table:
    push {r4, r5, lr}

    mov r4, r0
    mov r5, r1

    ldr r0, [r4]    @ max = table[0]
    mov r1, #1

max_loop:
    cmp r1, r5
    beq max_end

    ldr r2, [r4, r1, LSL #2]
    cmp r2, r0
    ble no_replace
    mov r0, r2

no_replace:
    add r1, r1, #1
    b max_loop

max_end:
    pop {r4, r5, pc}

@ ------ average -----
average:
    push {lr}
    udiv r0, r0, r1
    pop {pc}


@ ------ lecture ASCII 0-9 -----
read_digit:
    mov r7, #3      @ sys_read
    mov r1, r0
    sub sp, sp, #4
    mov r0, #0
    mov r2, #1
    mov r1, sp
    svc #0

    ldrb r0, [sp]
    add sp, sp, #4
    sub r0, r0, #48
    bx lr

@ ----- print_string -----
print_string:
    mov r7, #4
    mov r1, r0

find_len:
    ldrb r2, [r1]
    cmp r2, #0
    add r1, r1, #1
    bne find_len
    sub r1, r1, r0    @ r1 = len

    mov r7, #4
    mov r1, r0
    mov r0, #1
    svc #0
    bx lr

@ ----- print_digit ------
print_digit:
    add r0, r0, #48
    strb r0, [sp, #-4]!
    mov r7, #4
    mov r0, #1
    mov r1, sp
    mov r2, #1
    svc #0
    add sp, sp, #4
    bx lr

stop:
    mov r7, #1
    svc #0



