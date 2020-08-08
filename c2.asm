DATAS SEGMENT
    ;此处输入数据段代码  
    buf db 81
     	db 0
     	db 81 dup(?)
    buf1 db 0ah,0dh,'$'
    bufchar db 'char:','$'
    bufdigit db 'digit:','$'
    bufother db 'other:','$'
    aword db 'input:',0dh,0ah,'$'
    char db 0
    digit db 0
    other db 0
    
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
    mov ah,09h
	mov dx,offset aword
	int 21h
    
    lea dx,buf
  	mov ah,0ah
    int 21h
    mov si,offset buf
    mov cl,[si+1];获得个数
    mov ch,0
    add si,1
main:
	cmp cx,0
	jz exit
	dec cx
	inc si
	mov al,buf[si]
	cmp al,30h
	jb r3
	cmp al,39h
	jbe r2
	cmp al,41h
	jb r3
	cmp al,5Ah
	jbe r1
	cmp al,61h
	jb r3
	cmp al,7Ah
	jbe r1
	jmp r3
r1:
	inc char
	jmp main
r2:
	inc digit
	jmp main
r3:
	inc other
	jmp main
exit:
	mov ah,09h
	mov dx,offset buf1
	int 21h;回车换行
	
	mov dx,offset bufchar
	int 21h;输出：char:
	mov bh,char
	call count
	
	mov ah,09h
	mov dx,offset buf1
	int 21h;回车换行
	
	mov dx,offset bufdigit
	int 21h;输出：digit:
	mov bh,digit
	call count
	
	mov ah,09h
	mov dx,offset buf1
	int 21h;回车换行
	
	mov dx,offset bufother
	int 21h;输出：other:
	mov bh,other
	call count
    MOV AH,4CH
    INT 21H
count proc near
    push ax
    push cx
    push dx
	
	mov bl,10;除数为10
	mov al,bh
	mov ah,0;设置ax
	div bl
	mov cx,ax
	add ch,30h
	add cl,30h
	mov ah,02h
	mov dl,cl
	int 21h
	mov dl,ch
	int 21h
	
	pop dx
	pop cx
	pop ax
	ret
count endp
CODES ENDS
    END START





