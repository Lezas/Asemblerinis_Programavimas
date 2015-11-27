stekas segment stack 
db 256 dup(?)        
stekas ends          
                     
duomenys segment     
origp db '$','samaduailetsupokaiksikisap'  
tekstp db 10,13,27 dup(0)
duomenys ends

programa segment
assume cs:programa,ds:duomenys,ss:stekas
start:     
mov ax,duomenys
mov ds,ax
lea si,origp+27
mov ah,'$'     
lea di,tekstp+2
prad:          
dec si         
cmp [si],ah    
je spau          
mov al,[si]    
mov [di],al
inc di
jmp prad
spau:
mov [di],ah
mov ah,09h
lea dx, tekstp
int 21h
pabaiga:
mov ah,4ch
int 21h
programa ends
end start