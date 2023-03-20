assume ds:data, cs:code
data segment
	zonacit db 6,?,6 dup(?)
	zecew db 10
	a dw ?
	nr dw 0
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov dx,offset zonacit;facem citirea cu intr 0Ah
	mov ah,0Ah
	int 21h
	mov bl,byte ptr zonacit[1];salvam nr concret de elemente
	mov bh,0
	mov a,bx
	mov cx,a;de a ori
	mov si,2
	mov ax,0
crearenumar:
	mov bl,byte ptr zonacit[si]
	sub bl,'0'
	mul zecew
	add ax,bx
	inc si
loop crearenumar
	mov nr,ax
	mov cx,0;ptr loop
	mov ax,nr
	add ax,1
puneinstiva:
	mov dx,0
	div zecew
	push dx
	inc cx
	cmp ax,0
	JE printeaza
	JNE puneinstiva
printeaza:
	pop dx
	add dl,'0'
	mov ah,02h
	int 21h
loop printeaza
mov ax,4C00h
int 21h
code ends
end start

	