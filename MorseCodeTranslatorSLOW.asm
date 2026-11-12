.MODEL SMALL
.STACK 100h

.DATA
    box_rows      DB 7, 11, 15, 19
    choice        DB 0

    title_text    DB 'MORSE CODE TRANSLATOR', 0
    subtitle_text DB '8086 ASSEMBLY EDITION', 0
    line_text     DB 72 DUP(196), 0
    select_text   DB 'Select operation:', 0

    box_top       DB 218, 70 DUP(196), 191, 0
    box_mid       DB 179, 70 DUP(' '), 179, 0
    box_bot       DB 192, 70 DUP(196), 217, 0

    opt1_text     DB '1. Text to Morse Code', 0
    opt2_text     DB '2. Morse Code to Text', 0
    opt3_text     DB '3. Clear Screen', 0
    opt4_text     DB '4. Exit', 0

    prompt_text   DB 'Enter your choice: ', 0
    err_empty     DB 'Error 1: Empty input! Press a number (1-4).     ', 0
    err_wrong     DB 'Error 2: Invalid key! Choose between 1 and 4.   ', 0
    done_text     DB 'i left it empty for us to implement', 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

    CALL clear_screen

    MOV DH, 1
    MOV DL, 29
    MOV BL, 0Bh
    LEA SI, title_text
    CALL print_text

    MOV DH, 2
    MOV DL, 29
    MOV BL, 07h
    LEA SI, subtitle_text
    CALL print_text

    MOV DH, 3
    MOV DL, 4
    MOV BL, 08h
    LEA SI, line_text
    CALL print_text

    MOV DH, 5
    MOV DL, 4
    MOV BL, 09h
    LEA SI, select_text
    CALL print_text

    MOV DI, 0
box_loop:
    MOV DH, box_rows[DI]
    CALL draw_box
    INC DI
    CMP DI, 4
    JL box_loop

    MOV DL, 6
    MOV BL, 1Bh

    MOV DH, 8
    LEA SI, opt1_text
    CALL print_text

    MOV DH, 12
    LEA SI, opt2_text
    CALL print_text

    MOV DH, 16
    LEA SI, opt3_text
    CALL print_text

    MOV DH, 20
    LEA SI, opt4_text
    CALL print_text

ask_input:
    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h
    LEA SI, prompt_text
    CALL print_text

    MOV AH, 00h
    INT 16h

    CMP AL, 13
    JE empty_error

    CMP AL, '1'
    JB wrong_error
    CMP AL, '4'
    JA wrong_error

    MOV [choice], AL
    JMP valid_choice

empty_error:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch
    LEA SI, err_empty
    CALL print_text
    JMP ask_input

wrong_error:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch
    LEA SI, err_wrong
    CALL print_text
    JMP ask_input

valid_choice:
    CALL clear_screen

    MOV DH, 12
    MOV DL, 22
    MOV BL, 0Bh
    LEA SI, done_text
    CALL print_text

    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h
MAIN ENDP

draw_box PROC
    PUSH DX
    PUSH SI

    MOV DL, 4
    MOV BL, 19h

    LEA SI, box_top
    CALL print_text

    INC DH
    LEA SI, box_mid
    CALL print_text

    INC DH
    LEA SI, box_bot
    CALL print_text

    POP SI
    POP DX
    RET
draw_box ENDP

clear_screen PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 07h
    MOV CX, 0000h
    MOV DX, 184Fh
    INT 10h

    POP DX
    POP CX
    POP BX
    POP AX
    RET
clear_screen ENDP

print_text PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

next_char:
    MOV AH, 02h
    MOV BH, 00h
    INT 10h

    MOV AL, [SI]
    CMP AL, 0
    JE done_print

    MOV AH, 09h
    MOV BH, 00h
    MOV CX, 1
    INT 10h

    INC SI
    INC DL
    JMP next_char

done_print:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
print_text ENDP

END MAIN