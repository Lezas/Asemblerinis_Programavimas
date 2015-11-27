stekas segment stack
        db 512 dup (0)
stekas ends          
                    
duomenys segment       
        pranesimas db 'Pirmasis laboratorinis darbas', 13, 10, '$'
        sk db 173
        mas db 3 dup (0), '$'
        des db 10      
                            
        duomenys ends  
                                                                       
programa segment                                                                     
assume  ss: stekas, ds: duomenys,cs: programa
                                               
start:                        
        mov ax, duomenys 
        mov dx, ax                                                                   
        mov ds, dx     
        mov ax, 02h    
        int 10h       ;isvalo ekrana        
        mov ah, 09h                 
        lea dx, pranesimas  
        int 21h       ;isveda pranesima        
        mov ah, 07h                            
        int 21h       ;laukai paspaudimo                 
        mov ah, 0                       
        mov al, sk    ;skaicius -> al
        div des       ;dalinam al is 10               
        add ah, 30h   ;ah + 30h                 
        mov mas, ah   ;ah -> mas[0]          
        mov ah, 0     ; ah = 0      
        div des       ;vel dalinam al is 10        
        add ah, 30h   ;prie liekanos pridedam 30h                     
        mov mas+1, ah ;ah -> mas[1]
        mov ah, 0                 
        div des                   
        add ah, 30h               
        mov mas+2, ah             
        mov ah, 0                 
        lea dx, mas   ;masyvas -> dx            
        mov ah, 09h                 
        int 21h       ;isvedam masyva            
        mov ah, 07h                  
        int 21h       ;laukiam paspaudimo                            
        mov ah, 4ch                            
        int 21h       ;baigiam                                                      
                                     
programa ends                                  
                              
end start                     
