.MODEL SMALL
.STACK 100h                 ; 100h: Allocate 256 bytes for stack segment

.DATA
    BOX_ROWS        DB 7, 11, 15, 19     ; i brought those
    BOX_COUNT       EQU 4                ; three lines
    USER_CHOICE     DB 0                 ; here to prevent first data letter null (000h) offset
    m_a db ".-",0                        
    m_b db "-...",0
    m_c db "-.-.",0
    m_d db "-..",0
    m_e db ".",0
    m_f db "..-.",0
    m_g db "--.",0
    m_h db "....",0
    m_i db "..",0
    m_j db ".---",0
    m_k db "-.-",0
    m_l db ".-..",0
    m_m db "--",0
    m_n db "-.",0
    m_o db "---",0
    m_p db ".--.",0
    m_q db "--.-",0
    m_r db ".-.",0
    m_s db "...",0
    m_t db "-",0
    m_u db "..-",0
    m_v db "...-",0
    m_w db ".--",0
    m_x db "-..-",0
    m_y db "-.--",0
    m_z db "--..",0
    m_0 db "-----",0
    m_1 db ".----",0
    m_2 db "..---",0
    m_3 db "...--",0
    m_4 db "....-",0
    m_5 db ".....",0
    m_6 db "-....",0
    m_7 db "--...",0
    m_8 db "---..",0
    m_9 db "----.",0

    m_period      db ".-.-.-",0
    m_comma       db "--..--",0
    m_query       db "..--..",0
    m_slash       db "-..-.",0
    m_colon       db "---...",0
    m_apostrophe  db ".----.",0
    m_hyphen      db "-....-",0
    m_bracketO    db "-.--.",0
    m_bracketC    db "-.--.-",0
    m_quotation   db ".-..-.",0
    m_equal       db "-...-",0
    m_plus        db ".-.-.",0
    m_atsign      db ".--.-.",0
    m_exclamation db "-.-.--",0
    m_ampersend   db ".-...",0
    m_semicolon   db "-.-.-.",0
    m_underscore  db "..--.-",0
    m_dollarSign  db "...-..-",0

    MORSE_CODE dw 33 dup(0)
        dw offset m_exclamation
        dw offset m_quotation
        dw 0
        dw offset m_dollarSign
        dw 0
        dw offset m_ampersend
        dw offset m_apostrophe
        dw offset m_bracketO
        dw offset m_bracketC
        dw 0
        dw offset m_plus
        dw offset m_comma
        dw offset m_hyphen
        dw offset m_period
        dw offset m_slash
        dw offset m_0
        dw offset m_1
        dw offset m_2
        dw offset m_3
        dw offset m_4
        dw offset m_5
        dw offset m_6
        dw offset m_7
        dw offset m_8
        dw offset m_9
        dw offset m_colon
        dw offset m_semicolon
        dw 0
        dw offset m_equal
        dw 0
        dw offset m_query
        dw offset m_atsign
        dw offset m_a
        dw offset m_b
        dw offset m_c
        dw offset m_d
        dw offset m_e
        dw offset m_f
        dw offset m_g
        dw offset m_h
        dw offset m_i
        dw offset m_j
        dw offset m_k
        dw offset m_l
        dw offset m_m
        dw offset m_n
        dw offset m_o
        dw offset m_p
        dw offset m_q
        dw offset m_r
        dw offset m_s
        dw offset m_t
        dw offset m_u
        dw offset m_v
        dw offset m_w
        dw offset m_x
        dw offset m_y
        dw offset m_z
        dw 4 dup(0)
        dw offset m_underscore
        dw 0
        dw offset m_a
        dw offset m_b
        dw offset m_c
        dw offset m_d
        dw offset m_e
        dw offset m_f
        dw offset m_g
        dw offset m_h
        dw offset m_i
        dw offset m_j
        dw offset m_k
        dw offset m_l
        dw offset m_m
        dw offset m_n
        dw offset m_o
        dw offset m_p
        dw offset m_q
        dw offset m_r
        dw offset m_s
        dw offset m_t
        dw offset m_u
        dw offset m_v
        dw offset m_w
        dw offset m_x
        dw offset m_y
        dw offset m_z
        dw 5 dup(0)

    

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

    M2C_HEADER_STR  DB 'Morse to Text (Use . - Space, and / between words):', 0
    MORSE_IN_LBL    DB 'Morse: ', 0
    TEXT_OUT_LBL    DB 'Text : ', 0

    STAT_CHAR_LBL   DB 'Characters: ', 0
    STAT_WORD_LBL   DB 'Words: ', 0
    STAT_DOT_LBL    DB 'Dots: ', 0
    STAT_DASH_LBL   DB 'Dashes: ', 0

    M2C_CONT_STR    DB 'Press R to translate again, or any key for Menu: ', 0
    M2C_ERR_EMPTY   DB 'Error 1: Empty input! Type Morse code (. or -) first.', 0
    M2C_ERR_KEY     DB 'Error 2: Invalid key! Use only . - / and Space.      ', 0
    M2C_ERR_FULL    DB 'Error 3: Input full (max 60)! Press Enter to decode. ', 0

    MORSE_INPUT_BUF DB 61 DUP(0)
    TEXT_OUTPUT_BUF DB 61 DUP(0)
    TOKEN_BUF       DB 10 DUP(0)

    INPUT_LEN       DW 0
    CHAR_COUNT      DW 0
    WORD_COUNT      DW 0
    DOT_COUNT       DW 0
    DASH_COUNT      DW 0
    IN_WORD_FLAG    DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 00h                 ; 00h: BIOS function to set video mode
    MOV AL, 03h                 ; 03h: 80x25 16-color text mode
    INT 10h                     ; 10h: BIOS video interrupt

