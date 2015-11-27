stck segment stack
db 256 dup (?)
stck ends

duomenys segment
a db 5
b db 3
c db 1
rez db 0, '$'
duomenys  ends
      
programa segment
assume cs:programa, ds: duomenys, ss:stck
      
start:
      
      
mov ax, duomenys
mov ds, ax
      
mov ax, 0002h
int 10h
      
mov ah, 0
mov al, a
add al, b
sub al, c
mov rez, al
add rez, 30h
      
mov ah, 09h
lea dx, rez
int 21h
      
mov ah, 07h
int 21h
      
mov ah, 4ch
int 21h
      
programa ends
         
end start