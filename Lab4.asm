stck segment stack
DB 256 dup(0)
stck ends
data segment
tekstas DB 25,0, 25 dup(" ")
du db 2
data ends 
code segment
assume ds:data, cs:code, ss:stck
start :
mov ax,data
mov ds,ax
Ivedimas: 
mov ah, 0Ah
lea dx, tekstas
int 21h
Isvalymas :
mov ax, 0600h
mov bh, 07
mov cx, 0000
mov dx, 184Fh
int 10h
Kordinates: 
mov cx, 0
lea bx, tekstas+2
mov cl, tekstas+1
add bx,cx
mov al, '$'
mov [bx], al
mov ax, 80
sub ax,cx
div du
mov dl, al
mov dh, 12
mov ah, 02
int 10h
Isvedimas :
mov ah,09h
lea dx, tekstas
int 21h
mov ah, 4ch
int 21h
code ends
end start