MAIN_MENU_START:
    CALL DRAW_MAIN_GUI

PROMPT_LOOP:
    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray text attribute
    LEA SI, PROMPT_STR
    CALL PRINT_COLOR_STR

    MOV DH, 23
    MOV DL, 23
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV AL, ' '
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 0Bh                 ; 0Bh: Light cyan text attribute
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt
    CALL SET_CURSOR

    CALL READ_AND_VALIDATE_KEY
    CMP AL, 00h                 ; 00h: Invalid key indicator from validation
    JE PROMPT_LOOP

    CMP AL, '2'
    JE RUN_OPTION_2
    CMP AL, '3'
    JE MAIN_MENU_START
    CMP AL, '4'
    JE EXIT_PROGRAM

    CALL CLEAR_FULL_SCREEN
    MOV DH, 12
    MOV DL, 22
    MOV BL, 0Bh                 ; 0Bh: Light cyan text attribute
    LEA SI, EMPTY_IMPL_STR
    CALL PRINT_COLOR_STR
    JMP EXIT_PROGRAM

RUN_OPTION_2:
    CALL MORSE_TO_TEXT_SCREEN
    JMP MAIN_MENU_START

EXIT_PROGRAM:
    MOV AH, 4Ch                 ; 4Ch: DOS terminate program function
    MOV AL, 00h                 ; 00h: Return code 0
    INT 21h                     ; 21h: DOS system interrupt
MAIN ENDP

MORSE_TO_TEXT_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

M2C_RESTART:
    CALL DRAW_M2C_INTERFACE
    CALL READ_MORSE_INPUT
    CALL COUNT_DOTS_AND_DASHES
    CALL TRANSLATE_MORSE_BUFFER
    CALL DISPLAY_M2C_RESULTS

    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray text on black background
    LEA SI, M2C_CONT_STR
    CALL PRINT_COLOR_STR

    MOV AH, 00h                 ; 00h: BIOS keyboard function to read keystroke
    INT 16h                     ; 16h: BIOS keyboard interrupt

    CMP AL, 'R'
    JE M2C_RESTART
    CMP AL, 'r'
    JE M2C_RESTART

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
MORSE_TO_TEXT_SCREEN ENDP

