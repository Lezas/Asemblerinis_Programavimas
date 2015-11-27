stekas segment stack                                            
db 256 dup(?)                                                   
stekas ends                                                     
                                                                
duomenys segment	                                        
       vardas db 25 dup (' '), '$'                              
       pavarde db 25 dup (' '), '$'
       ived db 25,?,25 dup('?')
       	                                                        
pran    db 13,10                                                
        db 'vardas ir pavarde...',13,10, '$'
pran3  	db ,13,10,'$'                                           
du db 2                                                         
                                                                
duomenys ends                                                   
programa segment                                                
assume cs:programa, ds: duomenys, ss:stekas                     
start:                                                          
	mov ax, duomenys                                        
	mov ds,ax                                               
	                                                        
      	mov ax, 0002h                                           
       	int 10h                                                 
                                                                
; pranesimo isvedimas:                                          
       mov ah,02                                                 ;nustatomas kursorius
       mov bh,00                                                
       mov dh,03                                                
       mov dl,33                                                
       int 10h                                                  
            
       mov ah,09h
       lea dx, pran                                             
       int 21h                  
                                                         	
;vardo ivedimui                                                 
mov ah, 0Ah                                                     
lea DX, ived                                                    
int 21h                                                         
                                                                
mov al,80
sub al,ived+1                                                   
mov ah,00                                                       
div du                                                          
                                                                
mov ah,02                                                       
mov bh,00                                                       
mov dh,08                                                       
mov dl,al                                                       
int 10h                                                         
                                                                
mov ah,00                                                       
mov al,ived+1                                                   
mov si,2                                                        
add si,ax                                                       
                                                                
mov ived[si],'$'                                                
                                                                
mov ah, 09h                                                     
lea dx, ived+2                                                  
int 21h       	                                                
      	                                                            
      	mov ah, 07h                                             
	int 21h                                                 
	mov ah,4ch                                              
	int 21h                                                 
programa ends                                                   
end start