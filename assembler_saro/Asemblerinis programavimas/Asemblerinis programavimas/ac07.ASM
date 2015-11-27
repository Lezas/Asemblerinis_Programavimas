;Uzduoti atliko Arunas Ciesiunas, II-1/5
;7-as laboratorinis darbas
stekas segment stack               
  db 256 dup(0)                    
stekas ends    
cr        equ 13                
lf        equ 10                     
                      
duomenys segment               
 a dw ?
 b dw ?
 c dw ?
 du dw 2              
 nul dw 0             
 rez dw 0
 db cr,lf,7,'$'                         
 ekranas   db 'Laboratorinis darbas Nr 7 ',cr,lf,7
           db 'Lygtis x=2ab+c^2',cr,lf,7
           db 'Uzduoti atliko: Arunas Ciesiunas, II-1/5',cr,lf
           db 'Spauskite bet koki klavisa',cr,lf, '$'
 lygus1  db 'Rezultatas lygus nuliui',cr,lf,7,'$' 
 didesnis1 db 'Rezultatas teigiamas',cr,lf,7,'$'                        
 mazesnis1 db 'Rezultatas neigiamas',cr,lf,7,'$'                          
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
                                       
   mov ax,a                            
   mul  b                              
   mul du                              
   mov bx, ax                          
   mov ax, c                           
   mul c                        
   add ax,bx                    
   mov rez, ax                  
   mov bx,0                     
              
                                
   CMP ax, bx                   
   JE lygus                     
   JG didesnis                  
   JL mazesnis                  
                                
       
 lygus:
 ;rodome pranesima              
   mov ah,09h                                  
   lea dx,lygus1                
   int 21h                      
                                
mov ah,4ch                      
int 21h                         
                                
didesnis:                       
 ;rodome pranesima              
   mov ah,09h                                  
   lea dx,didesnis1             
   int 21h                      
                                
                   
mov ah,4ch         
int 21h            
                   
mazesnis:                 
 ;rodome pranesima 
   mov ah,09h                                  
   lea dx,mazesnis1   
   int 21h          
                  
mov ah,4ch        
int 21h  
         
programa ends
end start