SSEG SEGMENT STACK
db 256 dup (?)              
ENDS SSEG                   

CR equ 13
LF equ 10                            

DSEG SEGMENT
ENDS DSEG

CSEG SEGMENT                                   
ASSUME cs:CSEG
              
START:        
mov ax, 0002h 
int 10h       
mov ax, 0F000h
mov ds, ax    
mov ah, 40h
mov bx, 1
mov cx, 8
mov dx, 0FFF5h
int 21h  
mov ah, 4Ch
int 21h  
ENDS CSEG
END START