DRAW_M2C_INTERFACE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    CALL CLEAR_FULL_SCREEN

    MOV DH, 1
    MOV DL, 29
    MOV BL, 0Bh                 ; 0Bh: Light cyan text attribute
    LEA SI, TITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 2
    MOV DL, 29
    MOV BL, 07h                 ; 07h: Light gray text attribute
    LEA SI, SUBTITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 3
    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS function to write character and attribute
    MOV AL, 0C4h                ; 0C4h: Box-drawing horizontal line character
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 08h                 ; 08h: Dark gray attribute
    MOV CX, 72
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DH, 5
    MOV DL, 4
    MOV BL, 09h                 ; 09h: Light blue text attribute
    LEA SI, M2C_HEADER_STR
    CALL PRINT_COLOR_STR

    MOV DH, 7
    CALL DRAW_MENU_BOX
    MOV DH, 8
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, MORSE_IN_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 11
    CALL DRAW_MENU_BOX
    MOV DH, 12
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, TEXT_OUT_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 15
    CALL DRAW_MENU_BOX
    MOV DH, 16
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, STAT_CHAR_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 25
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, STAT_WORD_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 39
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, STAT_DOT_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 52
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, STAT_DASH_LBL
    CALL PRINT_COLOR_STR

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_M2C_INTERFACE ENDP

READ_MORSE_INPUT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    MOV [INPUT_LEN], 00h        ; 00h: Initialize input length to zero

READ_KEY_LOOP:
    MOV AX, [INPUT_LEN]
    MOV DH, 8
    MOV DL, 13
    ADD DL, AL
    CALL SET_CURSOR

    MOV AH, 00h                 ; 00h: BIOS function to wait for and read key
    INT 16h                     ; 16h: BIOS keyboard interrupt

    CMP AL, 0Dh                 ; 0Dh: ASCII Carriage Return (Enter key)
    JE HANDLE_ENTER_KEY

    CMP AL, 08h                 ; 08h: ASCII Backspace key
    JE HANDLE_BACKSPACE_KEY

    CMP AL, '.'
    JE VALID_MORSE_CHAR
    CMP AL, '-'
    JE VALID_MORSE_CHAR
    CMP AL, ' '
    JE VALID_MORSE_CHAR
    CMP AL, '/'
    JE VALID_MORSE_CHAR

    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for error message
    LEA SI, M2C_ERR_KEY
    CALL PRINT_COLOR_STR
    JMP READ_KEY_LOOP

VALID_MORSE_CHAR:
    CMP [INPUT_LEN], 60
    JAE HANDLE_BUFFER_FULL

    MOV SI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[SI], AL

    MOV DH, 8
    MOV DL, 13
    MOV CX, [INPUT_LEN]
    ADD DL, CL
    CALL SET_CURSOR

    MOV AH, 09h                 ; 09h: BIOS write character and attribute at cursor
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    INC [INPUT_LEN]

    MOV DH, 24
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray attribute to clear error row
    LEA SI, CLEAR_MSG_STR
    CALL PRINT_COLOR_STR
    JMP READ_KEY_LOOP

HANDLE_BACKSPACE_KEY:
    CMP [INPUT_LEN], 00h        ; 00h: Check if buffer is already empty
    JE READ_KEY_LOOP

    DEC [INPUT_LEN]
    MOV AX, [INPUT_LEN]
    MOV DH, 8
    MOV DL, 13
    ADD DL, AL
    CALL SET_CURSOR

    MOV AH, 09h                 ; 09h: BIOS write character and attribute at cursor
    MOV AL, ' '
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 1Bh                 ; 1Bh: Keep blue box background when erasing char
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DH, 24
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray attribute to clear error row
    LEA SI, CLEAR_MSG_STR
    CALL PRINT_COLOR_STR
    JMP READ_KEY_LOOP

HANDLE_BUFFER_FULL:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for overflow error
    LEA SI, M2C_ERR_FULL
    CALL PRINT_COLOR_STR
    JMP READ_KEY_LOOP

HANDLE_ENTER_KEY:
    CMP [INPUT_LEN], 00h        ; 00h: Reject Enter if no characters were typed
    JE SHOW_EMPTY_MORSE_ERR

    MOV SI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[SI], 00h ; 00h: Null-terminate the input string

    MOV DH, 24
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray attribute to clear error row
    LEA SI, CLEAR_MSG_STR
    CALL PRINT_COLOR_STR

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET

