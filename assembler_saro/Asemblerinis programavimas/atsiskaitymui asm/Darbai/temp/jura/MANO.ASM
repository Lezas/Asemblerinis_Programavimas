stck segment stack
db 256 dup(0)
stck ends    
data segment 
du db 2       
keturi db 4       
a db 13      
c db 5      
rez db 0, '$' 
rez2 db 0, '$'   
          
          
data ends    
code segment 
assume cs:code, ds:data, ss:stck
start:       
mov ax, data 
mov ds, ax
mov ax, 0002h
int 10h
mov ah, 0
   
mov al, a    
mul b        
add al, c    
div d
        
mov rez, al
mov rez2, ah
       
add rez,30h
mov ah, 09h
lea dx, rez 
int 21h 
      
add rez2, 30h     
lea dx, rez2              
int 21h                   
mov ah, 4ch
int 21h    
code ends  
end start  
           
      
      
