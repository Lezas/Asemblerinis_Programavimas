stekas segment stack
db 256 dup(?)
stekas ends
duomenys segment
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'
x db 2     
y db 5     
z db 6     
f db ?     
T1 db 4 dup(' ') ,'$'
des db 10    
duomenys ends   
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:       
mov ax, duomenys
mov ds, ax 
           
mov al,x   
add al,y   
imul z     
mov f,al   
lea bx, T1+3;keliam T1 adresa i bx
mov cx,4   
ciklas:    
div des    
add ah, 30h
mov [bx],ah; i atminies lastele iraso ah
mov ah,0   
cmp al,0 
je toliau
dec bx       
loop ciklas
toliau:  
;ekrano valymas
mov ax,02h
int 10h  
;isvedimas 
mov ah,09h
lea dx,pran
int 21h  
         
mov ah,09h 
lea dx,T1
int 21h                
;ekrano uzlaikymas
mov ah,07h 
int 21h                 
;programos baigimas
mov ah, 4ch
int 21h   
programa ends
end start