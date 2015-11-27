STEKAS SEGMENT STACK
	db 256 dup(?)
STEKAS ENDS
duom SEGMENT

pran1 db 'Iveskite savo varda ir pavarde: ',10,13,'$'
pran2 db 'Isvedimas:', 10, 13, '$'
pran3 db 10, 13, 'Simboliu skaicius: ', '$'
rez db '',10,'$'
dal db 10
ats db 253
db ?
db 255 dup (?), '$'
atv db 253 dup (?),'$'
n db 3 dup (?), 10,13,'$'
sk db 0

duom ends
prog segment
      
assume cs: prog, ds: duom, ss: stekas
start:
int 10h
mov ax, duom
mov ds, ax

xor ax, ax

isvedimas:
mov ah, 09h
lea dx, pran1
int 21h
   
mov ah, 0ah
lea dx, ats
int 21h
mov ah, 0
mov cl, ats+1
mov ch, 0h
lea si, atv
mov bx, cx
add bx, 1
mov ah, 0

ciklas:
mov al, ats[bx]
sub bx, 1
mov [si], al
inc si
inc sk
mov ah, 0
loop ciklas

mov al, '$'         
mov [si], al 
mov al, sk
mov si, 2

skaicius:
div dal
;paverciam koda i skaiciu
add ah, 30h
mov n[si], ah
dec si
mov ah, 0
cmp al, 0
je atsakymas
jmp skaicius

atsakymas:
mov ah, 09h
lea dx, rez
int 21h

mov ah, 09h
lea dx, pran2
int 21h
lea dx, atv
int 21h

mov ah, 09h
lea dx, pran3
int 21h
lea dx, n
int 21h
         
;sustabdo ekrana 
mov ah, 07h
int 21h
;grazina i operacine sistema           
mov ah, 4ch
int 21h  

prog ends
end start
