ASSUME cs:text_,ds:data_

data_ SEGMENT
zonacit db 6,?,6 dup(?)

zece dw 10
;zecew dw 10

;pentru ca a, b > 0 si < 65535, le vom defini ca tipul word fara semn
a dw 0
b dw 0
R dw ?

data_ ENDS

text_ SEGMENT

start:
mov ax, data_
mov ds, ax

; Rezolvarea problemei

;citire a

mov ah, 0ah
mov dx, offset zonacit
int 21h
	
mov cl, byte ptr zonacit[1] ; in cl se salveaza nr concret de caract introduse (exlusiv enter)
mov ch, 0

mov si, 2 ; de aici incepe propriu-zis nr citit
mov ax, 0 ; in ax formam numarul citit a
crearenumar:
	mov bl, byte ptr zonacit[si]
	sub bl,'0' ; in bl este cifra convertita din ascii de pe pozitia curenta
	mul zece ; cand avem o noua cifra, ax se inmulteste cu 10 ca sa punem cifra unitatilor/zecilor/etc unde trebuie
	mov bh, 0
	add ax, bx
	inc si
loop crearenumar
mov a, ax
	
;citire b

mov ah, 0ah
mov dx, offset zonacit
int 21h
	
mov cl, byte ptr zonacit[1] ; in cl se salveaza nr concret de caract introduse (exlusiv enter)
mov ch, 0

mov si, 2 ; de aici incepe propriu-zis nr citit
mov ax, 0 ; in ax formam numarul citit b
crearenumar2:
	mov bl, byte ptr zonacit[si]
	sub bl,'0'
	mul zece
	mov bh, 0
	add ax, bx
	inc si
loop crearenumar2
mov b, ax

;calculare R	
mov cx, b
sub cx, a ; b-a
mov R, cx

; Terminarea programului
mov ax, 4c00h
int 21h
text_ ENDS

END start