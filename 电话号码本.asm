data    segment
enter_name db 'Input name:','$'
enter_phone db 'Input a telephone number:','$'
tip db 'Do you want to search a telephone number?(y/n)','$'
ask_name db 'what is the name?','$'
nofind db 'Not find','$'
enter_num db 'the number you want to store:','$'
tmpn db 21,?,21 dup(?)
tmpp db 9,?,9 dup(?)
table db 50 dup(28 dup(?))
name_count dw 0
endaddr dw ?
swapped dw ?
totalnum dw ?
savenp db 28 dup(?),0dh,0ah,'$'
searchaddr dw ?
flag db ?
flagb db ?
show db 'name                phone',0dh,0ah,'$'
data  ends

code  segment
   assume ds:data,cs:code,es:data
main proc far
       mov ax,data
       mov ds,ax
       mov es,ax
       ;此处输入代码段代码
       mov bx,0
	   mov di,offset table;di指向table
       mov dx,offset enter_num;输出提示
       mov ah,09
       int 21h
newchar:;bx获得个数                     
       mov ah,01h              
       int 21h;输入
       mov dl,al
       sub al,30h            
       jl next;小于0
       cmp al,39h              
       jg next;大于9                
	   mov ah,0             
       xchg ax,bx            
       mov cx,10           
       mul cx                
       xchg ax,bx            
       add bx,ax;(bx)=(bx)*10+(ax)            
       jmp newchar;下一位
next:
       mov totalnum,bx
       call crlf
a10:
       mov dx,offset enter_name;输出提示
       mov ah,09h
       int 21h
       call input_name
       inc name_count;输入一个，name_count++
       call stor_name

       mov dx,offset enter_phone;输出提示
       mov ah,09h
       int 21h
       call inphone
       call stor_phone

       cmp name_count,0;一个都没有
       je exit
       mov bx,totalnum
       cmp name_count,bx;有没有输完
       jnz a10
       call name_sort;输完了，开始排序
 a20:
       mov dx,offset tip;要不要查找
       mov ah,09h
       int 21h
       mov ah,08h;输入
       int 21h
       cmp al,'y'
       jz  a30
       cmp al,'n';不找了，退出
       jz  exit
       jmp a20;都不是，重新问
 a30:
       call crlf
       mov dx,offset ask_name;要找谁
       mov ah,09h
       int 21h
       call input_name
 a40:
       call name_search
       jmp a20
 exit:
       mov ax,4c00h
       int 21h
 main endp
;--------------------------------------------------------------------
input_name proc near
       mov dx,offset tmpn;输入到缓冲区
       mov ah,0ah
       int 21h
       call crlf

       mov bh,0
       mov bl,tmpn+1
       mov cx,21
       sub cx,bx;cx为剩余字符
b10:
       mov tmpn[bx+2],' ';把后面的都替换
       inc bx
       loop b10
       ret
input_name endp
;--------------------------------------------------------------------
stor_name proc near
       mov  si,offset tmpn+2
       mov  cx,20
       rep  movsb
       ret
stor_name endp
;--------------------------------------------------------------------
inphone proc near
       mov dx,offset tmpp;输入到缓冲区
       mov ah,0ah
       int 21h

       call crlf
       mov bh,0
       mov bl,tmpp+1
       mov cx,9
       sub cx,bx;cx为剩余
c10:
       mov tmpp[bx+2],' ';替换
       inc bx
       loop c10
       ret
inphone endp
;--------------------------------------------------------------------
stor_phone proc near
       mov si,offset tmpp+2
       mov cx,8
       rep movsb;移到table
       ret
stor_phone endp
;--------------------------------------------------------------------
name_sort proc near;对名字排序
       sub di,28
       mov endaddr,di;结束位
c1:
       mov swapped,0
       mov si,offset table
c2:
       mov cx,20
       mov di,si;源给目的
       add di,28
       mov ax,di
       mov bx,si;cmpsb si-di  movsb di<-si
       repz cmpsb;
       jbe c3      
;chang order
       mov si,bx
       mov di,offset savenp
       mov cx,28
       rep movsb;把该信息移到暂存区
       mov cx,28
       mov di,bx
       rep movsb;把下一个移上来
       mov cx,28
       mov si,offset savenp
       rep movsb;把暂存区的移到后面
       mov swapped,1
 c3:
       mov si,ax
       cmp si,endaddr
       jb  c2;有没有比到结尾
       cmp swapped,0
       jnz c1;比较swapped是不是为0，该轮没有交换了
       ret
name_sort endp
;--------------------------------------------------------------------
name_search proc near
       mov bx,offset table
       mov flag,0;flag置零
d:
       mov cx,20
       mov si,offset tmpn+2
       mov di,bx
       repz cmpsb;比较
       jz  d2
       add bx,28 
       cmp bx,endaddr
       jbe d;没到尾,继续比
       sub flag,0;flag是不是为0，有没有找到
       jz nof
       jmp dexit             
nof:
       mov dx,offset nofind
       mov ah,09h
       int 21h
       call crlf;没找到
d2:
       mov searchaddr,bx
       inc flag;找到，++
       call printline
       add bx,28;下一条信息
       cmp bx,endaddr
       jbe d;是不是找完了
       jmp dexit;
       jnz d
dexit:
     ret
name_search endp
;--------------------------------------------------------------------
printline proc  near
       sub flag,0;flag是否为0，有没有找到
       jz  no
p10:
       mov ah,09h
       mov dx,offset show
       int 21h;打印标题
       mov cx,28
       mov si,searchaddr
       mov di,offset savenp
       rep movsb;移到savenp,便于输出
       mov dx,offset savenp
       mov ah,09h
       int 21h;打印转存的姓名电话
       jmp exit
no:    mov dx,offset nofind;没找到
       mov ah,09h
       int 21h
exit:
       ret
printline endp
;--------------------------------------------------------------------
crlf proc near 			 ;回车换行
	 mov dl,0dh
	 mov ah,02h
	 int 21h

	 mov dl,0ah
	 mov ah,02h
	 int 21h
	 ret
crlf endp
;--------------------------------------------------------------------
code ends
;--------------------------------------------------------------------
end main





