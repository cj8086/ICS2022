.ORIG x0200 ;system booting code
        LD R6,OS_SP
        LD R0,USER_PSR ;push USER_PSR
        ADD R6,R6,#-1
        STR R0,R6,#0
        LD R0,USER_PC ;push USER_PC
        ADD R6,R6,#-1
        STR R0,R6,#0
        LD R0,KBSR_IE ;make KBSR[15] equal to 1, enable interrupts
        STI R0,KBSR; mem[mem[KBSR]] <- R0 = 1
        LD R0,KBI_ADDR ;intruction interrupt tabel vector x0800
        STI R0,KBI_INTV; mem[mem[KBI_INV,x0180]] <- R0 = x0800
        AND R0,R0,#0
        RTI

    OS_SP .FILL X3000
    USER_PSR .FILL X8002
    USER_PC .FILL X3000
    KBSR .FILL XFE00
    KBSR_IE .FILL X4000
    KBDR .FILL XFE02
    KBI_ADDR .FILL X0800
    KBI_INTV .FILL X0180
.END


;----------------------------------------------------------------
.ORIG x0800 ;interrupt service routine
        ST R0,SaveR0
        ST R1,SaveR1
        ST R2,SaveR2
        ST R6,SaveR6;
    PRESSED 
        LDI R0,KBSR_1 ;check KSBR[15], R0 <-mem[mem[KBSR_]]
        BRzp PRESSED;exit loop when KBSR[15] = 1
        
        LDI R0,KBDR_1;R0 <-mem[mem[KBDR_]]
        ; The interrupt service starts here, R0 is asscii of input
        LD R1 negASCII_a
        ADD R1 R0 R1;R1 <- R0 -97 
        BRzp CHANGE_LETTER;R1 >= 0 means R0 is a letter
        
        BRn HIGHER;R1 <0 means R0 is a digit
CHANGE_LETTER
        ADD R4 R0 #0;change letter ('a-z')
        BR toRTI
HIGHER:       
        ADD R2 R0 #0;
        ADD R2 R2 #-16
        ADD R2 R2 #-16
        ADD R2 R2 #-15;R2 is corresponding digit
        ADD R3 R3 R2;next we need to check if R3 is bigger than R3init_
        LD R1 R3init_neg
        ADD R1 R3 R1; R1 <- R3 - x3211 
        BRn toRTI;R1<= x3211
        LD R3 R3_max
        
        ;
toRTI:
        LD R0,SaveR0
        LD R1,SaveR1
        LD R2,SaveR2
        LD R6,SaveR6
        RTI

    SaveR0 .FILL x0000
    SaveR1 .FILL x0000
    SaveR2 .FILL x0000
    SaveR6 .FILL x0000
    KBSR_1 .FILL xFE00
    KBDR_1 .FILL xFE02
    negASCII_a .FILL #-97
    R3_max .FILL x3212;the nax place R3 can reach
    R3init_neg .FILL xCDEF;-x3211 == xCDEF
.END





.ORIG x3000
    LD R3 R3init;
    LD R4 ASCII_a;R4 changes only when interrupted
    BIG_LOOP
        LD R0 DOT;
        LD R1 DOTS_PER_LINE;
        LD R2 StrBGN
        
    LOOP1:
        STR R0 R2 #0;mem[R2] <- R0
        ADD R2 R2 #1;
        ADD R1 R1 #-1
        ;After this line R2 points to the bit[20],which is to be loaded with ascii of"\n"
        BRp LOOP1
        LD R0 ASCII_NEWLINE
        STR R0 R2 #0;mem[R2] <- R0
        ADD R2 R2 #1
        LD R0 EOS
        STR R0 R2 #0
        ;On this line the string has become "....................\n"
        
        ;if R3 is bigger than 17,set it to 17; if R3 is smaller than zero, set it to zero
    
 
        STR R4 R3 #0;mem[R3] is set 
        STR R4 R3 #1
        STR R4 R3 #2;mem[R3+2]
        LD R0 StrBGN
        PUTS
        JSR DELAY
        ADD R3 R3 #-1
        LD R1 StrBGN
        NOT R1 R1
        ADD R1 R1 #1
        ADD R1 R3 R1
        BRzp #1;if R3 - StrBGN <0 then set R3 to StrBGN
        LD R3 StrBGN
        
        BRnzp BIG_LOOP
        
  

    HALT
    DELAY_COUNT .FILL #7500
    DELAY_SaveR .BLKW #1
    StrBGN .FILL x3200; Points to the beginning of Text
    ASCII_NEWLINE .FILL #10;
    EOS .FILL #0
    DOT .FILL #46
    DOTS_PER_LINE    .FILL #20
    ASCII_a .FILL #97
    R3init  .FILL x3211;R3 points at bit[17] initially
    DELAY: 
        ST R5, DELAY_SaveR
        LD R5, DELAY_COUNT
    DELAY_LOOP:
        ADD R5, R5, #-1
        BRnp DELAY_LOOP
        LD R5, DELAY_SaveR
        RET
        
.END