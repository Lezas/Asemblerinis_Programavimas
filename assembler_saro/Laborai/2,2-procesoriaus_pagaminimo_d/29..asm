STEKAS SEGMENT STACK
	db 256 dup(?)
STEKAS ENDS
duom SEGMENT

pran1 db 10, 13, 'Atliko: ingrida ', 10, 13,'$'
pran2 db 'Procesoriaus pagaminimo data', 10, 13, '$'

duom ends
progr segment
assume cs: progr, ds: duom, ss: stekas
start:
mov ax, duom
mov ds, ax

mov ah, 09h	
lea dx, pran1	
int 21h

mov ah, 09h
lea dx, pran2
int 21h

mov ax, 0f000h
mov ds, ax
mov ah, 40h
mov bx, 1
mov cx, 8
mov dx, 0fff5h
int 21h
mov ax, 4c00h
int 21h

mov ah, 07h
int 21h


progr ends
end start
