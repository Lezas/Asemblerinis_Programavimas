;Programa skaiciuoja funkcija x=(2a+b)-c
stekas segment stack                              
db 256 dup(?)                                     
stekas ends                                       
                                                  
duomenys segment                                  
pran  	db 'Atsakymas yra:','$'
a db 3                           
b db 5                                            
c db 6                                            
ats db 4 dup (?),'$'  
dal db 10                        
duomenys ends                                     
                                                  
programa segment                                  
assume cs:programa, ds:duomenys, ss:stekas        
start:                                            
mov ax,duomenys                                   
mov ds,ax           
                    
;ekrano valymas              
mov ax,0002h              
int 10h              
                    
        mov ah,09h  
        lea dx,pran                              
        int 21h                             
                                                  
mov al,a              
add al,a              
add al,b              
sub al,c              
                                                  
mov ah,0                                         
        mov cx,4                 
        lea si,ats+3
        mov ah,0    
                                                                           
cikl:  div dal                     
       add ah,30h                
       mov [si],ah               
       dec si                    
       mov ah,0                      
       loop cikl                 
                                 
                                 
        mov ah, 09h              
        lea dx,ats  
       	int 21h                                           
;laukia klaviso paspaudimo     
          mov ah, 07h                         
          int 21h              
;-grizhta i DOS                
                                                                 
mov ah,4ch                                        
int 21h                                           
programa ends                                     
end start