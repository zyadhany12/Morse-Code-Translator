.MODEL SMALL                ; Defines memory model: 1 code segment, 1 data segment
.STACK 100h                 ; 100h: Allocate 256 bytes for stack segment

.DATA
    ; -------------------------------------------------------------------------
    ; UI Constants and Variables
    ; -------------------------------------------------------------------------
    BOX_ROWS        DB 7, 11, 15, 19     ; Row positions for drawing menu boxes
    BOX_COUNT       EQU 4                ; Number of menu boxes to draw
    USER_CHOICE     DB 0                 ; Stores the user's menu selection (prevents 000h offset issue)

    ; -------------------------------------------------------------------------
    ; Text to Morse Lookup Strings (Null-terminated)
    ; -------------------------------------------------------------------------
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

    ; -------------------------------------------------------------------------
    ; ASCII to Morse Pointer Array (Lookup Table)
    ; Direct mapping based on ASCII values (Index = ASCII code * 2 bytes)
    ; -------------------------------------------------------------------------
    MORSE_CODE dw 33 dup(0)              ; Fill indices 0-32 (Control chars + space) with 0
        dw offset m_exclamation          ; 33: '!'
        dw offset m_quotation            ; 34: '"'
        dw 0                             ; 35: '#' (unmapped)
        dw offset m_dollarSign           ; 36: '$'
        dw 0                             ; 37: '%' (unmapped)
        dw offset m_ampersend            ; 38: '&'
        dw offset m_apostrophe           ; 39: '''
        dw offset m_bracketO             ; 40: '('
        dw offset m_bracketC             ; 41: ')'
        dw 0                             ; 42: '*' (unmapped)
        dw offset m_plus                 ; 43: '+'
        dw offset m_comma                ; 44: ','
        dw offset m_hyphen               ; 45: '-'
        dw offset m_period               ; 46: '.'
        dw offset m_slash                ; 47: '/'
        dw offset m_0                    ; 48: '0'
        dw offset m_1                    ; 49: '1'
        dw offset m_2                    ; 50: '2'
        dw offset m_3                    ; 51: '3'
        dw offset m_4                    ; 52: '4'
        dw offset m_5                    ; 53: '5'
        dw offset m_6                    ; 54: '6'
        dw offset m_7                    ; 55: '7'
        dw offset m_8                    ; 56: '8'
        dw offset m_9                    ; 57: '9'
        dw offset m_colon                ; 58: ':'
        dw offset m_semicolon            ; 59: ';'
        dw 0                             ; 60: '<' (unmapped)
        dw offset m_equal                ; 61: '='
        dw 0                             ; 62: '>' (unmapped)
        dw offset m_query                ; 63: '?'
        dw offset m_atsign               ; 64: '@'
        dw offset m_a                    ; 65: 'A'
        dw offset m_b                    ; 66: 'B'
        dw offset m_c                    ; 67: 'C'
        dw offset m_d                    ; 68: 'D'
        dw offset m_e                    ; 69: 'E'
        dw offset m_f                    ; 70: 'F'
        dw offset m_g                    ; 71: 'G'
        dw offset m_h                    ; 72: 'H'
        dw offset m_i                    ; 73: 'I'
        dw offset m_j                    ; 74: 'J'
        dw offset m_k                    ; 75: 'K'
        dw offset m_l                    ; 76: 'L'
        dw offset m_m                    ; 77: 'M'
        dw offset m_n                    ; 78: 'N'
        dw offset m_o                    ; 79: 'O'
        dw offset m_p                    ; 80: 'P'
        dw offset m_q                    ; 81: 'Q'
        dw offset m_r                    ; 82: 'R'
        dw offset m_s                    ; 83: 'S'
        dw offset m_t                    ; 84: 'T'
        dw offset m_u                    ; 85: 'U'
        dw offset m_v                    ; 86: 'V'
        dw offset m_w                    ; 87: 'W'
        dw offset m_x                    ; 88: 'X'
        dw offset m_y                    ; 89: 'Y'
        dw offset m_z                    ; 90: 'Z'
        dw 4 dup(0)                      ; 91-94: '[', '\', ']', '^'
        dw offset m_underscore           ; 95: '_'
        dw 0                             ; 96: '`'
        dw offset m_a                    ; 97: 'a'
        dw offset m_b                    ; 98: 'b'
        dw offset m_c                    ; 99: 'c'
        dw offset m_d                    ; 100: 'd'
        dw offset m_e                    ; 101: 'e'
        dw offset m_f                    ; 102: 'f'
        dw offset m_g                    ; 103: 'g'
        dw offset m_h                    ; 104: 'h'
        dw offset m_i                    ; 105: 'i'
        dw offset m_j                    ; 106: 'j'
        dw offset m_k                    ; 107: 'k'
        dw offset m_l                    ; 108: 'l'
        dw offset m_m                    ; 109: 'm'
        dw offset m_n                    ; 110: 'n'
        dw offset m_o                    ; 111: 'o'
        dw offset m_p                    ; 112: 'p'
        dw offset m_q                    ; 113: 'q'
        dw offset m_r                    ; 114: 'r'
        dw offset m_s                    ; 115: 's'
        dw offset m_t                    ; 116: 't'
        dw offset m_u                    ; 117: 'u'
        dw offset m_v                    ; 118: 'v'
        dw offset m_w                    ; 119: 'w'
        dw offset m_x                    ; 120: 'x'
        dw offset m_y                    ; 121: 'y'
        dw offset m_z                    ; 122: 'z'
        dw 5 dup(0)                      ; 123-127: '{', '|', '}', '~', DEL

    ; -------------------------------------------------------------------------
    ; UI Display Strings
    ; -------------------------------------------------------------------------
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

    ; Morse to Text UI strings
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
    invalid_morse   DB ' [invalid char] ', 0

    ; Data buffers
    MORSE_INPUT_BUF DB 61 DUP(0)         ; Buffer for typing morse code
    TEXT_OUTPUT_BUF DB 61 DUP(0)         ; Buffer for translated text

    ; -------------------------------------------------------------------------
    ; Heap-based Binary Tree for Morse Decoding
    ; Root = 1. Left child (dot) = index * 2. Right child (dash) = index * 2 + 1.
    ; -------------------------------------------------------------------------
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

    ; Statistics tracking variables
    INPUT_LEN       DW 0
    CHAR_COUNT      DW 0
    WORD_COUNT      DW 0
    DOT_COUNT       DW 0
    DASH_COUNT      DW 0
    IN_WORD_FLAG    DB 0
    HAS_ERROR       DB 0    
    
    ; Text to Morse UI & buffers
    TEXT_INPUT_BUF   DB 61 DUP(0)
    MORSE_OUTPUT_BUF DB 512 DUP(0)       ; Needs to be larger since 1 char -> multiple dots/dashes
    TEXT_INPUT_LEN   DW 0
    MORSE_OUTPUT_LEN DW 0

    T2M_HEADER_STR  DB 'Text to Morse Code:', 0
    TEXT_IN_LBL     DB 'Text : ', 0
    MORSE_OUT_LBL   DB 'Morse: ', 0         
    T2M_CONT_STR    DB 'Press R to translate again, or any key to go back to menu: ', 0
    T2M_ERR_EMPTY   DB 'Error: Empty input! Please enter some text.          ', 0
    T2M_ERR_FULL    DB 'Error: Input full (max 60 characters)!               ', 0

.CODE
; =============================================================================
; MAIN ENTRY POINT
; =============================================================================
MAIN PROC
    MOV AX, @DATA               ; Initialize Data Segment pointer
    MOV DS, AX

    ; Set video mode to 80x25 16-color text mode (Standard VGA)
    MOV AH, 00h                 ; BIOS function: Set video mode
    MOV AL, 03h                 ; Mode 03h: 80x25 color text
    INT 10h                     ; Call BIOS Video Interrupt

MAIN_MENU_START:
    CALL DRAW_MAIN_GUI          ; Draw the background and menu options

    ; Prompt the user for input
    MOV DH, 23                  ; Row 23
    MOV DL, 4                   ; Column 4
    MOV BL, 07h                 ; Attribute: Light gray text (07h)
    LEA SI, PROMPT_STR          ; Load prompt string address
    CALL PRINT_COLOR_STR

PROMPT_LOOP:
    ; Draw a stylized block character over the cursor area
    MOV AX, 0B800h              ; Point ES to VGA Text Buffer segment
    MOV ES, AX
    MOV WORD PTR ES:[3726], 0B20h ; Write character 20h (Space) with color 0Bh at offset 3726

    MOV DH, 23                  ; Reposition Hardware Cursor
    MOV DL, 23
    CALL SET_CURSOR

    CALL READ_AND_VALIDATE_KEY  ; Wait for user input (returns choice in AL)
    CMP AL, 00h                 ; If AL is 0, input was invalid
    JE PROMPT_LOOP
    
    ; Route based on user input
    CMP AL, '1'
    JE RUN_OPTION_1
    CMP AL, '2'
    JE RUN_OPTION_2
    CMP AL, '3'
    JE MAIN_MENU_START          ; Op 3 just re-draws/clears the screen
    CMP AL, '4'
    JE EXIT_PROGRAM

    ; Fallback (unreachable due to strict validation in READ_AND_VALIDATE_KEY)
    CALL CLEAR_FULL_SCREEN
    MOV DH, 12
    MOV DL, 22
    MOV BL, 0Bh                 
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
    MOV AH, 4Ch                 ; BIOS function: Terminate Program
    MOV AL, 00h                 ; Return code 0 (Success)
    INT 21h                     ; Call DOS System Interrupt
MAIN ENDP

; =============================================================================
; DELAY ROUTINE
; Simulates a hardware delay loop. 
; Input: BX = Multiplier
; =============================================================================
DELAY PROC 
    PUSH Bx  
    PUSH Cx
    
Loop1:
    mov Cx, 2                   ; Inner loop count (Tuned down for emulator dilation)
Loop2:
    NOP                         ; No Operation - consumes CPU cycles for timing
    loop Loop2                  ; Decrements CX, jumps to Loop2 if CX != 0
    
    Dec Bx                      ; Decrement the outer multiplier
    jnz loop1                   ; Jump to Loop1 if BX != 0
    
    Pop Cx
    Pop Bx
    ret 
DELAY ENDP

; =============================================================================
; MORSE TO TEXT LOGIC
; =============================================================================
MORSE_TO_TEXT_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

M2C_RESTART:
    CALL DRAW_M2C_INTERFACE     ; Draw UI boundaries and static text
    CALL READ_MORSE_INPUT       ; Read keyboard input into MORSE_INPUT_BUF
    CALL TRANSLATE_MORSE_BUFFER ; Convert dots/dashes to text via Binary Tree
    CALL DISPLAY_M2C_RESULTS    ; Print resulting text and stats

    ; Prompt for repeat
    MOV DH, 23
    MOV DL, 4
    MOV BL, 07h                 
    LEA SI, M2C_CONT_STR
    CALL PRINT_COLOR_STR

    MOV AH, 00h                 ; BIOS function: Read keyboard buffer
    INT 16h                     ; Call Keyboard Interrupt

    CMP AL, 'R'                 ; Check if user pressed 'R' or 'r'
    JE M2C_RESTART
    CMP AL, 'r'
    JE M2C_RESTART

    POP SI                      ; Otherwise, exit back to main menu
    POP DX
    POP CX
    POP BX
    POP AX
    RET
MORSE_TO_TEXT_SCREEN ENDP

DRAW_M2C_INTERFACE PROC
    ; Pushes registers to save state
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    CALL CLEAR_FULL_SCREEN

    ; Print headers
    MOV DH, 1
    MOV DL, 29
    MOV BL, 0Bh                 ; Light cyan
    LEA SI, TITLE_STR
    CALL PRINT_COLOR_STR

    MOV DH, 2
    MOV DL, 29
    MOV BL, 07h                 ; Light gray
    LEA SI, SUBTITLE_STR
    CALL PRINT_COLOR_STR

    ; Draw top separator line using INT 10h (AH=09h)
    MOV DH, 3
    MOV DL, 4
    CALL SET_CURSOR
    MOV AH, 09h                 ; Write char & attribute at cursor
    MOV AL, 0C4h                ; Box-drawing horizontal line char (-)
    MOV BH, 00h                 ; Page 0
    MOV BL, 08h                 ; Dark gray attribute
    MOV CX, 72                  ; Repeat 72 times
    INT 10h                     

    MOV DH, 5
    MOV DL, 4
    MOV BL, 09h                 
    LEA SI, M2C_HEADER_STR
    CALL PRINT_COLOR_STR

    ; Draw the input, output, and stats boxes
    MOV DH, 7
    CALL DRAW_MENU_BOX
    MOV DH, 8
    MOV DL, 6
    MOV BL, 1Bh                 ; 1Bh: Cyan text on Blue background
    LEA SI, MORSE_IN_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 11
    CALL DRAW_MENU_BOX
    MOV DH, 12
    MOV DL, 6
    MOV BL, 1Bh                 
    LEA SI, TEXT_OUT_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 15
    CALL DRAW_MENU_BOX
    MOV DH, 16
    MOV DL, 6
    MOV BL, 1Bh                 
    LEA SI, STAT_CHAR_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 25
    MOV BL, 1Bh                 
    LEA SI, STAT_WORD_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 39
    MOV BL, 1Bh                 
    LEA SI, STAT_DOT_LBL
    CALL PRINT_COLOR_STR

    MOV DH, 16
    MOV DL, 52
    MOV BL, 1Bh                 
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

    MOV AX, 0B800h              ; Point ES to VGA memory
    MOV ES, AX
    MOV [INPUT_LEN], 00h        ; Reset input length
    MOV [HAS_ERROR], 00h        ; Clear error flag

READ_KEY_LOOP:
    MOV AX, [INPUT_LEN]
    MOV DH, 8                   ; Row 8 (inside the Input Box)
    MOV DL, 13                  ; Col 13
    ADD DL, AL                  ; Move cursor forward by INPUT_LEN
    CALL SET_CURSOR

    MOV AH, 00h                 ; Wait for keypress
    INT 16h                     

    CMP AL, 0Dh                 ; Carriage Return (Enter)
    JE HANDLE_ENTER_KEY
    CMP AL, 08h                 ; Backspace
    JE HANDLE_BACKSPACE_KEY

    ; Validate Morse chars: allow '.', '-', ' ', '/'
    CMP AL, '.'
    JE VALID_MORSE_CHAR
    CMP AL, '-'
    JE VALID_MORSE_CHAR
    CMP AL, ' '
    JE VALID_MORSE_CHAR
    CMP AL, '/'
    JE VALID_MORSE_CHAR

    ; Invalid character handling
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; 0Ch: Light Red text
    LEA SI, M2C_ERR_KEY
    CALL PRINT_COLOR_STR
    MOV [HAS_ERROR], 01h
    JMP READ_KEY_LOOP

VALID_MORSE_CHAR:
    CMP [INPUT_LEN], 60         ; Check bounds
    JAE HANDLE_BUFFER_FULL

    MOV DI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[DI], AL ; Store valid char in memory buffer

    ; Calculate VRAM offset directly to print the character
    ; VRAM Offset = (Row * 160) + (Col * 2) -> (8 * 160) + ((13 + Len) * 2)
    ; 8 * 160 = 1280. 13 * 2 = 26. Base = 1306. 1306 / 2 = 653
    ADD DI, 653                 ; Base offset in WORDS
    SHL DI, 1                   ; Multiply by 2 for BYTE offset
    MOV AH, 1Bh                 ; Color attribute (Cyan on Blue)
    MOV ES:[DI], AX             ; Write directly to video memory!

    INC [INPUT_LEN]
    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_KEY_LOOP

HANDLE_BACKSPACE_KEY:
    CMP [INPUT_LEN], 00h        ; Do nothing if buffer is empty
    JE READ_KEY_LOOP

    DEC [INPUT_LEN]             ; Step back one char
    MOV DI, [INPUT_LEN]
    ADD DI, 653
    SHL DI, 1
    MOV WORD PTR ES:[DI], 1B20h ; 1B20h: Attribute 1Bh, Char 20h (Space) - Overwrites with space

    CALL CLEAR_ERR_IF_NEEDED
    JMP READ_KEY_LOOP

HANDLE_BUFFER_FULL:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; Red error text
    LEA SI, M2C_ERR_FULL
    CALL PRINT_COLOR_STR
    MOV [HAS_ERROR], 01h
    JMP READ_KEY_LOOP

HANDLE_ENTER_KEY:
    CMP [INPUT_LEN], 00h        ; Reject Enter if nothing was typed
    JE SHOW_EMPTY_MORSE_ERR

    MOV SI, [INPUT_LEN]
    MOV MORSE_INPUT_BUF[SI], 00h ; Null-terminate the string for processing
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
    MOV BL, 0Ch                 
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
    ; Use INT 10h AH=06h to clear just the error message row
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 07h
    MOV CX, 1804h               ; (Row 24, Col 4)
    MOV DX, 183Ah               ; (Row 24, Col 58)
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

    ; Reset all statistics counters
    MOV [CHAR_COUNT], 00h       
    MOV [WORD_COUNT], 00h       
    MOV [DOT_COUNT], 00h
    MOV [DASH_COUNT], 00h
    MOV [IN_WORD_FLAG], 00h     

    LEA SI, MORSE_INPUT_BUF     ; Source pointer
    LEA DI, TEXT_OUTPUT_BUF     ; Destination pointer

PARSE_NEXT_TOKEN:
    MOV AL, [SI]
    CMP AL, 00h                 ; Check for string end
    JE TRANSLATE_FINISH

    CMP AL, ' '                 ; Space = boundary between letters
    JNE CHECK_WORD_SLASH
    INC SI
    JMP PARSE_NEXT_TOKEN

CHECK_WORD_SLASH:
    CMP AL, '/'                 ; Slash = boundary between words
    JNE DECODE_NEXT_LETTER
    INC SI
    CMP [IN_WORD_FLAG], 00h     ; Only add space if inside a word
    JE PARSE_NEXT_TOKEN
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV [IN_WORD_FLAG], 00h     ; Reset word flag
    JMP PARSE_NEXT_TOKEN

DECODE_NEXT_LETTER:
    MOV BX, 1                   ; Start at root index 1 for Binary Tree search

BUILD_TREE_INDEX:
    MOV AL, [SI]                ; Fetch current morse char
    CMP AL, 00h
    JE FINISH_LETTER
    CMP AL, ' '
    JE FINISH_LETTER
    CMP AL, '/'
    JE FINISH_LETTER

    INC SI
    CMP AL, '.'
    JE STEP_DOT

    ; It's a dash '-'
    INC [DASH_COUNT]
    SHL BX, 1                   ; BX = BX * 2
    INC BX                      ; BX = BX * 2 + 1 (Right child in tree)
    JMP CHECK_TREE_BOUNDS

STEP_DOT:
    INC [DOT_COUNT]
    SHL BX, 1                   ; BX = BX * 2 (Left child in tree)

CHECK_TREE_BOUNDS:
    CMP BX, 255                 ; Max tree size check
    JBE BUILD_TREE_INDEX
    MOV BX, 255                 ; Cap to prevent memory overflow
    JMP BUILD_TREE_INDEX

FINISH_LETTER:
    MOV AL, MORSE_TREE[BX]      ; Retrieve resolved char from Tree
    CMP AL, 00h
    JNE STORE_DECODED_CHAR
    lea si, invalid_morse                     ; Point SI to the start of the string

next_c:
    mov al, [si]                    ; Move ONE character from memory into AL
    cmp al, 0                       ; Check if we reached the end (0)
    je done                         ; If 0, stop

    
    mov ah, 0Eh
    int 10h

    inc si                          ; Move pointer to the next character
    jmp next_c

done:
    mov cx, 000Fh                   ; High word of microseconds
    mov dx, 4240h                   ; Low word of microseconds
    mov ah, 86h                     ; BIOS wait function
    int 15h
    ret            

STORE_DECODED_CHAR:
    MOV [DI], AL                ; Store in output buffer
    INC DI
    INC [CHAR_COUNT]

    ; Check if this starts a new word
    CMP [IN_WORD_FLAG], 00h     
    JNE PARSE_NEXT_TOKEN
    INC [WORD_COUNT]
    MOV [IN_WORD_FLAG], 01h     ; Mark we are inside a word
    JMP PARSE_NEXT_TOKEN

TRANSLATE_FINISH:
    MOV BYTE PTR [DI], 00h      ; Null terminate output

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

    ; Print Translated Text string
    MOV DH, 12
    MOV DL, 13
    MOV BL, 1Bh                 
    LEA SI, TEXT_OUTPUT_BUF
    CALL PRINT_COLOR_STR

    ; Print Char Count
    MOV AX, [CHAR_COUNT]
    MOV DH, 16
    MOV DL, 18
    MOV BL, 1Bh                 
    CALL PRINT_NUMBER

    ; Print Word Count
    MOV AX, [WORD_COUNT]
    MOV DH, 16
    MOV DL, 32
    MOV BL, 1Bh                 
    CALL PRINT_NUMBER

    ; Print Dot Count
    MOV AX, [DOT_COUNT]
    MOV DH, 16
    MOV DL, 45
    MOV BL, 1Bh                 
    CALL PRINT_NUMBER

    ; Print Dash Count
    MOV AX, [DASH_COUNT]
    MOV DH, 16
    MOV DL, 60
    MOV BL, 1Bh                 
    CALL PRINT_NUMBER

    POP SI
    POP DX
    POP BX
    POP AX
    RET
DISPLAY_M2C_RESULTS ENDP

; =============================================================================
; INTEGER TO ASCII STRING CONVERTER
; Given AX = number, prints digits using direct VRAM writes.
; =============================================================================
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH SI
    PUSH ES

    MOV CX, 0B800h              ; Set ES to VRAM Segment
    MOV ES, CX

    ; Calculate VRAM offset: (DH * 160) + (DL * 2)
    PUSH AX
    MOV AL, 160
    MUL DH                      ; AX = DH * 160
    XOR DH, DH
    SHL DX, 1                   ; DX = DL * 2
    ADD AX, DX
    MOV DI, AX                  ; DI = VRAM offset
    POP AX

    XOR CX, CX                  ; Digit counter
    MOV SI, 10                  ; Base 10 divisor

DIVIDE_NUM_LOOP:
    XOR DX, DX                  ; Clear DX for division
    DIV SI                      ; AX = DX:AX / 10, Remainder in DX
    ADD DL, '0'                 ; Convert remainder to ASCII digit
    PUSH DX                     ; Push to stack (reverses order for printing)
    INC CX                      ; Increment digit count
    CMP AX, 00h                 ; If quotient == 0, we are done dividing
    JNE DIVIDE_NUM_LOOP

    MOV AH, BL                  ; Set color attribute
    CLD                         ; Clear direction flag (auto-increment DI)
PRINT_DIGIT_LOOP:
    POP DX                      ; Pop digits off stack (now in correct MSB->LSB order)
    MOV AL, DL
    STOSW                       ; Write AL (char) and AH (color) to ES:[DI]
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

; =============================================================================
; UI DRAWING ROUTINES
; =============================================================================
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

    ; Draw horizontal divider
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

    ; Loop through BOX_ROWS array to draw multiple UI boxes
    XOR SI, SI
DRAW_BOXES_LOOP:
    MOV DH, BOX_ROWS[SI]
    CALL DRAW_MENU_BOX
    INC SI
    CMP SI, BOX_COUNT
    JL DRAW_BOXES_LOOP          ; If SI < 4, jump back

    ; Print menu options inside the drawn boxes
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

; Draws a box with borders based on the Row provided in DH
DRAW_MENU_BOX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH ES

    ; Clear/Fill the specific window area with Blue (19h)
    MOV AH, 06h                 ; Scroll/clear window
    MOV AL, 00h                 ; 0 = clear entire window
    MOV BH, 19h                 ; 19h: Blue background
    MOV CH, DH                  ; Top row
    MOV CL, 4                   ; Left column (fixed at 4)
    MOV DL, 75                  ; Right column (fixed at 75)
    ADD DH, 2                   ; Bottom row (+2 height)
    INT 10h                     
    SUB DH, 2                   ; Restore DH

    ; Draw top border (C4h)
    MOV DL, 5
    CALL SET_CURSOR
    MOV AH, 09h                 
    MOV AL, 0C4h                
    MOV BH, 00h                 
    MOV BL, 19h                 
    MOV CX, 70                  ; 70 chars wide
    INT 10h                     

    ; Draw bottom border
    ADD DH, 2
    CALL SET_CURSOR
    INT 10h                     
    SUB DH, 2

    ; Draw the 6 corner/side pieces by injecting directly into VRAM
    MOV AX, 0B800h
    MOV ES, AX
    MOV AL, 160
    MUL DH
    MOV DI, AX

    MOV WORD PTR ES:[DI+8],   19DAh   ; Top Left corner (+)
    MOV WORD PTR ES:[DI+150], 19BFh   ; Top Right corner (+)
    MOV WORD PTR ES:[DI+168], 19B3h   ; Left side border (¦)
    MOV WORD PTR ES:[DI+310], 19B3h   ; Right side border (¦)
    MOV WORD PTR ES:[DI+328], 19C0h   ; Bottom Left corner (+)
    MOV WORD PTR ES:[DI+470], 19D9h   ; Bottom Right corner (+)

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

    MOV AH, 00h                 ; Block and read key
    INT 16h                     

    CMP AL, 0Dh                 ; Reject Enter
    JE HANDLE_EMPTY_ERR
    CMP AL, 20h                 ; Reject Space
    JE HANDLE_EMPTY_ERR
    CMP AL, 1Bh                 ; Reject Escape
    JE HANDLE_EMPTY_ERR

    CMP AL, '1'                 ; Enforce bounds '1' to '4'
    JB HANDLE_RANGE_ERR
    CMP AL, '4'
    JA HANDLE_RANGE_ERR

    MOV [USER_CHOICE], AL       ; Store valid choice
    JMP VALIDATE_DONE

HANDLE_EMPTY_ERR:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 ; Error color (Red)
    LEA SI, ERR_EMPTY_STR
    CALL PRINT_COLOR_STR
    XOR AL, AL                  ; Return 0 to indicate error
    JMP VALIDATE_DONE

HANDLE_RANGE_ERR:
    CMP AL, 20h
    JB SKIP_BAD_ECHO
    ; Echo the bad character to screen so user sees what they typed
    PUSH AX
    MOV AX, 0B800h
    MOV ES, AX
    POP AX
    MOV AH, 0Bh                 ; Print with Cyan color
    MOV ES:[3726], AX           ; Hardware VRAM write at specific box location
SKIP_BAD_ECHO:
    MOV DH, 24
    MOV DL, 4
    MOV BL, 0Ch                 
    LEA SI, ERR_RANGE_STR
    CALL PRINT_COLOR_STR
    XOR AL, AL                  ; Return 0

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
    MOV AH, 06h                 ; Scroll window up function
    MOV AL, 00h                 ; Lines to scroll (0 = clear)
    MOV BH, 07h                 ; Fill attribute (black background, gray text)
    MOV CX, 0000h               ; (Row 0, Col 0)
    MOV DX, 184Fh               ; (Row 24, Col 79)
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
    MOV AH, 02h                 ; Set cursor position
    MOV BH, 00h                 ; Page 0
    INT 10h                     
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
    MOV ES, AX                  ; ES -> VGA memory

    ; Offset = DH * 160 + DL * 2
    MOV AL, 160
    MUL DH
    XOR DH, DH
    SHL DX, 1
    ADD AX, DX
    MOV DI, AX

    MOV AH, BL                  ; Put color attribute in high byte (AH)
    CLD
VRAM_LOOP:
    LODSB                       ; Load char at DS:SI into AL, increment SI
    CMP AL, 00h                 ; Check for null terminator
    JE VRAM_DONE
    STOSW                       ; Store AX (color + char) to ES:DI, increment DI by 2
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
                             
; =============================================================================
; TEXT TO MORSE LOGIC
; =============================================================================
TEXT_TO_MORSE_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    T2M_RESTART:
        CALL CLEAR_FULL_SCREEN
        
        ; Draw Headers
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
        
        ; Draw UI Boxes
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
        CALL VISUALIZE_MORSE      ; Trigger the visual LED blink routine
                        
        MOV DH, 23
        MOV DL, 4
        MOV BL, 07h
        LEA SI, T2M_CONT_STR
        CALL PRINT_COLOR_STR
    
        MOV AH, 00H              
        INT 16H                  
        
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

    MOV AH, 00H                  
    INT 16H                      

    CMP AL, 0DH                 
    JE TEXT_ENTER_PRESSED
    CMP AL, 08H                 
    JE TEXT_BACKSPACE

    CMP AL, 20H                 ; Ignore control characters below space (20h)
    JB READ_TEXT_LOOP

    CMP [TEXT_INPUT_LEN], 60    ; Bound check
    JAE TEXT_BUFFER_FULL

    MOV DI, [TEXT_INPUT_LEN]
    MOV TEXT_INPUT_BUF[DI], AL

    ; 9 * 160 = 1440. 13 * 2 = 26. Base = 1466 / 2 = 733.
    ADD DI, 733
    SHL DI, 1
    MOV AH, 1BH
    MOV ES:[DI], AX             ; Echo character directly to VRAM

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
    MOV WORD PTR ES:[DI], 1B20h ; Overwrite with space

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
    MOV TEXT_INPUT_BUF[SI], 0   ; Null terminate
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
    
    ; Convert lowercase letters to uppercase to map to array indices correctly
    CMP AL, 'a'
    JB TEXT_GET_MORSE
    CMP AL, 'z'
    JA TEXT_GET_MORSE
    SUB AL, 20H                 ; Convert 'a'-'z' (97-122) to 'A'-'Z' (65-90)
        
TEXT_GET_MORSE:
    CMP AL, 127
    JA TEXT_UNKNOWN_CHAR 

    XOR BX, BX
    MOV BL, AL                  ; Copy ASCII char to BX to use as lookup index
    
    SHL BX, 1                   ; Multiply index by 2 because pointers are WORDS (16-bit)
    MOV BX, MORSE_CODE[BX]      ; Load the memory offset of the Morse string
    
    CMP BX, 0                   ; If the array entry is 0, char is unmapped
    JE TEXT_UNKNOWN_CHAR   
    
    INC [CHAR_COUNT]
    
    CMP [IN_WORD_FLAG], 0
    JNE TEXT_WORD_ALREADY_COUNTED
    
    INC [WORD_COUNT]
    MOV [IN_WORD_FLAG], 1
        
TEXT_WORD_ALREADY_COUNTED:    
        
TEXT_COPY_MORSE:
    MOV AL, [BX]                ; Read char from the morse string pointer
    
    CMP AL, 0                   ; Null byte means end of morse string
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
    MOV [DI], AL                ; Save morse symbol into output buffer
    INC DI
    INC [MORSE_OUTPUT_LEN]
    
    INC BX                      ; Move to next symbol in string
    JMP TEXT_COPY_MORSE
        
TEXT_MORSE_END:
    MOV BYTE PTR [DI], ' '      ; Add space between morse letters
    INC DI
    INC [MORSE_OUTPUT_LEN]
    
    INC SI
    JMP TEXT_TRANSLATE_LOOP
        
TEXT_WORD_SPACE:
    CMP DI, OFFSET MORSE_OUTPUT_BUF
    JE TEXT_SKIP_WORD_SPACE     ; Skip space if it's the first character
    
    DEC DI
    DEC [MORSE_OUTPUT_LEN]
    
    MOV BYTE PTR [DI], '/'      ; Use slash to denote word separation
    INC DI
    INC [MORSE_OUTPUT_LEN]
    
    MOV BYTE PTR [DI], ' '
    INC DI
    INC [MORSE_OUTPUT_LEN]   
    
    MOV [IN_WORD_FLAG], 0       ; Flag that we finished a word
        
TEXT_SKIP_WORD_SPACE:
    INC SI
    JMP TEXT_TRANSLATE_LOOP
        
TEXT_UNKNOWN_CHAR:
    INC SI
    JMP TEXT_TRANSLATE_LOOP
        
TEXT_TRANSLATE_DONE:
    CMP DI, OFFSET MORSE_OUTPUT_BUF
    JE TEXT_OUTPUT_EMPTY
    DEC DI                      ; Remove trailing space
        
TEXT_OUTPUT_EMPTY:
    MOV BYTE PTR [DI], 0        ; Null terminate string
    
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

    ; Print converted morse string
    MOV DH, 13
    MOV DL, 13
    MOV BL, 1Bh
    LEA SI, MORSE_OUTPUT_BUF
    CALL PRINT_COLOR_STR      
    
    ; Print stats
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


; =============================================================================
; LED SIMULATION (VISUAL PLAYBACK)
; Iterates through the output morse string, drawing and hiding a green block
; at specific timing intervals to simulate an LED.
; =============================================================================
VISUALIZE_MORSE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA SI, MORSE_OUTPUT_BUF    ; Load the translated buffer

VISUAL_LOOP:
    MOV AL, [SI]                ; Fetch symbol
    CMP AL, 0                   ; Null = done
    JE VISUAL_DONE

    CMP AL, '.'
    JE DO_DOT
    CMP AL, '-'
    JE DO_DASH
    CMP AL, ' '
    JE DO_LETTER_SPACE
    CMP AL, '/'
    JE DO_WORD_SPACE

    JMP NEXT_CHAR               ; Skip unknown data

DO_DOT:
    CALL DRAW_GREEN_BLOCK
    MOV BX, 3                   ; Delay multiplier for green LED ON (Dot length)
    CALL DELAY
    CALL DRAW_BLUE_BLOCK
    MOV BX, 10                  ; Delay multiplier for LED OFF (Inter-symbol gap)
    CALL DELAY
    JMP NEXT_CHAR

DO_DASH:
    CALL DRAW_GREEN_BLOCK
    MOV BX, 15                  ; Delay multiplier for green LED ON (Dash length)
    CALL DELAY
    CALL DRAW_BLUE_BLOCK
    MOV BX, 10                  ; Delay multiplier for LED OFF (Inter-symbol gap)
    CALL DELAY
    JMP NEXT_CHAR

DO_LETTER_SPACE:
    MOV BX, 15                  ; Delay between letters (longer gap)
    CALL DELAY
    JMP NEXT_CHAR

DO_WORD_SPACE:
    MOV BX, 20                  ; Delay between full words (longest gap)
    CALL DELAY
    JMP NEXT_CHAR

NEXT_CHAR:
    INC SI
    JMP VISUAL_LOOP

VISUAL_DONE:
    CALL DRAW_BLUE_BLOCK        ; Guarantee block resets to blue when finished
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
    MOV AL, 20h                 ; ASCII Space character (creates solid block)
    MOV BH, 00h                 ; Video page 0
    MOV BL, 0A0h                ; A0h: Light Green background
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
    MOV BL, 19h                 ; 19h: Default UI Blue background to "hide" the block
    MOV CX, 6
    INT 10h
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DRAW_BLUE_BLOCK ENDP

END MAIN