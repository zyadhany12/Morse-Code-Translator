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

    MORSE_TREE DB 0, 0
               DB 'E', 'T'
               DB 'I', 'A', 'N', 'M'
               DB 'S', 'U', 'R', 'W', 'D', 'K', 'G', 'O'
               DB 'H', 'V', 'F', 0,   'L', 0,   'P', 'J'
               DB 'B', 'X', 'C', 'Y', 'Z', 'Q', 0,   0
               DB '5', '4', 0,   '3', 0,   0,   0,   '2'
               DB '&', 0,   '+', 0,   0,   0,   0,   '1'
               DB '6', '=', '/', 0,   0,   0,   '(', 0
               DB '7', 0,   0,   0,   '8', 0,   '9', '0'
               DB 8 DUP(0)
               DB 0,   0,   0,   0,   '?', '_', 0,   0
               DB 0,   0,   '"', 0,   0,   '.', 0,   0
               DB 0,   0,   '@', 0,   0,   0,   27h, 0
               DB 0,   '-', 0,   0,   0,   0,   0,   0
               DB 0,   0,   ';', '!', 0,   ')', 0,   0
               DB 0,   0,   0,   ',', 0,   0,   0,   0
               DB ':', 7 DUP(0)
               DB 8 DUP(0)
               DB 0,   '$', 6 DUP(0)
               DB 112 DUP(0)

    INPUT_LEN       DW 0
    CHAR_COUNT      DW 0
    WORD_COUNT      DW 0
    DOT_COUNT       DW 0
    DASH_COUNT      DW 0
    IN_WORD_FLAG    DB 0
    HAS_ERROR       DB 0    
    
    TEXT_INPUT_BUF   DB 61 DUP(0)
    MORSE_OUTPUT_BUF DB 512 DUP(0)

    TEXT_INPUT_LEN   DW 0
    MORSE_OUTPUT_LEN DW 0

    T2M_HEADER_STR  DB 'Text to Morse Code:', 0
    TEXT_IN_LBL     DB 'Text : ', 0
    MORSE_OUT_LBL   DB 'Morse: ', 0         
    
    T2M_CONT_STR    DB 'Press R to translate again, or any key to go back to menu: ', 0

    T2M_ERR_EMPTY   DB 'Error: Empty input! Please enter some text.          ', 0
    T2M_ERR_FULL    DB 'Error: Input full (max 60 characters)!               ', 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 00h                 ; 00h: BIOS function to set video mode
    MOV AL, 03h                 ; 03h: 80x25 16-color text mode
    INT 10h                     ; 10h: BIOS video interrupt

MAIN_MENU_START:
    CALL DRAW_MAIN_GUI

    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h                 ; 07h: Light gray text attribute
    LEA SI, PROMPT_STR
    CALL PRINT_COLOR_STR

PROMPT_LOOP:
    MOV AX, 0B800h
    MOV ES, AX
    MOV WORD PTR ES:[3726], 0B20h

    MOV DH, 23
    MOV DL, 23
    CALL SET_CURSOR

    CALL READ_AND_VALIDATE_KEY
    CMP AL, 00h                 ; 00h: Invalid key indicator from validation
    JE PROMPT_LOOP
    
    CMP AL, '1'
    JE RUN_OPTION_1
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

RUN_OPTION_1:
    CALL TEXT_TO_MORSE_SCREEN
    JMP MAIN_MENU_START

RUN_OPTION_2:
    CALL MORSE_TO_TEXT_SCREEN
    JMP MAIN_MENU_START

EXIT_PROGRAM:
    MOV AH, 4Ch                 ; 4Ch: DOS terminate program function
    MOV AL, 00h                 ; 00h: Return code 0
    INT 21h                     ; 21h: DOS system interrupt
MAIN ENDP

