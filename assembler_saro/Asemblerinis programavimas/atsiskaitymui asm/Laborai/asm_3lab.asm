stck segment stack
db 128 dup(0)
stck ends
data segment
a db 5 
b db 3
c db 1
DATA ends
code segment
assume cs:code,ds:data,ss:stck
START:
mov ax,data
mov ds,ax

mov ax,02h
int 10h

mov al, a
add al, b
sub al, c
add al, 30h

mov dl,al
mov ah,02h
int 21h

;lea dx,a
;lea dx,b

mov ah, 07h
int 21h

code ends
end start