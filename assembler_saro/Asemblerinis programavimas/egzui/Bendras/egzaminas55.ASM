stekas segment stack                                             
        db 256 dup (?)                                           
stekas ends                                            
                                                                 
duomenys segment                 
        pran1   db 'Esemblerinio programavimo egzaminas',13,10
                db 'Aleksandr Kovaliov' ,13,10,'$'
        pran2	db 'Iveskyte pora simboliu',13,10,'$'
       	a dw 1  dup (9919h)
        b db 1  dup (0)                         
duomenys ends                                          
                                                       
programa segment                                            
assume cs:programa, ds:duomenys, ss:stekas
                                 
start:                           
                                 
mov ax,duomenys                     
mov ds,ax                        
                         
mov ax,02h                    ;isvalo ekrana
int 10h                  
                         
mov ah,09h                      ;spausdinam 1 pranesyma
lea dx,pran1             
int 21h                  
                         
MOV ah, 07h              
INT 21h                  
                         
mov ax,a                 
mov b,ah                 
                         
mov si,2                
mov b[si],'$'            
mov si,1                 
mov ah,09h                  
lea dx,b[si]             
int 21h                  
                         
MOV ah, 07h              
INT 21h                  
                         
MOV ah,4Ch               
INT 21h                              
                         
programa ends                       
end start