DELAY PROC 
             
    PUSH Bx  ;Bx is the multiplier that will be used to differentiate the time between the dot and dash
             ;Set Bx before Calling Delay. for ex, if a dash takes 500ms delay then 500x1 => Set Bx to 500
             
    PUSH Cx
    
    Loop1:
    mov Cx, 2 
    ; 250 iteration of 20 clk cycles = 1ms
    ; 8086 runs at 5MHz
    ; to calculate no. iterations => (req_time/Time_per_cycle) => 1000microS/4microS => 250 
    
    Loop2:
    NOP       ; no operation: does nothing but Takes three Cycles to execute
    loop Loop2
    
    Dec Bx
    jnz loop1 
    
    Pop Cx
    Pop Bx
    
    ret 
DELAY ENDP


MORSE_TO_TEXT_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

M2C_RESTART:
    CALL DRAW_M2C_INTERFACE
    CALL READ_MORSE_INPUT
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
    PUSH DI
    PUSH SI
    PUSH ES

    MOV AX, 0B800h
    MOV ES, AX
    MOV [INPUT_LEN], 00h
    MOV [HAS_ERROR], 00h

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
    MOV [HAS_ERROR], 01h
    JMP READ_KEY_LOOP

VALID_MORSE_CHAR:
    CMP [INPUT_LEN], 60
    JAE HANDLE_BUFFER_FULL

    MOV DI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[DI], AL

    ADD DI, 653
    SHL DI, 1
    MOV AH, 1Bh
    MOV ES:[DI], AX

    INC [INPUT_LEN]
    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_KEY_LOOP

HANDLE_BACKSPACE_KEY:
    CMP [INPUT_LEN], 00h        ; 00h: Check if buffer is already empty
    JE READ_KEY_LOOP

    DEC [INPUT_LEN]
    MOV DI, [INPUT_LEN]
    ADD DI, 653
    SHL DI, 1
    MOV WORD PTR ES:[DI], 1B20h

    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_KEY_LOOP

HANDLE_BUFFER_FULL:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light red attribute for overflow error
    LEA SI, M2C_ERR_FULL
    CALL PRINT_COLOR_STR
    MOV [HAS_ERROR], 01h
    JMP READ_KEY_LOOP

HANDLE_ENTER_KEY:
    CMP [INPUT_LEN], 00h        ; 00h: Reject Enter if no characters were typed
    JE SHOW_EMPTY_MORSE_ERR

    MOV SI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[SI], 00h ; 00h: Null-terminate the input string
    CALL CLEAR_ERR_IF_NEEDED

    POP ES
    POP SI
    POP DI
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
    MOV [HAS_ERROR], 01h
    JMP READ_KEY_LOOP
READ_MORSE_INPUT ENDP

CLEAR_ERR_IF_NEEDED PROC
    CMP [HAS_ERROR], 00h
    JE SKIP_ERR_CLEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 07h
    MOV CX, 1804h
    MOV DX, 183Ah
    INT 10h
    MOV [HAS_ERROR], 00h
    POP DX
    POP CX
    POP BX
    POP AX
SKIP_ERR_CLEAR:
    RET
CLEAR_ERR_IF_NEEDED ENDP

TRANSLATE_MORSE_BUFFER PROC
    PUSH AX
    PUSH BX
    PUSH SI
    PUSH DI

    MOV [CHAR_COUNT], 00h       ; 00h: Reset decoded character counter
    MOV [WORD_COUNT], 00h       ; 00h: Reset decoded word counter
    MOV [DOT_COUNT], 00h
    MOV [DASH_COUNT], 00h
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
    JNE DECODE_NEXT_LETTER
    INC SI
    CMP [IN_WORD_FLAG], 00h     ; 00h: Only output space if a word preceded slash
    JE PARSE_NEXT_TOKEN
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV [IN_WORD_FLAG], 00h     ; 00h: Mark that we are now between words
    JMP PARSE_NEXT_TOKEN

DECODE_NEXT_LETTER:
    MOV BX, 1

BUILD_TREE_INDEX:
    MOV AL, [SI]
    CMP AL, 00h
    JE FINISH_LETTER
    CMP AL, ' '
    JE FINISH_LETTER
    CMP AL, '/'
    JE FINISH_LETTER

    INC SI
    CMP AL, '.'
    JE STEP_DOT

    INC [DASH_COUNT]
    SHL BX, 1
    INC BX
    JMP CHECK_TREE_BOUNDS

