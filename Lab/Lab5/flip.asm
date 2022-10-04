    .ORIG x3000

    AND R1 R1 #0
InputN:;specially designed to receive N, give N to R1
    GETC
    OUT
    ADD R2 R0 #-10; Exit Loop if "\n" is received
    BRz StoreN
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #-16; Transfer ASCII code to digits 0~9 // R0 -= 48
    
    ADD R1 R1 R1;
    ADD R2 R1 #0;R2= 2 X R1
    ADD R1 R1 R1;
    ADD R1 R1 R1;
    ADD R1 R1 R2;Multiply R1 by 10
    ADD R1 R1 R0;
    BR InputN 
StoreN:    
    ST R1,N; store N, R1,R2 is free
;------------------------------------------------------------;    
    
    LD R4 N;
    LD R6 XY
InputXY:;store XY pairs consecutively in memory  
    ADD R4 R4 #0
    BRz toProcess;exit InputXY if R5 decreases to 0
   
    GETC
    OUT ;get X
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    STR R0 R6 #0;X第一位不管是什么都存到R6
    ADD R6 R6 #1;R6自增
    GETC
    OUT;space
    ADD R2 R0 #-16
    ADD R2 R2 #-16
    BRz GETY;第二位不是空格那么接下来R1 <- R0 + 10，是空格就跳到接收Y
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #10 
    STR R0 R6 #-1;这里R6不要自增
    GETC;多吃一个空格
    OUT
   
GETY:
    GETC
    OUT;接收Y的第一位
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    STR R0 R6 #0;Y第一位不管是什么都存到R6 
    ADD R6 R6 #1;
    GETC;接收第二位
    OUT
    ADD R2 R0 #-10
    BRz endline;第二位不是回车那么接下来R1 <- R0 + 10，是空格就跳到循环尾巴

    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #-16
    ADD R0 R0 #10 
    STR R0 R6 #-1;这里R6不要自增
    GETC
    OUT
endline: 
    ADD R4 R4 #-1
    BR InputXY
;------------Input done, All registers are available now------------;
toProcess
    LD  R1,XY
    LD  R3,RES;
    LD  R6,STACK; recursionHelper R6
    ADD R1,R1,#-2
    AND R4,R4,#0
      
recurse :
    ADD R6,R6,#-1
    STR R1,R6,#0
    ADD R6,R6,#-1
    STR R7,R6,#0
    ADD R6,R6,#-1
    STR R3,R6,#0
      
    ADD R4,R4,#0
    BRp #2
    ADD R1,R1,#2
    BRnzp NextLine
    ADD R1,R1,#1
      
NextLine:  
    LDR R2,R1,#0; R2 = mem(R1)
    ST  R3,Save3; protect R3
    AND R4,R4,#0
check 
    LD  R5,REShead; REShead是用来判断有没有到x5000的，x5000是RES的最底下的地址
    ADD R5,R3,R5
    BRz checkDone
    LDR R5,R3,#-1
    NOT R5,R5
    ADD R5,R5,#1
    ADD R5,R2,R5
    BRz flip
    ADD R3,R3,#-1
    BRnzp check
      
checkDone:;查看个数是否到达
    LD  R3,Save3
    STR R2,R3,#0
    ADD R3,R3,#1
    LD  R5,REShead
    ADD R5,R3,R5
    LD  R2,N
    NOT R2,R2
    ADD R5,R2,R5
    ADD R5,R5,#1
    BRz Print
    JSR recurse
    ADD R3,R3,#-1
    BR #1
      
flip:
    LD  R3,Save3
    ADD R1,R1,#1
    LDR R2,R1,#0
    ST  R3,Save3
    AND R4,R4,#0
    ADD R4,R4,#1
check1: 
    LD  R5,REShead
    ADD R5,R3,R5
    BRz check1Done
    LDR R5,R3,#-1
    NOT R5,R5
    ADD R5,R5,#1
    ADD R5,R2,R5
    BRz ALLDONE
    ADD R3,R3,#-1
    BR check1
check1Done
    LD  R3,Save3
    STR R2,R3,#0
    ADD R3,R3,#1
    LD  R5,REShead
    ADD R5,R3,R5
    LD  R2,N
    NOT R2,R2
    ADD R5,R2,R5
    ADD R5,R5,#1
    BRz print;prints the result
    JSR recurse
      
    ADD R1,R1,#-3
    ADD R3,R3,#-1
    LDR R5,R3,#0
    
    NOT R5,R5
    ADD R5,R5,#1; negate R5
    
    ADD R5,R3,#0
    BRnp ALLDONE
    ADD R1,R1,#1
    JSR recurse
      
ALLDONE:  
    LDR R3,R6,#0;pop R3
    ADD R6,R6,#1
    LDR R7,R6,#0;pop R7
    ADD R6,R6,#1
    LDR R1,R6,#0;pop R1
    ADD R6,R6,#1
    RET


;------------  Process done here, all registers free! ------------;    

Print:
    LD R1 N;
    LD R2 RES; R2 -- starting addr of RES

PrintLoop:
    ADD R1 R1 #0
    BRz toHALT
    
    LDR R4 R2 #0;R4 <- mem[R2]
    ADD R4 R4 #-10; if R4 >= 10
    BRn printsmall
    
    AND R0 R0 #0
    ADD R0 R0 #1
    ADD R0 R0 #15
    ADD R0 R0 #15
    ADD R0 R0 #15
    ADD R0 R0 #3;R0 is '1'
    OUT
    
    BR printsmall1
    
printsmall1:
    LDR R0 R2 #0
    ADD R0 R0 #-10
    BR #1
    
printsmall:    
    LDR R0 R2 #0;R0 <- mem[R2]
    ADD R0 R0 #15
    ADD R0 R0 #15
    ADD R0 R0 #15
    ADD R0 R0 #3
    OUT
printSpace:    
    AND R0 R0 #0
    ADD R0 R0 #15
    ADD R0 R0 #15
    ADD R0 R0 #2
    OUT;print space
    
    ADD R2 R2 #1
    ADD R1 R1 #-1
    BR PrintLoop
toHALT:
    HALT
    
    

Save3   .BLKW	1    
N       .BLKW   1    
XY      .FILL x4000; The starting address of XY pairs is x4000 
RES     .FILL x5000; The result array starts at x5000
STACK   .FILL x6000; used to store val during recursion


REShead .FILL xB000;-x5000



    .END
    

    