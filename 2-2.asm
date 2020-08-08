DATAS SEGMENT
    ;此处输入数据段代码
    X DW ?
    Y DW ?
    Z DW ?
    V DW ?  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	MOV AX,STACKS
	MOV SS,AX
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    MOV AX,X
    IMUL Y
    ADD AX,Z
    ADC DX,0
    SUB AX,540
    SBB DX,0
    
    PUSH DX
    PUSH AX
    
    MOV AX,V
    CBW 
    POP BX
    SUB AX,BX
    
    POP BX
    SBB DX,BX
    
    IDIV X
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
