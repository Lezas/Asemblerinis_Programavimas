.MODEL SMALL
.STACK
.DATA

MsgA db 'Arturas Janulis II-08/1$'
MsgT db 'Teigiamas!$'
MsgN db 'Neigiamas!$'

a dw 33768
b dw 9300
c dw 5

.CODE

START:

;Autoius

mov ax, seg MsgA
mov ds, ax
mov dx, offset MsgA
call PrintString 
call NewLine

;f = a-5b, f = a-cb (c = 5)

mov bx, a
mov ax, b
mul c
sub bx, ax
mov ax, bx

;Teigiamas Ar Neigiamas?

cmp ax, 0
push ax
jl  N
jmp T

T:
mov ax, seg MsgT
mov ds, ax
mov dx, offset MsgT
call PrintString 
call NewLine
pop ax
jmp S

N:
mov ax, seg MsgN
mov ds, ax
mov dx, offset MsgN
call PrintString 
call NewLine

;Abs(ax)

pop ax
mov bx, 65535
sub bx, ax
mov ax, bx
inc ax

push ax

mov dx,'-'
call PrintChar
xor dx, dx

pop ax

;Steko sukurimas
S:

mov cl,10    
mov bx, 0
Repeat:
mov dx,0     
div cx       
add dl, 30h
push dx
inc bx
cmp ax,0
jne Repeat

;Steko isvedimas

P:
cmp bx, 0
je  E
pop dx
call PrintChar
dec bx
jmp P
E:

;Pabaiga
call EndProgram

NewLine proc
    push dx
    mov dl, 0dh
    mov ah, 2
    int 21h                           
    mov dl, 0ah
    mov ah, 2
    int 21h 
    pop dx
    ret
NewLine endp

PrintChar proc
    mov ah,02h            
    int 21h
    ret
PrintChar endp

PrintString proc
    mov ah, 09h
    int 21h
    ret
PrintString endp 

EndProgram proc
    mov ax, 0100h
    int 21h
    mov ax, 4c00h
    int 21h
    ret
EndProgram endp

END START