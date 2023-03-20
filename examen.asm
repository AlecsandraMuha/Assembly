assume cs:code,ds:data
data segment
	s db 50,?,50 dup(?)
	newline db 10,13,'$'
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov ah,0ah
	mov dx,offset s
	int 21h
	mov ah,02h
	mov dl,newline
	int 21h
	mov cl,byte ptr s[1]
	mov ch,0
	mov si,3
repeta:
	mov bl,byte ptr s[si]
	cmp bl,'0'
	JAE compara
	JB myendif
compara:
	cmp bl,'9'
	JBE inlocuire
	JA myendif
inlocuire:
	mov al,'%'
	mov byte ptr s[si],al
	inc si
	jmp repeta
myendif:
	mov byte ptr s[si],bl
	inc si
loop repeta
mov al,'$'
mov byte ptr s[si],al
mov ah,09h
mov dx,offset s
int 21h
mov ax,4c00h
int 21h
code ends
end start
	
