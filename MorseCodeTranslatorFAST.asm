.MODEL SMALL
.STACK 100h

.DATA
    BOX_ROWS        DB 7, 11, 15, 19
    BOX_COUNT       EQU 4
    USER_CHOICE     DB 0

    TITLE_STR       DB 'MORSE CODE TRANSLATOR', 0
    SUBTITLE_STR    DB '8086 ASSEMBLY EDITION', 0
    SELECT_STR      DB 'Select operation:', 0

    OPT1_STR        DB '1. Text to Morse Code', 0
    OPT2_STR        DB '2. Morse Code to Text', 0
    OPT3_STR        DB '3. Clear Screen', 0
    OPT4_STR        DB '4. Exit', 0

    PROMPT_STR      DB 'Enter your choice: ', 0

    ERR_EMPTY_STR   DB 'Error 1: Empty input! Press a number key (1-4).      ', 0
    ERR_RANGE_STR   DB 'Error 2: Invalid key! Only options 1 to 4 are valid. ', 0
    CLEAR_MSG_STR   DB '                                                     ', 0

    EMPTY_IMPL_STR  DB 'i left it empty for us to implement', 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

    CALL DRAW_MAIN_GUI

PROMPT_LOOP:
    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h
    LEA SI, PROMPT_STR
    CALL PRINT_COLOR_STR

    MOV DH, 23
    MOV DL, 23
    CALL SET_CURSOR
    MOV AH, 09h
    MOV AL, ' '
    MOV BH, 00h
    MOV BL, 0Bh
    MOV CX, 1
    INT 10h
    CALL SET_CURSOR

    CALL READ_AND_VALIDATE_KEY
    CMP AL, 0
    JE PROMPT_LOOP

    CALL CLEAR_FULL_SCREEN
    MOV DH, 12
    MOV DL, 22
    MOV BL, 0Bh
    LEA SI, EMPTY_IMPL_STR
    CALL PRINT_COLOR_STR

    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h
MAIN ENDP

DRAW_MAIN_GUI PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    CALL CLEAR_FULL_SCREEN

    MOV DH, 1
    MOV DL, 29
    MOV BL, 0Bh
    LEA SI, TITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 2
    MOV DL, 29
    MOV BL, 07h
    LEA SI, SUBTITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 3
    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h
    MOV AL, 0C4h
    MOV BH, 00h
    MOV BL, 08h
    MOV CX, 72
    INT 10h

    MOV DH, 5
    MOV DL, 4
    MOV BL, 09h
    LEA SI, SELECT_STR
    CALL PRINT_COLOR_STR

    XOR SI, SI
DRAW_BOXES_LOOP:
    MOV DH, BOX_ROWS[SI]
    CALL DRAW_MENU_BOX
    INC SI
    CMP SI, BOX_COUNT
    JL DRAW_BOXES_LOOP

    MOV DH, 8
    MOV DL, 6
    MOV BL, 1Bh
    LEA SI, OPT1_STR
    CALL PRINT_COLOR_STR

    MOV DH, 12
    MOV DL, 6
    MOV BL, 1Bh
    LEA SI, OPT2_STR
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 6
    MOV BL, 1Bh
    LEA SI, OPT3_STR
    CALL PRINT_COLOR_STR

    MOV DH, 20
    MOV DL, 6
    MOV BL, 1Bh
    LEA SI, OPT4_STR
    CALL PRINT_COLOR_STR

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_MAIN_GUI ENDP

DRAW_MENU_BOX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 19h
    MOV CH, DH
    MOV CL, 4
    MOV DL, 75
    ADD DH, 2
    INT 10h
    SUB DH, 2

    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h
    MOV AL, 0DAh
    MOV BH, 00h
    MOV BL, 19h
    MOV CX, 1
    INT 10h

    MOV DL, 5
    CALL SET_CURSOR
    MOV AL, 0C4h
    MOV CX, 70
    INT 10h

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0BFh
    MOV CX, 1
    INT 10h

    INC DH
    MOV DL, 4
    CALL SET_CURSOR
    MOV AL, 0B3h
    MOV CX, 1
    INT 10h

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0B3h
    MOV CX, 1
    INT 10h

    INC DH
    MOV DL, 4
    CALL SET_CURSOR
    MOV AL, 0C0h
    MOV CX, 1
    INT 10h

    MOV DL, 5
    CALL SET_CURSOR
    MOV AL, 0C4h
    MOV CX, 70
    INT 10h

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0D9h
    MOV CX, 1
    INT 10h

    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_MENU_BOX ENDP

READ_AND_VALIDATE_KEY PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    MOV AH, 00h
    INT 16h

    CMP AL, 20h
    JB CHECK_EMPTY_ERR
    MOV AH, 09h
    MOV BH, 00h
    MOV BL, 0Bh
    MOV CX, 1
    INT 10h

CHECK_EMPTY_ERR:
    CMP AL, 0Dh
    JE HANDLE_EMPTY_ERR
    CMP AL, 20h
    JE HANDLE_EMPTY_ERR
    CMP AL, 1Bh
    JE HANDLE_EMPTY_ERR

    CMP AL, '1'
    JB HANDLE_RANGE_ERR
    CMP AL, '4'
    JA HANDLE_RANGE_ERR

    MOV [USER_CHOICE], AL
    MOV DH, 24
    MOV DL, 4
    MOV BL, 07h
    LEA SI, CLEAR_MSG_STR
    CALL PRINT_COLOR_STR
    MOV AL, [USER_CHOICE]
    JMP VALIDATE_DONE

HANDLE_EMPTY_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch
    LEA SI, ERR_EMPTY_STR
    CALL PRINT_COLOR_STR
    XOR AL, AL
    JMP VALIDATE_DONE

HANDLE_RANGE_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch
    LEA SI, ERR_RANGE_STR
    CALL PRINT_COLOR_STR
    XOR AL, AL

VALIDATE_DONE:
    POP SI
    POP DX
    POP CX
    POP BX
    RET
READ_AND_VALIDATE_KEY ENDP

CLEAR_FULL_SCREEN PROC
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
CLEAR_FULL_SCREEN ENDP

SET_CURSOR PROC
    PUSH AX
    PUSH BX
    MOV AH, 02h
    MOV BH, 00h
    INT 10h
    POP BX
    POP AX
    RET
SET_CURSOR ENDP

PRINT_COLOR_STR PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

NEXT_CHAR:
    MOV AL, [SI]
    CMP AL, 0
    JE STR_DONE

    CALL SET_CURSOR
    MOV AH, 09h
    MOV BH, 00h
    MOV CX, 1
    INT 10h

    INC SI
    INC DL
    JMP NEXT_CHAR

STR_DONE:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_COLOR_STR ENDP

END MAIN