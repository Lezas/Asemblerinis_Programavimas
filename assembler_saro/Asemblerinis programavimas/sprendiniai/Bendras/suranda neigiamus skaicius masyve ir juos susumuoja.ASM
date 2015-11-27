stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
info db 'suranda neigiamus skaicius masyve ir juos susumuoja','$'
randam db 'neigiamu skaiciu yra ','$'
masyvas dw 1,6,-4,-7,-8,'$'
ats db 0,'$'
duomenys ends
programa segment
assume cs:programa,ds:duomenys,ss:stekas
start:
mov ax,duomenys
mov ds,ax
   
mov ax,02h                          
int 10h                             
mov ah,09h                          
lea dx,info                
int 21h
mov ah,07h                
int 21h   
      
mov ah,0
mov si,0
mov cl,5
ieskom: 
      
 cmp masyvas[si],0
 jl neig

  inc si
  inc si
  loop ieskom       
   neig:
  add ah,1
  inc si
  inc si
  loop ieskom               

add ah,30h
mov ats,ah
          
mov ax,02h                          
int 10h   
          
mov ah,09h
lea dx,randam
int 21h   
mov ah,09h
lea dx,ats
int 21h
                          
pabaiga:                  
mov ah,07h                
int 21h                                                                                                                                                 
mov ah,4ch                 
int 21h                   
programa ends             
end start