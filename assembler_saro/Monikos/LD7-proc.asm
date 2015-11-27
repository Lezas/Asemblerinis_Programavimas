stekas segment stack 
db 256 dup(?)        
stekas ends          
                     
duomenys segment     
liekana db 10,13,'Liekana'  
spel db 3 dup(' '),'$'
svd db 10,13,'Sveikioji dalis'
spes db 3 dup(' '),'$'

des db 10
a db 15
b db 13
c db 5
du db 2
trys db 3

tarp db 0
duomenys ends

programa segment
assume cs:programa,ds:duomenys,ss:stekas

ciklas proc
ciklas1:
mov ah,0   
div des    
add ah,30h 
mov [bx],ah
dec bx     
loop ciklas1
ret     
ciklas endp
      
      
start:   
      
mov ax, duomenys
mov ds, ax
      
formule:
mov al,a
mov bl,b
mov cl,c
add al,bl
sub al,cl
mov dl,du
mul dl
mov dl,trys
div dl
mov tarp,ah
      
spsv: 
lea bx,spes+2
mov cx,3
call ciklas


spl:
mov al,tarp
lea bx,spel+2
mov cx,3  
call ciklas

;isvedimas

mov ah,09h
lea dx,svd
int 21h 

lea dx,liekana
int 21h

mov ah,4ch
int 21h
                
programa ends
end start       




