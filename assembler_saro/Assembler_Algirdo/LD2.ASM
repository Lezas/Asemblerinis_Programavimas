stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS

duomenys SEGMENT
a DB 127
b DB 13
c DB 0
duomenys ENDS

programa SEGMENT
ASSume CS:programa, DS:duomenys, ss:stekas
START: mov ax,duomenys
        mov ds,ax
mov al,a
mov bl,b               
add al,bl                
mov c,al 
mov ah,4ch                
int 21h



programa ends
end START