STEP_DOT:
    INC [DOT_COUNT]
    SHL BX, 1

CHECK_TREE_BOUNDS:
    CMP BX, 255
    JBE BUILD_TREE_INDEX
    MOV BX, 255
    JMP BUILD_TREE_INDEX

FINISH_LETTER:
    MOV AL, MORSE_TREE[BX]
    CMP AL, 00h
    JNE STORE_DECODED_CHAR
    MOV AL, '?'

STORE_DECODED_CHAR:
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
    POP BX
    POP AX
    RET
TRANSLATE_MORSE_BUFFER ENDP

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
    PUSH SI
    PUSH ES

    MOV CX, 0B800h
    MOV ES, CX

    PUSH AX
    MOV AL, 160
    MUL DH
    XOR DH, DH
    SHL DX, 1
    ADD AX, DX
    MOV DI, AX
    POP AX

    XOR CX, CX
    MOV SI, 10

DIVIDE_NUM_LOOP:
    XOR DX, DX
    DIV SI
    ADD DL, '0'
    PUSH DX
    INC CX
    CMP AX, 00h                 ; 00h: Check if quotient reached zero
    JNE DIVIDE_NUM_LOOP

    MOV AH, BL
    CLD
PRINT_DIGIT_LOOP:
    POP DX
    MOV AL, DL
    STOSW
    LOOP PRINT_DIGIT_LOOP

    POP ES
    POP SI
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
    PUSH DI
    PUSH ES

    MOV AH, 06h                 ; 06h: BIOS scroll/clear window function
    MOV AL, 00h                 ; 00h: Clear entire window area
    MOV BH, 19h                 ; 19h: Blue background with light blue border color
    MOV CH, DH
    MOV CL, 4
    MOV DL, 75
    ADD DH, 2
    INT 10h                     ; 10h: BIOS video interrupt
    SUB DH, 2

    MOV DL, 5
    CALL SET_CURSOR
    MOV AH, 09h                 ; 09h: BIOS write character and attribute
    MOV AL, 0C4h                ; 0C4h: Box-drawing horizontal line character
    MOV BH, 00h                 ; 00h: Video page 0
    MOV BL, 19h                 ; 19h: Blue background with light blue foreground
    MOV CX, 70
    INT 10h                     ; 10h: BIOS video interrupt

    ADD DH, 2
    CALL SET_CURSOR
    INT 10h                     ; 10h: BIOS video interrupt
    SUB DH, 2

    MOV AX, 0B800h
    MOV ES, AX
    MOV AL, 160
    MUL DH
    MOV DI, AX

    MOV WORD PTR ES:[DI+8],   19DAh
    MOV WORD PTR ES:[DI+150], 19BFh
    MOV WORD PTR ES:[DI+168], 19B3h
    MOV WORD PTR ES:[DI+310], 19B3h
    MOV WORD PTR ES:[DI+328], 19C0h
    MOV WORD PTR ES:[DI+470], 19D9h

    POP ES
    POP DI
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
    CMP AL, 20h
    JB SKIP_BAD_ECHO
    PUSH AX
    MOV AX, 0B800h
    MOV ES, AX
    POP AX
    MOV AH, 0Bh
    MOV ES:[3726], AX
SKIP_BAD_ECHO:
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
    PUSH DX
    PUSH DI
    PUSH SI
    PUSH ES

    MOV AX, 0B800h
    MOV ES, AX                  ; Point ES to VGA text video memory

    MOV AL, 160
    MUL DH
    XOR DH, DH
    SHL DX, 1
    ADD AX, DX
    MOV DI, AX

    MOV AH, BL                  ; Put color attribute in high byte
    CLD
VRAM_LOOP:
    LODSB                       ; Load next char from DS:SI into AL and increment SI
    CMP AL, 00h                 ; Check for null terminator
    JE VRAM_DONE
    STOSW                       ; Write AX (Attr:Char) to ES:DI and advance DI by 2
    JMP VRAM_LOOP

VRAM_DONE:
    POP ES
    POP SI
    POP DI
    POP DX
    POP BX
    POP AX
    RET
PRINT_COLOR_STR ENDP    
                             
