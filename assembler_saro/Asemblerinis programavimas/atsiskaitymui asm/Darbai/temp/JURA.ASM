STCK segment stack
db 256 dup (?)
STCK ends    
             
duomenys segment
a db 8       
b db 7       
c db 1
d db 10       
rez db 0, '$'
duomenys ends
         
programa segment
assume cs:programa, ds:duomenys, ss:STCK
start:       
mov ax, duomenys
mov ds, ax   
;clear screen
mov ax, 0002h 
int 10h      
             
mov ah, 0    
mov al, a    
add al, b    
sub al, c
div d    
mov rez, al
mov rez+1, ah  
add rez, 30h
add rez+1, 30h
 
             
;print message
mov ah, 09h  
lea dx, rez  
int 21h      
             
; press any key
mov ah, 07h  
int 21h      
;returns to DOS, exits program
mov ah, 4ch  
int 21h      
             
programa ends
end start    
             
