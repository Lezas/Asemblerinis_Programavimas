;----------2proga.asm--------------------
;---------(a*a+b*b)+grNr-------------------
;--Dimitrianas Kondrasovas II-1/3--------
stekas segment stack                       
        db 256 dup (?)
stekas ends                                
                
duomenys segment                           
         a db 1 
         b db 3       
         grNr db 3      
duomenys ends                               
programa segment                            
   start:                                   
   assume cs:programa,ds:duomenys,ss:stekas 
                                            
          mov ax,duomenys                   
          mov ds,ax                         
                                            
          mov al, a                         
          mul al               ; a*a -> ax  
          mov bx, ax           ; bx = a*a   
                                            
          mov al, b                         
          mul al               ; b*b -> ax         
          mov dx, ax                        
                                            
          add bx, dx           ; ax = a*a + b*b
                                            
          mov al, grNr                      
          mul bx               ; ax =(a*a + b*b)*grNr
                                            
          mov ah,4ch                        
          int 21h                           
          programa ends                     
                                            
   end start                                
                