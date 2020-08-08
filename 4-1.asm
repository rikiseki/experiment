DATAS SEGMENT
    ;此处输入数据段代码  
    SETENCE DB 200,?,200 DUP(0)
    W DB 20,?,20 DUP(0)
    BUF0 DB 'INPUT SETENCE:$'
    BUF1 DB 'INPUT WORD:$'
    BUF2 DB 13,10,'$'
    BUF3 DB 'MATCH!',13,10,'$'
    BUF4 DB 'NO MATCH!',13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX
    ;此处输入代码段代码
    
    MOV DX,OFFSET BUF0
    MOV AH,09H
    INT 21H;输出提示语
    
    MOV DX,OFFSET SETENCE
    MOV AH,0AH
    INT 21H;输入句子
    
    MOV DX,OFFSET BUF2
    MOV AH,09H
    INT 21H;换行
    
    MOV DX,OFFSET BUF1
    MOV AH,09H
    INT 21H;输出提示语
    
    MOV DX,OFFSET W
    MOV AH,0AH
    INT 21H;输入单词
    
    MOV DX,OFFSET BUF2
    MOV AH,09H
    INT 21H;换行
	MOV BX,0
	
	MOV AL,SETENCE+1
	MOV AH,0
	ADD AX,OFFSET SETENCE+1;句子里面最后一个字符的位置的偏移量 	
NEXTW:
	CMP SI,AX
	JA PNM;所有的都试了，没有可以匹配的
	MOV SI,OFFSET SETENCE+2 
    ADD SI,BX
    INC BX
    MOV DI,OFFSET W+2
	MOV CL,W[1]
	MOV CH,0    

    CLD;+
    REPE CMPSB;循环比较
    JE PM;相等就跳转
    JNE NEXTW;不等就重复，尝试下一个字符开始
    
PM:
	MOV DX,OFFSET BUF3
	MOV AH,09H
	INT 21H
	
    MOV CH,2
	MOV CL,4
NEXT:
	ROL BL,CL
	MOV AL,BL
	AND AL,0FH
	ADD AL,30H
	CMP AL,39H
	JBE NOADD7
    ADD AL,07H
NOADD7:
	MOV DL,AL
	MOV AH,2
	INT 21H
	DEC CH
	JNZ NEXT    
	
	
	MOV DX,OFFSET BUF2
    MOV AH,09H
    INT 21H;换行
    
    MOV SI,OFFSET SETENCE+2
	JMP OVER

PNM:	
	MOV DX,OFFSET BUF4    
    MOV AH,09H
    INT 21H
    JMP OVER

OVER:    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START







