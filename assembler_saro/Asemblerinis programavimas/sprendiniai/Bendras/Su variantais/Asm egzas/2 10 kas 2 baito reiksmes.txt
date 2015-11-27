stek segment stack 
db 256 dup(?)
stek ends

duom segment
 oa db 6,1,2,1,6,10,2,1,1,1,'*'
 vid db 0
 naujae db 13,10,'$'
 rez db 4 dup(0)
 des db 10
 cou db 0
duom ends

prog segment
 assume cs:prog, ds:duom, ss:stek
Start:
mov ax,duom
mov ds,ax

mov ax,02h
int 10h

mov al,0
mov bx,0
cklas:
 cmp oa[bx],'*'
 je tesiam
 
 add al,oa[bx]
 inc cou

 inc bx 
 cmp oa[bx],'*'
 je tesiam
 inc bx
 cmp oa[bx],'*'
 je tesiam
jmp cklas

tesiam:
         
xor ah,ah
mov al,al
div cou  
add al,30h
mov rez,al
         
mov al,ah
xor ah,ah
mov al,al
div des  
add ah,30h
mov rez+1,','
mov rez+2,ah
mov rez+3,'$'
            
mov ah,09h
lea dx,rez
int 21h        
          
mov ah,04Ch
int 21h   
          
prog ends 
end start