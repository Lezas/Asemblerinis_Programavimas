 STEKAS SEGMENT STACK
    db 255 dup(?)
STEKAS ENDS
         
duom SEGMENT
rez db '',10, '$'
dal db 10
ats db 253
db (?)  
db 255 dup (?), '$'
pran db '', 10, '$'
pran1 db 'Isvedimas: ', '$'
pran2 db 'Iveskite pavarde ir varda: ', '$'          
atv db 253 dup (?), '$'             
n db 3 dup (?), 13,10, '$'          
                                    
duom ends                           
                                    
progr segment                       
    assume cs:progr, ds:duom, ss:stekas
                                    
start:                              
  int 10h                           
  mov ax, duom                      
  mov ds,ax                         
                                    
xor ax, ax                          
mov si, 0                          
                                    
mov ah, 09h                         
lea dx, pran2                       
int 21h                             
                                   
mov ah, 0ah                        
lea dx, ats                        
int 21h                            
                                   
mov ah, 0                          
mov cl, ats+1                      
mov ch, 0h                         
lea si, atv  
mov bx, cx
mov bx, 1                     
mov ah, 0                          
                                   
cikl:                              
add bx, 1                          
mov al, ats[bx]
mov [si], al                       
inc si                             
mov  ah, 0
sub bx, 1                         
loop cikl                          
                                   
isvedimas:                               
mov ah, 09h  
lea dx, pran
int 21h      
             
mov ah, 09h  
lea dx, pran1
int 21h      
             
mov ah, 09h  
lea dx, rez  
int 21h      
             
mov ah, 09h  
lea dx, atv  
int 21h      
             
mov ah, 07h     
int 21h           
mov ah, 4ch     
int 21h      
             
progr ends   
end start