.MODEL SMALL
.STACK
.DATA

MsgL db 'Lyginis$'
MsgN db 'Nelyginis$'
Msg  db 'Iveskite Skaiciu: $'

.CODE

START:

mov ax, seg Msg
mov ds, ax
mov dx, offset Msg

mov ah, 09h
int 21h

mov ah, 02h

mov dl, 0Dh
int 21h
mov dl, 0Ah
int 21h

mov ah, 01h
int 21h

sub al, 30h
mov ah, 0

push ax

mov ah, 02h

mov dl, 0Dh
int 21h
mov dl, 0Ah
int 21h

mov ah, 01h
int 21h

sub al, 30h
mov ah, 0

mov bl, al

pop ax

div bl

cmp ah, 0

mov ah, 02h

mov dl, 0Dh
int 21h
mov dl, 0Ah
int 21h

je lyginis
jmp nelyginis

lyginis:
mov ax, seg MsgL
mov ds, ax
mov dx, offset MsgL

mov ah, 09h
int 21h

jmp pabaiga

nelyginis:
mov ax, seg MsgN
mov ds, ax
mov dx, offset MsgN

mov ah, 09h
int 21h

pabaiga:

mov ax, 0100h
int 21h

mov ax, 4c00h
int 21h

END START