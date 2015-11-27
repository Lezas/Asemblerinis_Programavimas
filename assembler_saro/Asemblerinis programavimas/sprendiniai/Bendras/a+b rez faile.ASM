stekas segment stack
db 256 dup(0)
stekas ends
duomenys segment 
a db 2,?
b db 2,?
file db 'C:\Tasma\temp\rezultatai.txt',0
aived db 'Iveskite a',10,13,'$'
bived db 'Iveskite b',10,13,'$'    
ats db 0,'$'                                
sveik db 0,'$'
liek db 0 .'$'
duomenys ends
programa segment
assume cs:programa,ds:duomenys,ss:stekas
start:
mov ax,duomenys
mov ds,ax

mov ax,02h
int 10h

mov ah,09h
lea dx, aived
int 21h
mov ah,0ah
 lea dx,a
 int 21h 
 
 mov ah,09h
 lea dx,bived
 int 21h
 mov ah,0ah
 lea dx,b
 int 21h
 mov cl,10  
 mov al,a 
 mov bl,b 
 add al,bl
 mov ah,0 
          
 div cl
 add al,30h
 mov sveik,al
 add ah,30h
 mov liek, ah
 
 mov ah,09h
 lea dx,sveik
 int 21h
 mov ah,09h
 lea dx,liek
 int 21h
 
 mov ah,07h
 int 21h
 mov ah,4ch
 int 21h
 programa ends
 end start