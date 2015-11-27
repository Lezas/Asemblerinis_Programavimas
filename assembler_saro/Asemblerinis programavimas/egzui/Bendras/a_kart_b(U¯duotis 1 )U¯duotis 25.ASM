stekas segment stack                              
db 256 dup(?)                                     
stekas ends                                       
duomenys segment
pran1 db 'formule: X=a*b',10,13,'$' 
pran2 db 'x=','$'
a dw 100                                          
b dw -21                                         
des dw 10                                         
x dw 0                                            
rez dw 5 dup (0),'$'                                   
duomenys ends                                     
programa segment                                  
assume cs:programa, ds:duomenys, ss:stekas        
start:                                                                         
mov ax,duomenys                                   
mov ds,ax    
                                                                     
 mov ax,0002h                                     
 int 10h                                          
        
 mov ah,09h
 lea dx,pran1
 int 21h
                                         
 mov ax,a                                         
 imul b                                            
 
                                                    
 lea bx,rez+4                                      
 mov cx,4 
 ciklas:                                          
 div des                                          
 add dx,30h 
 mov [bx],dl
 mov dx,0   
 dec bx     
 loop ciklas
 mov rez,2dh
            
 mov ah,09h 
 lea dx,pran2
 int 21h    
 lea dx,rez 
 int 21h    
            
mov ah,4ch               
 int 21h                 
 programa ends           
 end start