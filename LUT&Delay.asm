.MODEL SMALL
.STACK 100h


.data 
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
m_atsign     db ".--.-.",0
m_exclamation db "-.-.--",0
m_ampersend   db ".-...",0
m_semicolon   db "-.-.-.",0
m_underscore  db "..--.-",0
m_dollarSign  db "...-..-",0


morse_code   dw 33 dup(0)
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
     
    
.code 

 Delay PROC 
             
    PUSH Bx  ;Bx is the multiplier that will be used to differentiate the time between the dot and dash
             ;Set Bx before Calling Delay. for ex, if a dash takes 500ms delay then 500x1 => Set Bx to 500
             
    PUSH Cx
    
    Loop1:
    mov Cx, 250 
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
Delay ENDp 
    
    
    
  





