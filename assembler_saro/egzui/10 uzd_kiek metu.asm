;.386
stekas segment stack ;use16
db 256 dup (?)        
stekas ends          
                     
duom segment ;use16
ppran db 'darba atliko Aleksandras Nikoncukas', 10,13, '$'
pran1 db 10,13, 'programa apskaiciuos kiek jums dabar yra metu', 10,13, '$'
pran2 db 'iveskite savo gimimo metus',10,13,'$'
pran3 db 'Jums dabar yra: ',10,13,'$'                                       
pran4 db 'jus nezinote kada gimete? tai cia jusu problemos!!',10,13,'$'
a dw 2006, '$'               
metai dw 0, '$'         
ats dw ?, '$'           
ats_ok db 3 dup(?), '$'
tukst dw 1000           
simt db 100             
desimt dw 10            
klava db 5,?,5 dup(?), '$'
duom ends                                       
                                                
prog segment ;use16      
start:                                          
assume ss:stekas, ds:duom, cs:prog              
                                                
mov ax, duom                                    
mov ds, ax                                      
                                                
mov ax, 0002h                                   
int 10h                                         
                                                
lea dx, ppran               
mov ah, 09h                 
int 21h                     
                            
lea dx, pran1               
mov ah, 09h                 
int 21h                     
                     
mov ah, 07h       
int 21h           
                  
mov ax, 0002h     
int 10h           
                  
lea dx, pran2     
mov ah, 09h       
int 21h           
xor ax,ax 
mov ah, 0ah
lea dx, klava     
int 21h           
xor ax, ax        
                       
sub klava+2, 30h  
mov al, klava+2
mul tukst            
mov metai, ax     
xor ax, ax    
             
sub klava+3, 30h  
mov al, klava+3  
mul simt          
add metai, ax  

xor ax, ax
         
sub klava+4, 30h
mov al, klava+4
mul desimt     
add metai, ax 
 
xor ax, ax
             
sub klava+5, 30h
mov al, klava+5
add metai, ax  
                  
cmp metai, 0
je n_metai 
jmp skaic  
                     
n_metai:
mov ah, 02h
int 10h 
         
lea dx, pran4    
mov ah, 09h      
int 21h          
jmp end2
        
xor ax,ax           
skaic:           
mov ax, a         
sub ax, metai    
                 
mov si, 2        
mov dx, 0            
ciklas:              
div desimt           
add dl, 30h          
mov ats_ok[si], dl   
mov dx, 0            
cmp al, 0            
je endas             
dec si               
jmp ciklas           
                     
endas:                 
mov ax, 0002h        
int 10h                 
xor dx,dx                        
lea dx, pran3           
mov ah, 09h             
int 21h                 
xor dx, dx                 
lea dx, ats_ok   
mov ah, 09h      
int 21h
jmp end2
     
end2:                  
mov ah, 07h      
int 21h          
                 
mov ah, 4ch
int 21h          
                 
prog ends        
        end start