assume ds:data,cs:code
data segment
     s1 db 'abc0def'    ;sirul initial
     d equ $-s1        ;dim. sir initial
     s2 db d dup(?)    ;sir rezultat
data ends
code segment
start:
     mov ax,data
     mov ds,ax
     mov es,ax
     mov si,offset s1
     mov di,offset s2
     cld        ;parcurgere de la adr. mai mica la adr. mai mare
     mov cx,d
again:
     lodsb
     cmp al,'0'
     je dupa
     stosb        ;daca nu e '0', se incarca in s2
loop again
dupa:
     mov cx,offset s1
     add cx,d
     sub cx,si
     add cx,1    ;...pt. restul pozitiilor
     ;puteti sa gasiti o varianta mai rapida
     mov al,'Z'
     jcxz sf
rep stosb
sf:
     mov ax,4C00h
     int 21h
code ends
end start
