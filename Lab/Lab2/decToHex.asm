    .ORIG X3000
    ;R0 Ascii code of input
    ;R2 store the value of input
    AND R0 R0 #0
    AND R1 R1 #0
    AND R2 R2 #0
    AND R4 R4 #0
    
INPUT_TO_DEC:
    IN
    ADD R3 R0 #-10; Exit Loop if "\n" is received
    BRz STORE_HEX_DIGITS
    ADD R0 R0 #-15
    ADD R0 R0 #-15
    ADD R0 R0 #-15
    ADD R0 R0 #-3; Transfer ASCII code to digits 0~9 // R0 -= 48
    
    ADD R2 R2 R2;
    ADD R3 R2 #0;R3= 2 X R2
    ADD R2 R2 R2;
    ADD R2 R2 R2;
    ADD R2 R2 R3;Multiply R2 by 10
    
    ADD R2 R2 R0;
    
    BRnzp INPUT_TO_DEC

    ;R6 is used to store the address of hex-digits
STORE_HEX_DIGITS:
    LEA R6 HEX_DIGITS
    HEX_DIGITS: .STRINGZ "0123456789ABCDEF"

    ;----------------------------；
    ;R5- iteration variable, init as 4
    AND R5 R5 #0
    ADD R5 R5 #4
LOOP:
    ADD R5 R5 #0
    BRz TO_HALT
  
    AND R7 R7 #0
    ADD R2 R2 #0
    ;if R2 starts with '1',add 8 to R7
    BRzp #1  
    ADD R7 R7 #8
    ADD R2 R2 R2;
    
    ;if R2 starts with '1',add 4 to R7
    BRzp #1
    ADD R7 R7 #4
    ADD R2 R2 R2
    
    ;if R2 starts with '1',add 2 to R7
    BRzp #1
    ADD R7 R7 #2
    ADD R2 R2 R2
    
    ;if R2 starts with '1',add 1 to R7
    BRzp #1
    ADD R7 R7 #1
    ADD R2 R2 R2
  
  
    ADD R5 R5 #-1; R5 auto-decrement

    ADD R4 R6 R7; use R7 as an Offset ranging from 0 ~ 15,R4 is temp variable that helps store the address of corresponding hex-digits
    LDR R0 R4 #0;R0 <- mem[R4]
    OUT;output the corresponding hex-digits
    
    BRnzp LOOP

TO_HALT:
    HALT
    
    .END