SHOW_EMPTY_MORSE_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for empty input error
    LEA SI, M2C_ERR_EMPTY
    CALL PRINT_COLOR_STR
    JMP READ_KEY_LOOP
READ_MORSE_INPUT ENDP

COUNT_DOTS_AND_DASHES PROC
    PUSH AX
    PUSH SI

    MOV [DOT_COUNT], 00h        ; 00h: Reset dot counter to zero
    MOV [DASH_COUNT], 00h       ; 00h: Reset dash counter to zero
    LEA SI, MORSE_INPUT_BUF

SCAN_SYMBOLS_LOOP:
    MOV AL, [SI]
    CMP AL, 00h                 ; 00h: Check for null terminator
    JE SCAN_SYMBOLS_DONE

    CMP AL, '.'
    JE COUNT_ONE_DOT
    CMP AL, '-'
    JE COUNT_ONE_DASH
    JMP NEXT_SYMBOL_CHAR

COUNT_ONE_DOT:
    INC [DOT_COUNT]
    JMP NEXT_SYMBOL_CHAR

COUNT_ONE_DASH:
    INC [DASH_COUNT]

NEXT_SYMBOL_CHAR:
    INC SI
    JMP SCAN_SYMBOLS_LOOP

SCAN_SYMBOLS_DONE:
    POP SI
    POP AX
    RET
COUNT_DOTS_AND_DASHES ENDP

TRANSLATE_MORSE_BUFFER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    MOV [CHAR_COUNT], 00h       ; 00h: Reset decoded character counter
    MOV [WORD_COUNT], 00h       ; 00h: Reset decoded word counter
    MOV [IN_WORD_FLAG], 00h     ; 00h: Reset active word state flag

    LEA SI, MORSE_INPUT_BUF
    LEA DI, TEXT_OUTPUT_BUF

PARSE_NEXT_TOKEN:
    MOV AL, [SI]
    CMP AL, 00h                 ; 00h: Check for end of input buffer
    JE TRANSLATE_FINISH

    CMP AL, ' '
    JNE CHECK_WORD_SLASH
    INC SI
    JMP PARSE_NEXT_TOKEN

CHECK_WORD_SLASH:
    CMP AL, '/'
    JNE EXTRACT_MORSE_LETTER
    INC SI
    CMP [IN_WORD_FLAG], 00h     ; 00h: Only output space if a word preceded slash
    JE PARSE_NEXT_TOKEN
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV [IN_WORD_FLAG], 00h     ; 00h: Mark that we are now between words
    JMP PARSE_NEXT_TOKEN

EXTRACT_MORSE_LETTER:
    XOR BX, BX

COPY_TOKEN_CHARS:
    MOV AL, [SI]
    CMP AL, 00h                 ; 00h: Stop token at null terminator
    JE END_TOKEN_EXTRACTION
    CMP AL, ' '
    JE END_TOKEN_EXTRACTION
    CMP AL, '/'
    JE END_TOKEN_EXTRACTION

    CMP BX, 08h                 ; 08h: Prevent overflow of 10-byte token buffer
    JAE SKIP_EXTRA_TOKEN_CHAR
    MOV TOKEN_BUF[BX], AL
    INC BX

SKIP_EXTRA_TOKEN_CHAR:
    INC SI
    JMP COPY_TOKEN_CHARS

END_TOKEN_EXTRACTION:
    MOV TOKEN_BUF[BX], 00h      ; 00h: Null-terminate extracted Morse token
    CALL DECODE_MORSE_TOKEN
    MOV [DI], AL
    INC DI
    INC [CHAR_COUNT]

    CMP [IN_WORD_FLAG], 00h     ; 00h: Check if this letter starts a new word
    JNE PARSE_NEXT_TOKEN
    INC [WORD_COUNT]
    MOV [IN_WORD_FLAG], 01h     ; 01h: Set flag indicating we are inside a word
    JMP PARSE_NEXT_TOKEN

