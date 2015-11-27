stekas segment stack 
        db 256 dup(?)
stekas ends          
                                   
duomenys segment     
aprasymas  db 'Viktorija Briskmanaite, II-04/4',10,13
           db 'Programa isveda i ekrana masyva: 4x5',10,13
           db 'Siame masyve ne maziau kaip 6 nuliai',10,13
           db 'Masyve esanciu nulius pakeicia i 256',10,13
           db 'Pakeistus duomenis isveda i ekrana..',10,13,10,13, '$'
                                                                
                                                                
pradinis db 'Pradinis masyvas yra: ',10,13,'$'                  
pakeistas db 'Nuliai pakeisti i 256: ',10,13,'$'
eilute db ' ','$'                                                
mtrx db 0,'$'                                                   
sk db 0,'$'                                                     
dal db 10,'$'                                                   
perkelia db 10,13,'$'                                           
                                                                
eilute1  db 1,2,0,2,4, 10,13,'$'    
eilute2  db 7,0,1,0,6, 10,13,'$'    
eilute3  db 4,5,0,1,7, 10,13,'$'    
eilute4  db 0,9,3,4,9, 10,13,'$'    
eilute5  db 8,2,7,0,6, 10,13,'$'    
duomenys ends                                                   
                                                                
programa segment                                                
        assume ds:duomenys, ss:stekas,cs:programa                    
start:                                                          
;duomenu inicializavimas                                        
       mov ax, duomenys                                         
       mov ds, ax                                              
;ekrano isvalymas                                              
       mov ax,0002h                                            
       int 10h                                                 
;Uzduoties isvedimas                                           
       mov ah,09h                                              
       lea dx,aprasymas                                        
       int 21h                                                 
                                                               
;matricos spausdinimas                                         
        lea bx,eilute1   ;adresas                                      
        mov al,0                                               
        mov cx,5                                               
                                                               
        ciklas:                                                
           mov si,cx                                           
           mov cx,5                                                  
        ;prie kiekvieno elemento prideda 30h ir spausdinam     
           ciklas1:                                            
                mov ax,[bx]                                    
                mov sk,al                                      
                add sk,30h                                     
                mov ah,09h                                     
                lea dx,sk                                      
                int 21h                                        
                mov ah,09h                                     
                lea dx, eilute                                 
                int 21h                                        
           inc bx                                              
          loop ciklas1                                         
         ;perkeliam i kita eilute                              
                mov ah,09h       
                lea dx,perkelia           
                int 21h                   
                mov cx,si                 
                add bx,3                  
                loop ciklas                                          
         
        ;pradedam matricos keitimas
         ;rezu pranesimo spausdinimas     
                mov ah,09h                
                lea dx,pakeistas   ;pranesimas       
                int 21h                       
                                              
                lea bx,eilute1                ;nustatmo pradzios adresus
                mov cx,5                                                
                                                                        
                cik2:                                                   
                        mov si,cx                                       
                        mov cx,5                                        
                        ciklas3: ;keitimas                              
                                mov al,0                                
                                ;pasilyginam su 0                       
                                cmp al,[bx]                             
                                jne k   ;jeigu ne nulis perkeliam i k zyme
                                mov di,cx                               
                                mov cx,3                                
                                mov ax,255                             
                                ;isvedam i ekrana 256 naudodami steka   
      cik4:                                                             
        div dal                                                         
        push ax                                                         
                                                                        
        mov ah,0                                                        
        loop cik4                                                       
                                                                        
           mov cx,3                                                     
          cik5:                                                         
         pop ax                                                         
         add ah,30h                                                     
       mov sk,ah                                                        
        mov ah,09h                                                      
       lea dx,sk                                                        
       int 21h                                                          
       loop cik5                                                        
        mov cx,di                                                       
                                                                        
        jmp l                                                           
       k:                                                               
       mov ax,[bx]                                                      
       mov sk,al                                                        
       add sk,30h                                                       
       mov ah,09h                                                       
       lea dx,sk                                                        
       int 21h                                                          
                                                                        
     l:                                                                 
     mov ah,09h                                                         
     lea dx, eilute                                                     
     int 21h                                                            
     inc bx                                                             
                                                                        
     loop ciklas3                                                       
                                                                        
     mov ah,09h                                                         
     lea dx,perkelia                                                    
     int 21h                                                            
     mov cx,si                                                          
     add bx,3                                                           
                                                                        
     loop cik2                                                          
                                                                        
;laukiam paspaudimo                                                     
       mov ah,07h                                                       
       int 21h                                                          
;griztam i dosa                                                         
       mov ah,4ch                                                       
       int 21h                                                          
programa ends                                                           
end start