DATAS SEGMENT
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
    MOV BL,10H
    MOV CH,0EH
NEW_LINE:
    MOV Cl,10H
    
    MOV AH,02H
    MOV DL,13;换行
    INT 21H
    MOV AH,02H
    MOV DL,10;光标左移
    INT 21H
NEXT_CHAR:    
    MOV AH,02H
    MOV DL,BL
    INT 21H
    
    MOV AH,02H
    MOV DL,0
    INT 21H
    
    ADD BL,01H
    SUB CL,1
    JNZ NEXT_CHAR
    SUB CH,1
    JNZ NEW_LINE
OVER:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