TRANSLATE_FINISH:
    MOV BYTE PTR [DI], 00h      ; 00h: Null-terminate decoded output string

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
TRANSLATE_MORSE_BUFFER ENDP

DECODE_MORSE_TOKEN PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    MOV CX, 21h                 ; 21h: ASCII 33 ('!'), first valid index in LUT
    MOV BX, 42h                 ; 42h: Byte offset for index 33 (33 * 2 = 66 = 42h)

SEARCH_LUT_LOOP:
    MOV DI, MORSE_CODE[BX]
    CMP DI, 00h                 ; 00h: Skip empty LUT slots that have pointer 0
    JE NEXT_LUT_ENTRY

    LEA SI, TOKEN_BUF

COMPARE_TOKEN_LOOP:
    MOV AL, [SI]
    MOV DL, [DI]
    CMP AL, DL
    JNE NEXT_LUT_ENTRY
    CMP AL, 00h                 ; 00h: Both strings hit null terminator (match)
    JE LUT_MATCH_FOUND
    INC SI
    INC DI
    JMP COMPARE_TOKEN_LOOP

NEXT_LUT_ENTRY:
    ADD BX, 02h                 ; 02h: Advance by 2 bytes to next word pointer
    INC CX
    CMP CX, 5Fh                 ; 5Fh: ASCII 95 ('_'), last unique entry in LUT
    JBE SEARCH_LUT_LOOP

    MOV AL, '?'
    JMP DECODE_TOKEN_DONE

LUT_MATCH_FOUND:
    MOV AL, CL

DECODE_TOKEN_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET
DECODE_MORSE_TOKEN ENDP

DISPLAY_M2C_RESULTS PROC
    PUSH AX
    PUSH BX
    PUSH DX
    PUSH SI

    MOV DH, 12
    MOV DL, 13
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, TEXT_OUTPUT_BUF
    CALL PRINT_COLOR_STR

    MOV AX, [CHAR_COUNT]
    MOV DH, 16
    MOV DL, 18
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    CALL PRINT_NUMBER

    MOV AX, [WORD_COUNT]
    MOV DH, 16
    MOV DL, 32
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    CALL PRINT_NUMBER

    MOV AX, [DOT_COUNT]
    MOV DH, 16
    MOV DL, 45
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    CALL PRINT_NUMBER

    MOV AX, [DASH_COUNT]
    MOV DH, 16
    MOV DL, 60
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    CALL PRINT_NUMBER

    POP SI
    POP DX
    POP BX
    POP AX
    RET
DISPLAY_M2C_RESULTS ENDP

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH BP

    MOV BP, DX
    XOR CX, CX
    MOV DI, 10

DIVIDE_NUM_LOOP:
    XOR DX, DX
    DIV DI
    ADD DL, '0'
    PUSH DX
    INC CX
    CMP AX, 00h                 ; 00h: Check if quotient reached zero
    JNE DIVIDE_NUM_LOOP

    MOV DX, BP

PRINT_DIGIT_LOOP:
    POP AX
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV BH, 00h                 ; 00h: Video page 0
    PUSH CX
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt
    POP CX
    INC DL
    LOOP PRINT_DIGIT_LOOP

    POP BP
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

