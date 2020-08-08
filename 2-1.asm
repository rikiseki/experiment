DATAS SEGMENT
    ;此处输入数据段代码  
    X DD 10H
    Y DD 12H
    Z DD 14H
    W DD ?
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
    MOV AX,WORD PTR [X]
    MOV DX,WORD PTR [X+2]
    ADD AX,WORD PTR [Y]
    ADC DX,WORD PTR [Y+2]
    ADD AX,24
    ADC DX,0
    SUB AX,WORD PTR[Z]
    SBB DX,WORD PTR[Z+2]
    MOV WORD PTR[W],AX
    MOV WORD PTR[W+2],DX
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




