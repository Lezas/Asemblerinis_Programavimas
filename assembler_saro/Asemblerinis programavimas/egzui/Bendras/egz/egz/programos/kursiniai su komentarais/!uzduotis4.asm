stekas segment stack
db 256 dup(?)
stekas ends
duomenys segment
crlf db 13,10,'$'
procent dq 1.03
galut_suma dd 0
suma dq 24.0
skaitliukas dw 375
simtas dq 100.0
desimt dd 10
ats db 11 dup(?),'$'
aut db 'Atliko: Giedre Bruzaite, II-2/4',13,10,10,'$'
dol db ' doleriu.',13,10,'$'
pran db 'indenai po tiek metu gautu:',13,10,'$'
duomenys ends
programa segment
assume CS:programa, DS:duomenys, SS:stekas
.386
start:
mov AX, duomenys
mov DS, AX
mov ax, 0002h
int 10h
mov cx, skaitliukas
fld suma
jcxz toliau
ciklas:
fmul procent
loop ciklas
toliau:
fmul simtas
fistp galut_suma
mov eax, galut_suma
mov edx, 0
mov si, 10
desimtaine:
div desimt
add dl,30h
mov ats[si], dl
dec si
xor dx,dx
cmp al, 0
je pabaiga
cmp si, 8
je kablelis
jmp desimtaine
kablelis:
mov ats[si],2ch
dec si
jmp desimtaine
pabaiga:
mov ah, 09h
lea dx, aut
int 21h
mov ah, 09h
lea dx, pran
int 21h
mov ah, 09h
lea dx, crlf
int 21h
mov ah, 09h
lea dx, ats
int 21h
mov ah, 09h
lea dx, dol
int 21h
mov ah, 4ch
int 21h
programa ends
end start

