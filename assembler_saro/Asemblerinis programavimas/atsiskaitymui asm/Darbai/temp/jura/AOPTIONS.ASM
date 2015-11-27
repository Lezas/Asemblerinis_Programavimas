stck segment stack
db 256 dup(0)
stck ends
data segment
a db 5
b db 3
c db 1
data ends
code segment
assume cs:code, ds:data, ss:stck
start:
mov ax, data
mov ds, ax
mov al, a
add al, b
sub al, c


add al, 30h
mov dl,al
mov ah, 02h
int 21h
mov ax, data
mov ds, ax
mov ah, 07h
int 21h
mov ah, 4ch
int 21h
code ends
end start

