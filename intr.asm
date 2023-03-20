assume ds:data,cs:code
data segment
	;alocare spatiu pentru numarul care se va citi: nr1
	nr1 db 6,?,6 dup(?)
	zecew dw 10
	a dw ?
	nr dw 0
data ends
code segment
start:
		
	mov ax, data 
    mov ds, ax
	;citim numarul introdus
	mov ah, 0Ah
	mov dx, offset nr1
	int 21h
	mov bl, byte ptr nr1[1] ; in bl se salveaza nr concret de caract
	mov bh,0	
	mov a,bx;ne trebuie bx
	mov cx,a;de atatea ori se repeta structura loop
	mov si, 2; de la adresa 2 incepe spatiu alocat pt nr1
;unde se afla efectiv elementele
	mov ax, 0
crearenumar:
	mov bl, byte ptr nr1[si]
	sub bl,'0' ;pentru a transforma in cifra din caracter
	mul zecew; 
	add ax, bx;in ax formam numarul
	inc si
loop crearenumar
	mov nr,ax
	mov cx, 0
	mov ax, nr
	add ax, 1
calculeaza:
		mov dx,0
		div zecew
		push dx;pune in stiva
		add cx,1
		cmp ax,0
	JE printeaza
	JNE calculeaza
	printeaza:
		pop dx;scoate din stiva
		add dl,'0';transforma in caracter si apoi afiseaza pe ecran
		mov ah,02h
		int 21h
	loop printeaza
	
mov ax, 4C00h
int 21h
code ends
end start
