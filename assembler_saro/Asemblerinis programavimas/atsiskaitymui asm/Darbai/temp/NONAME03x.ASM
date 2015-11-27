stck segment stack
;description
db 256 dup(0)
stck ends   
            
data segment
            
;descriptions of constants and variables
a DB 5        
b DB 3        
c DB 1        
data ends     
;it's recomendet to put code segment in the end of program
code segment  
assume cs:code, ds:data, ss:stck
              
start:        
mov ax, data  
mov ds, ax    
              
mov al, a     
add al, b     
sub al, c     
              
add al, 30h   
              
mov dl, al    
mov al, 02h   
int 21h       
              
mov ah, 07h   
int 21h       
              
mov ah, 4ch   
int 21h       
              
code ends     
end start