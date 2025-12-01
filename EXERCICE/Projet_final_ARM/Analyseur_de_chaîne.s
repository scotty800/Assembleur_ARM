    
    .data

msg_prompt:   .asciz "Entrez une chaîne de caractères : "
msg_letters:  .asciz "Nombre de lettres : "
msg_digits:   .asciz "Nombre de chiffres : "
msg_spaces:   .asciz "Nombre d'espaces : "
msg_specials: .asciz "Nombre de caractères spéciaux : "
msg_freq:     .asciz "Lettre la plus fréquente : "

buffer:       .space 50    @ espace pour la chaîne
frq_letters:  .space 26*4  @ fréquence des lettres a-z

    .text
    .global _start

_start:
    @ --- Affiche le message de prompt ---
    ldr r0, =msg_prompt
    bl print_string

    @ ---- Lit jusqu'à 50 caractères ----
    mov r0, #0         @ file descriptor 0 (stdin)
    ldr r1, =buffer    @ buffer pour stocker la chaîne
    mov r2, #50        @ nombre maximum de caractères à lire
    mov r7, #3         @ syscall read
    svc #0

    mov r4, r0         @ r4 = nombre de caractères lus

    @ ---- Aanalyse de la chaîne ----
    ldr r0, =buffer    @ r0 = adresse de la chaîne
    mov r1, r4         @ r1 = longueur de la chaîne
    bl analyze_string

    mov r5, r0         @ r5 = nombre de lettres
    mov r6, r1         @ r6 = nombre de chiffres
    mov r7, r2         @ r7 = nombre d'espaces
    mov r8, r3         @ r8 = nombre de spéciaux

    @ ---- Lettre la plus fréquente ----
    ldr r0, =frq_letters
    mov r1, r4         @ longueur de la chaîne
    bl most_frequent_letter
    mov r9, r0         @ r9 = lettre la plus fréquente

    @ ---- Affichage des résultats ----
    ldr r0, =msg_letters
    bl print_string
    mov r0, r5
    bl print_number

    ldr r0, =msg_digits
    bl print_string
    mov r0, r6
    bl print_number

    ldr r0, =msg_spaces
    bl print_string
    mov r0, r7
    bl print_number

    ldr r0, =msg_specials
    bl print_string
    mov r0, r8
    bl print_number

    ldr r0, =msg_freq
    bl print_string
    mov r0, r9
    bl print_char

stop:
    mov r7, #1         @ syscall exit
    svc #0

@ ======= FONCTIONS =======

@ ------- analyze_string -------
analyze_string:
    push {r4-r7, lr}

    mov r4, r0      @ adresse de la chaîne
    mov r5, r1      @ longueur de la chaîne

    mov r0, #0      @ count_letters
    mov r1, #0      @ count_digits
    mov r2, #0      @ count_spaces
    mov r3, #0      @ count_specials

    mov r6, #0      @ index

loop_analyze:
    cmp r6, r5
    beq end_analyze

    ldrb r7, [r4, r6]  @ charger le caractère courant

    cmp r7, #'a'
    blt check_upper
    cmp r7, #'z'
    bgt is_letter
    b check_upper
    add r0, r0, #1
    b next_char

check_upper:
    cmp r7, #'A'
    blt check_digit
    cmp r7, #'Z'
    bgt check_digit
    add r0, r0, #1
    b next_char

check_digit:
    cmp r7, #'0'
    blt check_space
    cmp r7, #'9'
    bgt check_space
    add r1, r1, #1
    b next_char

check_space:
    cmp r7, #' '
    bne is_space
    add r2, r2, #1
    b next_char

is_space:
    add r3, r3, #1

next_char:
    add r6, r6, #1
    b loop_analyze

end_analyze:
    pop {r4-r7, pc}

most_frequent_letter:
    push {r4-r8, lr}

    mov r4, r0      @ adresse de la chaîne
    mov r5, r1      @ longueur de la chaîne
    ldr r6, =frq_letters

    @ reset tableau freq
    mov r7, #0

reset_loop:
    cmp r7, #26
    beq start_count
    mov r8, #0
    str r8, [r6, r7, LSL #2]
    add r7, r7, #1
    b reset_loop

start_count:
    mov r7, #0

count_loop:
    cmp r7, r5
    beq find_max

    ldrb r8, [r4, r7]  @ charger le caractère courant

    @ convertir en minuscule si majuscule
    cmp r8, #'A'
    blt skip_count
    cmp r8, #'Z'
    bgt check_lower
    add r8, r8, #32    @ convertir en minuscule
    b process_letter

check_lower:
    cmp r8, #'a'
    blt skip_count
    cmp r8, #'z'
    bgt skip_count

process_letter:
    sub r8, r8, #'a'   @ index de la lettre
    ldr r9, [r6, r8, LSL #2]
    add r0, r0, #1
    str r0, [r6, r8, LSL #2]

skip_count:
    add r7, r7, #1
    b count_loop

find_max:
    mov r7, #0      @ index
    mov r0, #0      @ max count
    mov r1, #0      @ lettre la plus fréquente

find_loop:
    cmp r7, #26
    beq freq_end

    ldr r2, [r6, r7, LSL #2]
    cmp r2, r0
    ble skip_max
    mov r0, r2
    add r1, r7

skip_max:
    add r7, r7, #1
    b find_loop

freq_end:
    cmp r0, #0
    beq no_letter

    add r0, r1, #'a'
    pop {r4-r8, pc}

no_letter:
    mov r0, #0
    pop {r4-r8, pc}

@ ------- print_string -------
print_string:
    push {lr}
    mov r1, #0

len_loop:
    ldrb r2, [r0, r1]
    cmp r2, #0
    add r1, r1, #1
    bne len_loop
    sub r1, r1, #1

    mov r7, #4         @ syscall write
    mov r2, r1         @ longueur
    mov r1, r0         @ buffer
    mov r0, #1         @ file descriptor 1 (stdout)
    svc #0
    pop {lr}

@ ------- print_char -------
print_char:
    push {lr}
    sub sp, sp, #4
    strb r0, [sp]
    mov r0, #1         @ file descriptor 1 (stdout)
    mov r1, sp         @ buffer
    mov r2, #1         @ longueur
    mov r7, #4         @ syscall write
    svc #0
    add sp, sp, #4
    pop {pc}

@ ------- print_number -------
print_number:
    add r0, r0, #0
    b print_char
