;Uzduoti atliko Arunas ir Voitechas
stekas segment stack               
  db 256 dup(0)                    
stekas ends    
cr        equ 13                
lf        equ 10                     
;lygtis a*a+b*b+2ab                                 
duomenys segment   
 a db 2
 b db 3
 des db 10      
 rez db 3 dup(0)
 db '$'
 ekranas   db 'Spresime lygti: ',cr,lf,7                    
          db 'a^2+b^2+2ab' ,cr,lf
          db 'Uzduoti atliko: Arunas ir Voitech',cr,lf
          db 'Spauskite bet koki klavisa',cr,lf, '$'
duomenys ends                                  
                                               
programa segment                               
  assume ds:duomenys, ss:stekas, cs:programa   
start:                                         
   mov ax,duomenys                             
   mov ds,ax                                   
   ;isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
   ;rodome pranesima                                          
   mov ah,09h                                  
   lea dx,ekranas                              
   int 21h                                     
                                                           
   ;laukia klaviso paspaudimo                                 
   mov ah, 07h                                 
   int 21h                                     
   mov ah,0                                    
   mov al,a                                    
   add al,b
   mul al
  
   mov dx,0  
   div  des  
   mov rez+2,ah
   add rez+2,30h
   mov ah,0  
   mov dx,0  
   div des   
   mov rez+1,ah
   add rez+1,30h
   mov ah,0     
   mov dx,0     
   div des      
   mov rez,ah   
   add rez,30h
             
   mov ah,09h
   lea dx,rez
   int 21h   
   mov ah,07h
   int 21h   
   mov ah,4ch      
programa ends
end start