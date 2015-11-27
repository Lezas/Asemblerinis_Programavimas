satck segment stack
db 128 dup(0)
satck ends
DATA segment
trys db 3  
du db 2 
a db 13 
b db 9 
c db 5   
desim db 10
result db 3 dup(' '),'$'   
DATA ends  
code segment
assume cs:code,ds:data,ss:satck
START:     
mov ax,data
mov ds,ax  
           
mov ax,02h 
int 10h    
           
mov ah, a
add ah, b
sub ah, c   
mul trys
div du  




mov result+2,ah
add result+2,30h
                
mov ah,0        
div desim       
mov result+1, ah
add result+1, 30h             
                 
mov ah,0 
div desim
mov result, ah
add result, 30h  
;mov dl,al        
mov ax,02h       
int 10h        
lea dx, result
mov ah, 09h
int 21h ;spauzdina            
;lea dx,a         
;lea dx,b         
                  
mov ah, 07h       
int 21h           
                
mov ah, 4ch
int 21h                
code ends   
end start



