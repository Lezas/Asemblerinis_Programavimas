.MODEL SMALL
.STACK
.DATA

Msg  db 'Tai yra stringas$'

.CODE

START:

mov ax, seg Msg
mov ds, ax

xor ax, ax
xor si, si
xor cx, cx

loop1:

mov al,ds:[si] 

inc si
inc cx
cmp al,'$'

je exit

mov dl, al
push dx
jmp loop1
exit:

pop dx

loop2:
mov ah, 02h
int 21h
pop dx
loop loop2

mov ax, 0100h
int 21h

mov ax, 4c00h
int 21h

END START