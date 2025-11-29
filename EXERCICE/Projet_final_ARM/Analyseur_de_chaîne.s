    
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
    add r2, r2, #1

next_char:
    add r6, r6, #1
    b loop_analyze

end_analyze:
    pop {r4-r7, pc}