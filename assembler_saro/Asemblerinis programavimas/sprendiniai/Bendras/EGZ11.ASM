stekas segment stack                                             
        db 256 dup (?)                                           
stekas ends                                                   
                                                                 
duomenys segment                                              
        pran1   db 'Esemblerinio programavimo egzaminas',13,10
                db 'Aleksandr Kovaliov' ,13,10,'$'            
        pran2	db 'Iveskyte pora simboliu',13,10,'$'         
       	a db 2,?,3  dup (?),'$'                               
        b db 2,?,3  dup (?),'$'                               
        c db 2  dup (0),'$'                                   
duomenys ends                                                 
                                                              
programa segment                                              
assume cs:programa, ds:duomenys, ss:stekas                    
                                                              
start:                                                        
                                                              
mov ax,duomenys                                               
mov ds,ax                                                     
                                                              
mov ax,02h                     	;isvalo ekrana                
int 10h                                                       
                                                              
mov ah,09h                      ;spausdinam 1 pranesyma       
lea dx,pran1                                                  
int 21h                                                       
                                                              
MOV ah, 07h                                                   
INT 21h                                                       
                                                              
mov ax,02h                    	;isvalo ekrana                
int 10h                                                       
                                                              
mov ah,0Ah                    	;ivedam a                     
lea dx,a                                                      
int 21h                                                       
                                                              
mov ax,02h                    	;isvalo ekrana                
int 10h                                                       
                                                              
mov ah,0Ah                  	;ivedam b                     
lea dx,b                                                      
int 21h                                                       
                                                              
mov ax,02h                    	;isvalo ekrana                
int 10h                                                       
                                                              
;mov ah,a                                                     
sub a+2,30h
;mov a,ah                                                 
                                                         
;mov ah,b                                                 
sub b+2,30h
;mov b,ah                                                 
                                                         
mov al,12
div a+2
div b+2
add al,30h
mov c,al 
                                            
mov ah,09h                                               
lea dx,c                                                 
int 21h                                                  
                                                         
MOV ah, 07h                                              
INT 21h                                                  
                                                         
MOV ah,4Ch                                               
INT 21h                                                  
                                                         
programa ends                                            
end start