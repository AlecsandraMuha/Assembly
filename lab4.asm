assume ds:data,cs:code
data segment
	sir1 dd 12340578h, 1A2B3C4Dh, 0FE37DC76h
    lens equ($-sir1) / 4
    sir2 dw lens*2 dup(?)
data ends
code segment
start:
	mov ax, data ; incarcam adresa segmentului de date in resgistrul ds
    mov ds, ax
    add si, lens*4-4
    mov di, 0
    mov cx, lens
    repeta:
        mov ax, word ptr sir1[si]
        mov dx, word ptr sir1[si + 2]
        mov word ptr sir2[di + 0], ax
        mov word ptr sir2[di + 2], dx
        sub si, 4
        add di, 4
    loop repeta
    mov ax, 4c00h ; terminam programul
    int 21h
code ends
end start
