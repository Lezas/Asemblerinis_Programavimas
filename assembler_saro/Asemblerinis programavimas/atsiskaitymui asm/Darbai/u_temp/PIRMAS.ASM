stekas segment stack
db 512 dup (0)
stekas ends
         
duomenys segment
pranesimas db 'pirmas',13,10,'$'
sk db 255
mas db 3 dup (0),'$'
des db 10
duomenys ends
         
programa segment
assume ss:stekas, ds:duomenys, cs:programa
         
start:   
mov ax, duomenys 
;mov dx, ax       
mov ds, dx
mov ax, 02h
int 10h  
mov ah, 07h
int 21h  
mov ah, 0
mov al, sk
div des  
add ah, 30h
mov mas+2, ah
mov mas, ah
mov ah, 0

div des  
add ah, 30h
mov mas+1, ah
mov ah, 0
div des  
add ah, 30h
mov ah, 0
lea dx, mas 
mov ah, 09h
int 21h  
mov ah, 4ch
int 21h  
programa ends
END START