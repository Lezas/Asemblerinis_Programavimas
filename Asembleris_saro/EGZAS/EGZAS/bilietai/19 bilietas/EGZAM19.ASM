stekas segment stack                 
       db 256 dup (?)                
stekas ends                          
                                     
duomenys segment                     
       vardas db 10,13,'Atliko Dimitrianas Kondrasovas $'
       input db 10,13,'Iveskite $'
       TInput db 97,' $'            ;kad isvedinetu vis kita simboli pranesime
       buf db 5, 5 dup (?),'$'   
       a db 0                    
       b db 0                    
       c db 0
       skaicius db 0,'$'         
       det db 10,'$'             
duomenys ends                    
                                                         
programa segment                                         
assume cs:programa, ds:duomenys, ss:stekas               
start:                                                   
mov ax, duomenys                                    
mov ds, ax                                          
                                                    
mov ax, 0002h                                       
int 10h                                             
                                                    
mov ah, 09h                                         
lea dx, vardas                                      
int 21h                                                         
                                  
inputas:                         
cmp tinput, 99                  
je  exit    
mov ah, 09h                       
lea dx, input                    
int 21h                          
mov ah, 09h                      
lea dx, Tinput                   
int 21h                          
jmp ivedimas                      
                                  
ivedimas:                         
                                                    
mov ah, 0Ah                          
lea dx, buf                          
int 21h                                                    
inc tinput                           
mov bl, buf[1]                       
                                     
nextas:                              
mov skaicius, 0                  
mov si, 0                            
mov cx, 0                            
mov ax, 0                            
ascii:                           
mov cl, buf[si+2]                    
sub cl, 30h                          
mov al, skaicius                     
mul det                              
add al, cl                      
mov skaicius, al                
                                
inc si                          
dec bl                          
cmp bl, 0                       
je tikrinu                      
jmp ascii                       
                                
tikrinu:                        
inc di     
jmp savedigit   
                
savedigit:      
mov dx, 0  
cmp di, 1  
je adigit       
jmp bdigit      
adigit:         
mov al, skaicius
mov a, al       
jmp inputas     
bdigit:         
mov dl, skaicius
mov b, dl  
           
formula:   
mov ax, 0  
mov dl, b  
mov al, a  
mul dl     
div det    
mov c, al          
jmp inputas
           
exit:                                                    
mov ah, 07h                                         
int 21h                       
mov ah, 4ch                   
int 21h                                                         
                              
programa ends                 
end start  