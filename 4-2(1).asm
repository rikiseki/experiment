DATAS SEGMENT
    ;此处输入数据段代码 
    tip1 db 'Input name:','$'
    tip2 db 'Input a telephone number:','$'
    tip3 db 'Do you want a telephone number?(Y/N)','$'
    tip4 db 'name?','$'
    tip5 db 'not find!','$'
    tip6 db 'save success!'
    tip7 db 'save fail!'
    
    buf db 0ah,0dh,'$'
    
    Tname db 21
    	 db 0
    	 db 21 dup(?)
    Ttele db 9
         db 0
         db 9 dup(?)
    table db 50 dup(28 dup(?),0ah,0dh),'$'
	total db 0
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov es,ax
    ;此处输入代码段代码
main:
	mov dx,offset tip1
	mov ah,09h
	int 21h;提示输入姓名
	mov dx,offset Tname
	mov ah,0ah
	int 21h;输入
	
	mov ah,09h
	mov dx,offset buf
	int 21h;回车换行
	mov dx,offset tip2
	int 21h;提示输入电话
	mov ah,0ah
	mov dx,offset Ttele
	int 21h;输入
	mov ah,09h
	mov dx,offset buf
	int 21h;回车换行
	
	cmp total,50
	jae full_table;电话表已满
	
	mov cx,21
	mov bh,0
    mov bl,[Tname+1]
    sub cx,bx   
set1:
	mov Tname[bx+2],' '
	inc bx
	loop set1
	
	mov bh,0
    mov bl,[Ttele+1]
    mov cx,9
    sub cx,bx 
set2:
	mov Ttele[bx+2],' '
	inc bx
	loop set2
	
	
	mov al,total
	mov bl,30;移动到相应位置
	mul bl
	mov si,offset Tname+2
	mov di,offset table
	add di,ax
	mov cx,20
	
	cld
	rep movsb;
	
	;add di,1
	;对电话号码进行操作
	mov si,offset Ttele+2
	mov cx,8
	
	cld
	rep movsb;移动
	
	mov dx,offset tip6
	mov ah,09h
	int 21h
	
	inc total
	mov dx,offset buf
	mov ah,09h
	int 21h;换行
	jmp next
next:
	mov ah,09h
	mov dx,offset tip3
	int 21h
	
full_table:
		
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

