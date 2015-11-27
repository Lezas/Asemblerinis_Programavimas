;steko segmentas
stekas segment stack
        db 256 dup ()
stekas ends         
                       
;duomenu segmentas     
duomenys segment       
         pran db 13,10,' Virginijos Sklizmontaites',13,10
              db ' 1 - oji kursinio darbo uzduotis:',13,10
              db ' Teksto isvedimas per kelias eilutes',13,10,'$'
duomenys ends                                   
                 
;programos segmentas
programa segment 
         assume cs:programa, ds:duomenys, ss:stekas
 start:  mov ax,duomenys
         mov ds,ax    
                 
         mov ax,0002h  ; ekrano valymas
         int 10h
                                        
         mov ah,09h    ;isveda pranesima
         lea dx,pran
         int 21h     
         mov ah,4ch ; grizimas i DOS'a
         int 21h     
programa ends       
        end start   
                        
 