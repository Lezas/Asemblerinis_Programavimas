stekas segment stack               
  db 256 dup(0)                    
stekas ends    
               
duomenys segment   
 a db 2
 b db 3
 c db 4
 du db 2
 des db 10      
 rez db 3 dup(0)
 db '$'
 ekranas  db 'Viktorija Briskmanaite, II-04/4',10,13
          db 'Uzduotis: X=2a+b*c',10,13
          db 'Spauskite bet koki klavisa',10,13, '$'          
rezult db 'Rezultatas X=2a+b*c=','$'                          
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
   mul du
   mov bl, al
   mov al, b
   mul c 
   add al, bl 
              
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
   lea dx,rezult
   int 21h
             
   mov ah,09h
   lea dx,rez
   int 21h   

   mov ah,07h
   int 21h   
   mov ax,4C00h                                               
   int 21h  
programa ends
end start