TEXT_TO_MORSE_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    T2M_RESTART:
        CALL CLEAR_FULL_SCREEN
        
        MOV DH, 1
        MOV DL, 29
        MOV BL, 0BH
        LEA SI, TITLE_STR
        CALL PRINT_COLOR_STR
        
        MOV DH, 2
        MOV DL, 29
        MOV BL, 07H
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
        LEA SI, T2M_HEADER_STR
        CALL PRINT_COLOR_STR   
        
        MOV DH, 8
        CALL DRAW_MENU_BOX
        
        MOV DH, 9
        MOV DL, 6
        MOV BL, 1BH
        LEA SI, TEXT_IN_LBL
        CALL PRINT_COLOR_STR
        
        MOV DH, 12
        CALL DRAW_MENU_BOX
        
        MOV DH, 13
        MOV DL, 6
        MOV BL, 1BH
        LEA SI, MORSE_OUT_LBL
        CALL PRINT_COLOR_STR    
        
        MOV DH, 16
        CALL DRAW_MENU_BOX
        
        MOV DH, 17
        MOV DL, 6
        MOV BL, 1BH
        LEA SI, STAT_CHAR_LBL
        CALL PRINT_COLOR_STR    
        
        MOV DH, 17
        MOV DL, 25
        MOV BL, 1BH
        LEA SI, STAT_WORD_LBL
        CALL PRINT_COLOR_STR
        
        MOV DH, 17
        MOV DL, 39
        MOV BL, 1BH
        LEA SI, STAT_DOT_LBL
        CALL PRINT_COLOR_STR
        
        MOV DH, 17
        MOV DL, 52
        MOV BL, 1BH
        LEA SI, STAT_DASH_LBL
        CALL PRINT_COLOR_STR       
        
        CALL READ_TEXT_INPUT
        CALL TRANSLATE_TEXT_BUFFER
        CALL DISPLAY_T2M_RESULT
        CALL VISUALIZE_MORSE
                        
        MOV DH, 23
        MOV DL, 4
        MOV BL, 07h
        LEA SI, T2M_CONT_STR
        CALL PRINT_COLOR_STR
    
        MOV AH, 00H              ;BIOS to read keyboard
        INT 16H                  ;BIOS Keyboard interrupt
        
        CMP AL, 'R'
        JE T2M_RESTART
        
        CMP AL, 'r'
        JE T2M_RESTART
        
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        
        RET
        
TEXT_TO_MORSE_SCREEN ENDP

READ_TEXT_INPUT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH SI
    PUSH ES

    MOV AX, 0B800h
    MOV ES, AX
    MOV [TEXT_INPUT_LEN], 0
    MOV [HAS_ERROR], 0

READ_TEXT_LOOP:
    MOV AX, [TEXT_INPUT_LEN]
    MOV DH, 9
    MOV DL, 13
    ADD DL, AL
    CALL SET_CURSOR

    MOV AH, 00H                  ;BIOS to read keyboard
    INT 16H                      ;BIOS Keyboard interrupt

    CMP AL, 0DH                 ;Checks if ENTER has been pressed
    JE TEXT_ENTER_PRESSED

    CMP AL, 08H                 ;Checks if BACKSPACE has been pressed
    JE TEXT_BACKSPACE

    CMP AL, 20H
    JB READ_TEXT_LOOP

    CMP [TEXT_INPUT_LEN], 60
    JAE TEXT_BUFFER_FULL

    MOV DI, [TEXT_INPUT_LEN]
    MOV TEXT_INPUT_BUF[DI], AL

    ADD DI, 733
    SHL DI, 1
    MOV AH, 1BH
    MOV ES:[DI], AX

    INC [TEXT_INPUT_LEN]
    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_TEXT_LOOP

TEXT_BACKSPACE:
    CMP [TEXT_INPUT_LEN], 0
    JE READ_TEXT_LOOP

    DEC [TEXT_INPUT_LEN]
    MOV DI, [TEXT_INPUT_LEN]
    ADD DI, 733
    SHL DI, 1
    MOV WORD PTR ES:[DI], 1B20h

    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_TEXT_LOOP