DRAW_MAIN_GUI PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    CALL CLEAR_FULL_SCREEN

    MOV DH, 1
    MOV DL, 29
    MOV BL, 0Bh                 ; 0Bh: Light cyan text attribute
    LEA SI, TITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 2
    MOV DL, 29
    MOV BL, 07h                 ; 07h: Light gray text attribute
    LEA SI, SUBTITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 3
    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV AL, 0C4h                ; 0C4h: Box-drawing horizontal line character
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 08h                 ; 08h: Dark gray text attribute
    MOV CX, 72
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DH, 5
    MOV DL, 4
    MOV BL, 09h                 ; 09h: Light blue text attribute
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
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, OPT1_STR
    CALL PRINT_COLOR_STR

    MOV DH, 12
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, OPT2_STR
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
    LEA SI, OPT3_STR
    CALL PRINT_COLOR_STR

    MOV DH, 20
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Light cyan text on blue box background
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

    MOV AH, 06h                 ; 06h: BIOS scroll/clear window function
    MOV AL, 00h                 ; 00h: Clear entire window area
    MOV BH, 19h                 ; 19h: Blue background with light blue border color
    MOV CH, DH
    MOV CL, 4
    MOV DL, 75
    ADD DH, 2
    INT 10h                     ; 10h: BIOS video interrupt
    SUB DH, 2

    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV AL, 0DAh                ; 0DAh: Box-drawing top-left corner character
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 19h                 ; 19h: Blue background with light blue foreground
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DL, 5
    CALL SET_CURSOR
    MOV AL, 0C4h                ; 0C4h: Box-drawing horizontal line character
    MOV CX, 70
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0BFh                ; 0BFh: Box-drawing top-right corner character
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    INC DH
    MOV DL, 4
    CALL SET_CURSOR
    MOV AL, 0B3h                ; 0B3h: Box-drawing vertical line character
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0B3h                ; 0B3h: Box-drawing vertical line character
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    INC DH
    MOV DL, 4
    CALL SET_CURSOR
    MOV AL, 0C0h                ; 0C0h: Box-drawing bottom-left corner character
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DL, 5
    CALL SET_CURSOR
    MOV AL, 0C4h                ; 0C4h: Box-drawing horizontal line character
    MOV CX, 70
    INT 10h                     ; 10h: BIOS video interrupt

    MOV DL, 75
    CALL SET_CURSOR
    MOV AL, 0D9h                ; 0D9h: Box-drawing bottom-right corner character
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

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

    MOV AH, 00h                 ; 00h: BIOS read keystroke function
    INT 16h                     ; 16h: BIOS keyboard interrupt

    CMP AL, 20h                 ; 20h: ASCII Space (lowest printable char)
    JB CHECK_EMPTY_ERR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 0Bh                 ; 0Bh: Light cyan text attribute
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

CHECK_EMPTY_ERR:
    CMP AL, 0Dh                 ; 0Dh: ASCII Enter key
    JE HANDLE_EMPTY_ERR
    CMP AL, 20h                 ; 20h: ASCII Space key
    JE HANDLE_EMPTY_ERR
    CMP AL, 1Bh                 ; 1Bh: ASCII Escape key
    JE HANDLE_EMPTY_ERR

    CMP AL, '1'
    JB HANDLE_RANGE_ERR
    CMP AL, '4'
    JA HANDLE_RANGE_ERR

    MOV [USER_CHOICE], AL
    MOV DH, 24
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray attribute to clear error row
    LEA SI, CLEAR_MSG_STR
    CALL PRINT_COLOR_STR
    MOV AL, [USER_CHOICE]
    JMP VALIDATE_DONE

HANDLE_EMPTY_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for error message
    LEA SI, ERR_EMPTY_STR
    CALL PRINT_COLOR_STR
    XOR AL, AL
    JMP VALIDATE_DONE

HANDLE_RANGE_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for error message
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
    MOV AH, 06h                 ; 06h: BIOS scroll/clear window function
    MOV AL, 00h                 ; 00h: Clear entire window
    MOV BH, 07h                 ; 07h: Light gray text on black background
    MOV CX, 0000h               ; 0000h: Top-left corner (Row 0, Col 0)
    MOV DX, 184Fh               ; 184Fh: Bottom-right corner (Row 24, Col 79)
    INT 10h                     ; 10h: BIOS video interrupt
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CLEAR_FULL_SCREEN ENDP

SET_CURSOR PROC
    PUSH AX
    PUSH BX
    MOV AH, 02h                 ; 02h: BIOS set cursor position function
    MOV BH, 00h                 ; 00h: Video page 0
    INT 10h                     ; 10h: BIOS video interrupt
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
    CMP AL, 00h                 ; 00h: Check for null string terminator
    JE STR_DONE

    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV BH, 00h                 ; 00h: Video page 0
    MOV CX, 1
    INT 10h                     ; 10h: BIOS video interrupt

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