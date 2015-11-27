stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
atliko db 'Darba atliko Ruta Jasulaityte II-3.2', 10, 13
db 'Programa skaciuoja funkcija (a*a+b*b)*d*c', 13,10, '$'
atsakymas1 db '(a*a+b*b)*d*c=','$'
a dw 2
b dw 1
c dw 2
d dw 2
rez db 0
duomenys ends
programa segment
assume cs: programa, ds: duomenys, ss: stekas
start:
mov ax, duomenys
mov ds, ax
; ekrano valymas
mov ax, 02h
int 10h  
; isvedame i ekrana
mov ah, 09h
lea dx, atliko
int 21h 
mov ah, 09h
lea dx, atsakymas1
int 21h     

; skaiciavimai
mov ax, a
mov bx, a
mul bx   
mov bx, ax
mov ax, b
mul b    
add ax,bx
mul c    
mul d  
mov rez,ax
add al,30h
mov rez,al
  
mov ah, 09h
lea dx,rez   
int 21h
     
; praso klaviso paspaudimo
mov ah, 07h
int 21h  
; uzbaigia
mov ah, 4ch
int 21h  
programa ends
end start