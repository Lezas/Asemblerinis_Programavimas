stekas segment stack
db 256 dup(0)
ends stekas
t equ 13
d equ 10
duomenys segment
aSritis db 10,?
a db 7 dup(?),'$'
bSritis db 10,?
b db 7 dup(?),'$'
prana db t,d,'Iveskite a=','$'
pranb db t,d,'Iveskite b=','$'
ats db t,d,'atsakymas: ab=','$'
desimt db 10
rez db 5 dup(?),'$'
ends duomenys
Programa segment
assume  ds:duomenys,ss:stekas,cs:programa
Start: mov ax,duomenys
mov ds,ax
mov ax,0002h
int 10h
mov ah,09 ;a ivedimas
lea dx,prana
int 21h
mov ah,0Ah ;isimena a
lea dx,aSritis
int 21h
mov ax,0
mov bx,0
lea bx,aSritis+2
sub aSritis+2,30h
mov al,aSritis+2
mov cx,0
mov cl,aSritis+1
dec cx
L1: cmp cx,0
je baigtA
mul desimt
inc bx
sub byte ptr[bx],30h
add ax,[bx]
loop L1
baigtA: mov a,al
mov ah,09h ;b ivedimas
lea dx,pranb
int 21h
mov ah,0Ah ;isimena b
lea dx,bSritis
int 21h
mov ax,0
mov bx,0
lea bx,bSritis+2
sub bSritis+2,30h
mov al,bSritis+2
mov cx,0
mov cl,bSritis+1
dec cx
L2: cmp cx,0
je baigtB
mul desimt
inc bx
sub byte ptr[bx],30h
add ax,[bx]
loop L2
baigtB: mov b,al
mov ax,0
mov bx,0
mov al,a
mov bl,b
mul bx
mov cx,5
mov bx,0
lea bx,rez+4
L3: div desimt
add ah,30h
mov [bx],ah
mov ah,0
dec bx
loop L3
mov ah,02h
mov dx,0505h
int 10h
mov ah,09h
mov dx,0
lea dx, ats
int 21h
mov ah,09h
mov dx,0
lea dx,rez
int 21h
mov ah,07h
int 21h
mov ah,4ch
int 21h
ends programa
end start
