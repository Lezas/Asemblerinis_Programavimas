stekas segment stack
        db 256 dup (?) 
stekas ends          
                     
duomenys segment       
uz db 'lielka ir neliekana', 13,10, '$'
ats1 db 'sv dalis' ,'$'
ats2 db 13,10,'liek ', '$'
mas dw 4,12,0,5,12     
masD dw 5            
d dw ?   , '$'       
g dw ?    , '$'      
                                          
duomenys ends                             
                                          
programa segment                          
assume cs:programa, ds:duomenys, ss:stekas 
 start:                                   
                                    
                                          
        mov ax, duomenys                  
        mov ds, ax                        
                                    
               mov ax, 02h          
               int 10h              
                                    
        mov dx,0                    
        mov ax, 0                   
        mov si,0                    
        mov cx, masD                
        sum:                        
        add ax,mas[si]              
        add si,2                    
        loop sum                    
          idiv masD                 
                                    
          mov d, ax                 
          add d, 30h                
          mov g, dx                 
          add g,30h                 
             ;isvedimas             
             mov ah,09h             
            lea dx, uz
              int 21h               
                                    
              mov ah,09h            
             lea dx,ats1
              int 21h               
                                    
                                    
          mov ah,09h                
        lea dx, d                   
        int 21h                     
                                    
           mov ah,09h               
             lea dx,ats2            
              int 21h               
                                    
        mov ah, 09h                 
         lea dx,g                   
        int 21h  
               
        ;pabaiga
        mov ah, 07h
        int 21h               
                              
        mov ah, 4ch
        int 21h    
                   
programa ends      
end start