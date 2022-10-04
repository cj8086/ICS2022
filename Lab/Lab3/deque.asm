.ORIG x3000 ; code start

    LD R5 LP_START; R5 points at xA001
    LD R6 RP_START; R6 points at xA000
    LD R3 POPPED;

INPUT:
    TRAP x20;GETC
    TRAP x21;OUT 
    
    ADD R1 R0 #-10
    BRz PRINT_POPPED
    
    LD R1 LPUSH_SIGN;R1 <- the ascii of +
    ADD R1 R0 R1;check if left-push
    BRz #1
    BR  #1
    JSR LPUSH
    
    LD R1 LPOP_SIGN;R1 <- the ascii of -
    ADD R1 R0 R1;
    BRz #1
    BR  #1
    JSR LPOP
    
    
   
    
    LD R1 RPUSH_SIGN;R1 <- the ascii of [
    ADD R1 R0 R1;
    BRz #1
    BR  #1
    JSR RPUSH
    
    LD R1 RPOP_SIGN;R1 <- the ascii of ]
    ADD R1 R0 R1;
    BRz #1
    BR  #1
    JSR RPOP
    
    
    BR INPUT ; jump back to start
    
;--------------------------------------------------;    
; Print the POPPED element to console
;--------------------------------------------------;    
PRINT_POPPED:
    LD R1 POPPED;R1 is moving ptr of POPPED 
    ADD R2 R3 #0;R2 := R3
    NOT R2 R2;
    ADD R2 R2 #1; R2 := -R3
PPLOOP:
    ADD R4 R1 R2; R4 := R1 + R2 = R1 - R3
    BRz TOHALT
    LDR R0 R1 #0; R0 <- mem[R1]
    OUT 
    ADD R1 R1 #1

    BRnzp PPLOOP
    
    
  
    
    
TOHALT:    
    HALT
    
;--------------------------------------------------;
;   subroutine for LPOP, LPUSH, RPOP, RPUSH
;--------------------------------------------------;

LPUSH:
    TRAP x20
    TRAP x21;
    ADD R5 R5 #-1;move left ptr to left
    STR R0 R5 #0;mem[R5] <- R0
    BRnzp success_exit;
    
    
    
LPOP:
    ST R1 SaveR1;
    ST R2 SaveR2;
    
    
    NOT R1 R6
    ADD R1 R1 #1; R1 := -R6
    ADD R2 R5 R1; R2 := R5 + R1 = R5 - R6
    BRp fail_exit;if R5 > R6 then stack is empty
    
    LDR R4 R5 #0;R4 <- mem[R6]
    STR R4 R3 #0;mem[R3] <- R4
    ADD R3 R3 #1;
    
    ADD R5 R5 #1;move left ptr to right
    BRnzp success_exit
    
;--------------------------------------------------;

RPUSH:
    TRAP x20
    TRAP x21;
    
    ADD R6 R6 #1;move right ptr to right
    STR R0 R6 #0;mem[R6] <- R0
    BRnzp success_exit;
    
RPOP:
    ST R1 SaveR1;
    ST R2 SaveR2;
    
    NOT R1 R6
    ADD R1 R1 #1; R1 := -R6
    ADD R2 R5 R1; R2 := R5 + R1 = R5 - R6
    BRp fail_exit;if R5 > R6 then stack is empty
    
    LDR R4 R6 #0;R4 <- mem[R6]
    STR R4 R3 #0;mem[R3] <- R4
    ADD R3 R3 #1;
    
    ADD R6 R6 #-1;move right ptr to left
    BRnzp success_exit
    

success_exit:
    LD R1 SaveR1
    LD R2 SaveR2
    RET

fail_exit:
    LD R1 SaveR1
    LD R2 SaveR2
    LD R4 POP_EMPTYSIGN
    STR R4 R3 #0;mem[R3] <- R4
    ADD R3 R3 #1;
    RET
    

    LP_START  .FILL xA001; left-side pointer starts at xA001
    RP_START  .FILL xA000; right-side pointer statrs at xA000
    POPPED  .FILL x8000; store the popped elements
    
    LPUSH_SIGN .FILL #-43; neg ascii of +
    LPOP_SIGN .FILL #-45; neg ascii of -
    RPUSH_SIGN .FILL #-91; neg ascii of [
    RPOP_SIGN .FILL #-93
    SaveR1  .FILL xC000
    SaveR2  .FILL xC001
    SaveR3  .FILL xC002
    POP_EMPTYSIGN  .FILL #95;ascii of _
    
    
.END ; code end
        