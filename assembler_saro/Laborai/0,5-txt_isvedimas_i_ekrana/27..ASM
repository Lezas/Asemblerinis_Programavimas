
stekas segment stack                                                     
        db 256 dup (?)
stekas ends                                                              
                                                                                                                         
duomenys segment                                                               
        pran db  'Agne Katkute II-2/1   Laboratorinis darbas Nr.1,$',10,13  
             
duomenys ends                 
                              
programa segment              
assume cs:programa, ds:duomenys, ss:stekas
start:                                                
        mov ax, duomenys      
        mov ds, ax            
        
        Mov ax,0002h	
        INT 10h
        
        mov AH, 09h           
        lea DX, pran    
        int 21h           
                                                                   
        mov ah, 08h 
        int 21h
                
        mov ah, 4ch      
        int 21h            
programa ends              
end start