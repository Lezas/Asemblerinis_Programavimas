stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
pran db 'ats=','$'
a db 3   
b db 4   
des dw 10 
c dw ?,'$'
T db 5 dup (0),'$'
duomenys ends
programa segment
assume cs:programa, ds:duomenys,ss:stekas
start:    
mov ax,duomenys
mov ds,ax 
mov ax,02h
int 10h   
mov ah,09h
lea dx,pran
int 21h   
mov ax,0  
mov al,a  
mul b     
mov c,ax  
lea bx,T+4 ; i bx ikeliu paskutines vietos adresa
ciklas:   
div des   
add dl,30h ; butinai paverst liekanai
mov [bx],dl    ; liekana iekliu pagal adresa             
mov dl,0  
dec bx    
cmp al,0  
jne ciklas    
          
isvedimas:
mov ah,09h
lea dx,T  
int 21h 
  
mov ah,07h
int 21h   

mov ah,4ch
int 21h
programa ends
end start

