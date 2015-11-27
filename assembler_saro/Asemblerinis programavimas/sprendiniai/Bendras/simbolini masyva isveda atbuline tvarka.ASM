stekas segment stack
db 256 dup(?)
stekas ends
duomenys segment 
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'   
tek db '9876543210',10,13,'$'
rez db 11 dup(?),'$'      
duomenys ends             
programa segment          
assume cs:programa, ds:duomenys, ss:stekas
start:                    
mov ax, duomenys          
mov ds, ax                       
lea bx,tek               
lea si,rez                
add si,10                 
mov cx,10                
                          
cikl:                     
mov ah,[bx]               
mov [si],ah               
inc bx                    
dec si                    
loop cikl                 
                          
;ekrano valymas           
mov ax,02h                
int 10h
;kursoriaus
mov ah,09h
lea dx,pran
int 21h
mov ah,02h
mov bh,00
mov dh,12
mov dl,35
int 10h 
;dar isvedimas
mov ah,09h
lea dx,rez
int 21h                  
;ekrano uzlaikymas        
mov ah,07h 
int 21h                 
;programos baigimas
mov ah, 4ch
int 21h    
programa ends
end start