TEXT_BUFFER_FULL:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0CH
    LEA SI, T2M_ERR_FULL
    CALL PRINT_COLOR_STR
    MOV [HAS_ERROR], 1
    JMP READ_TEXT_LOOP

TEXT_ENTER_PRESSED:
    CMP [TEXT_INPUT_LEN], 0
    JE TEXT_EMPTY_ERR

    MOV SI, [TEXT_INPUT_LEN]
    MOV TEXT_INPUT_BUF[SI], 0
    CALL CLEAR_ERR_IF_NEEDED

    POP ES
    POP SI
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    RET

TEXT_EMPTY_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0CH
    LEA SI, T2M_ERR_EMPTY
    CALL PRINT_COLOR_STR
    MOV [HAS_ERROR], 1
    JMP READ_TEXT_LOOP
READ_TEXT_INPUT ENDP   

TRANSLATE_TEXT_BUFFER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV [MORSE_OUTPUT_LEN], 0       
    
    MOV [CHAR_COUNT], 0
    MOV [WORD_COUNT], 0
    MOV [DOT_COUNT], 0
    MOV [DASH_COUNT], 0     
    MOV [IN_WORD_FLAG], 0
    
    LEA SI, TEXT_INPUT_BUF
    LEA DI, MORSE_OUTPUT_BUF
    
    TEXT_TRANSLATE_LOOP:
        MOV AL, [SI]
        
        CMP AL, 00H
        JE TEXT_TRANSLATE_DONE
        
        CMP AL, ' '
        JE TEXT_WORD_SPACE
        
        CMP AL, 'a'
        JB TEXT_GET_MORSE
        
        CMP AL, 'z'
        JA TEXT_GET_MORSE
        
        SUB AL, 20H
        
    TEXT_GET_MORSE:
        CMP AL, 127
        JA TEXT_UNKNOWN_CHAR 

        XOR BX, BX
        MOV BL, AL
        
        SHL BX, 1
        
        MOV BX, MORSE_CODE[BX]
        
        CMP BX, 0
        JE TEXT_UNKNOWN_CHAR   
        
        INC [CHAR_COUNT]
        
        CMP [IN_WORD_FLAG], 0
        JNE TEXT_WORD_ALREADY_COUNTED
        
        INC [WORD_COUNT]
        MOV [IN_WORD_FLAG], 1
        
    TEXT_WORD_ALREADY_COUNTED:    
        
    TEXT_COPY_MORSE:
        MOV AL, [BX]
        
        CMP AL, 0
        JE TEXT_MORSE_END       
        
        CMP AL, '.'
        JE COUNT_DOT
        
        CMP AL, '-'
        JE COUNT_DASH    
        
        JMP STORE_MORSE_SYMBOL
                              
    COUNT_DOT:
        INC [DOT_COUNT]
        JMP STORE_MORSE_SYMBOL
        
    COUNT_DASH:
        INC [DASH_COUNT]
                                      
    STORE_MORSE_SYMBOL:
                                   
        MOV [DI], AL
        INC DI
        INC [MORSE_OUTPUT_LEN]
        
        INC BX
        JMP TEXT_COPY_MORSE
        
    TEXT_MORSE_END:
        MOV BYTE PTR [DI], ' '
        INC DI
        INC [MORSE_OUTPUT_LEN]
        
        INC SI
        JMP TEXT_TRANSLATE_LOOP
        
    TEXT_WORD_SPACE:
        CMP DI, OFFSET MORSE_OUTPUT_BUF
        JE TEXT_SKIP_WORD_SPACE
        
        DEC DI
        DEC [MORSE_OUTPUT_LEN]
        
        MOV BYTE PTR [DI], '/'
        INC DI
        INC [MORSE_OUTPUT_LEN]
        
        MOV BYTE PTR [DI], ' '
        INC DI
        INC [MORSE_OUTPUT_LEN]   
        
        MOV [IN_WORD_FLAG], 0       ;Reset the flag when you complete 1 "SPACE"
        
    TEXT_SKIP_WORD_SPACE:
        INC SI
        JMP TEXT_TRANSLATE_LOOP
        
    TEXT_UNKNOWN_CHAR:
        INC SI
        JMP TEXT_TRANSLATE_LOOP
        
    TEXT_TRANSLATE_DONE:
        CMP DI, OFFSET MORSE_OUTPUT_BUF
        JE TEXT_OUTPUT_EMPTY
        
        DEC DI
        
    TEXT_OUTPUT_EMPTY:
        MOV BYTE PTR [DI], 0
        
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        
        RET
        
TRANSLATE_TEXT_BUFFER ENDP 

DISPLAY_T2M_RESULT PROC
    PUSH AX
    PUSH BX
    PUSH DX
    PUSH SI

    MOV DH, 13
    MOV DL, 13
    MOV BL, 1Bh
    LEA SI, MORSE_OUTPUT_BUF
    CALL PRINT_COLOR_STR      
    
    MOV AX, [CHAR_COUNT]
    MOV DH, 17
    MOV DL, 18
    MOV BL, 1BH
    CALL PRINT_NUMBER
    
    MOV AX, [WORD_COUNT]
    MOV DH, 17
    MOV DL, 32
    MOV BL, 1BH
    CALL PRINT_NUMBER
    
    MOV AX, [DOT_COUNT]
    MOV DH, 17
    MOV DL, 45
    MOV BL, 1BH
    CALL PRINT_NUMBER
    
    MOV AX, [DASH_COUNT]
    MOV DH, 17
    MOV DL, 60
    MOV BL, 1BH
    CALL PRINT_NUMBER

    POP SI
    POP DX
    POP BX
    POP AX

    RET
DISPLAY_T2M_RESULT ENDP


; LED SIMULATION
VISUALIZE_MORSE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA SI, MORSE_OUTPUT_BUF

VISUAL_LOOP:
    MOV AL, [SI]
    CMP AL, 0
    JE VISUAL_DONE

    CMP AL, '.'
    JE DO_DOT
    CMP AL, '-'
    JE DO_DASH
    CMP AL, ' '
    JE DO_LETTER_SPACE
    CMP AL, '/'
    JE DO_WORD_SPACE

    JMP NEXT_CHAR               ; Ignore any other characters

DO_DOT:
    CALL DRAW_GREEN_BLOCK
    MOV BX, 3                 
    CALL DELAY
    CALL DRAW_BLUE_BLOCK
    MOV BX, 10                 
    CALL DELAY
    JMP NEXT_CHAR

DO_DASH:
    CALL DRAW_GREEN_BLOCK
    MOV BX, 15                 
    CALL DELAY
    CALL DRAW_BLUE_BLOCK
    MOV BX, 10                 
    CALL DELAY
    JMP NEXT_CHAR

DO_LETTER_SPACE:
    MOV BX, 15                 ; Gap between letters
    CALL DELAY
    JMP NEXT_CHAR

DO_WORD_SPACE:
    MOV BX, 20                 ; Gap between words
    CALL DELAY
    JMP NEXT_CHAR

NEXT_CHAR:
    INC SI
    JMP VISUAL_LOOP

VISUAL_DONE:
    CALL DRAW_BLUE_BLOCK        ; Ensure block is turned off at the end
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
VISUALIZE_MORSE ENDP

DRAW_GREEN_BLOCK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV DH, 13                  ; Row 13 (Inside the Morse Output box)
    MOV DL, 65                  ; Column 65 (Far right side)
    CALL SET_CURSOR
    
    MOV AH, 09h                 ; BIOS Write Character and Attribute
    MOV AL, 20h                 ; ASCII Space character
    MOV BH, 00h                 ; Video page 0
    MOV BL, 0A0h                ; A0h: Light Green background, Black foreground
    MOV CX, 6                   ; Draw a block 6 characters wide
    INT 10h
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_GREEN_BLOCK ENDP

DRAW_BLUE_BLOCK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV DH, 13
    MOV DL, 65
    CALL SET_CURSOR
    
    MOV AH, 09h
    MOV AL, 20h
    MOV BH, 00h
    MOV BL, 19h                 ; 19h: Default UI Blue background to "turn off" the block
    MOV CX, 6
    INT 10h
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_BLUE_BLOCK ENDP

END MAIN
