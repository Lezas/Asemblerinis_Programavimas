Stekas segment stack            
        db 256 Dup(?)           
Stekas ends                     
Duom segment     
        Pran db "Kursinis darbas Nr. 17",10,13,"$"     
       Pran1 db "Darius Rynkevic II-2/3",10,13,"$"
       Pran2 db "Programa:  kartoja simbolius po du"
             db "kartus ir didziasias raides keicia" 
             db "mazosiom",10,13,"$"                     
       masyvas db "Iveskite simboliu eilute:",10,13,"$"
       rezultatas db 10,13,"Rezultata:",10,13
              db "Simbolius Pakartojome ir pakeitem mazas i didziasias",10,13,"$"
       neivesta db 10,13,"Reikia kazkka ivesti!!! prasome pakartoti:","$"     
       ate db 10,13," Paspauskite bet, kuri klavisa.","$"
       zodis dw 20 dup(?),10,13,"$"                      
       ats DB 40 DUP(?),"$"                              
                                           
Duom ends                                                 
Program segment                                           
        assume cs:program, ds:duom, ss:Stekas             
start:                                                    
       ;EKRANO VALYMAS                                    
       mov ax, 0002h                                      
       int 10h                                            
       ;DUOMENU UZKROVIMAS                                
       mov ax, duom                                       
       mov ds,ax                                          
                              
      ; pranesimo isvedimas   
        mov ah, 09h                                       
        lea dx,Pran                                       
        int 21h                                           
                              
       ;Pranesimo1 isvedimas
        mov ah,09h                                        
        lea dx,Pran1                                      
        int 21h   
                  
        ;Pranesimo2 isvedimas
        mov ah,09h                                        
        lea dx,Pran2
        int 21h          
                  
        mov ah,09h
        lea dx,masyvas
        int 21h                    
        isnaujo:                   
        mov zodis[0],20                                        
        mov ah,0ah                                        
        lea dx,zodis                                      
        int 21h               
        mov ax,zodis[1]       
        cmp al,0              
        je neivedete
                        
       je pabaiga
        mov bl,al   
       ;ISVALOM BX, SI                                    
       gerai:                                           
       xor si,si                                                               
       ;Pakeiciam raidelkas ir jas padauginam
                                             
       mov cl,bl                             
       xor di,di                             
       add si,2                              
       ciklas_dvigubai:                                                             
       mov ax,zodis[si]                      
       cmp al,61h                            
       jl pagavau                            
       geras:                                                            
       mov ats[di],al                                                    
       mov ats[di+1],al                                                  
       add di,2                                                          
       inc si                                                            
       loop ciklas_dvigubai                                              
       jmp pabaiga          
                            
       pagavau:             
       cmp al,41h      
       jge aha      
       jmp geras    
       aha:         
       add al,32    
       jmp geras       
                    
        neivedete:  
        mov ah,09h  
        lea dx,neivesta
        int 21h     
        jmp isnaujo 
                                                                                                                                                                                                                                                                                                                                                                      
       pabaiga:                                      
       ;ATSAKYMO ISVEDIMAS                        
       mov ah,09h   
       lea dx,rezultatas
       int 21h                       
       mov ah, 09h                                    
       lea dx, ats                                    
       int 21h  
       ;Paskutinio pranesimo isvedimas 
       mov ah,09h
       lea dx,ate
       int 21h                                   
       ;LAUKIMAS                                      
       mov ah,07h                   
       int 21h                      
       ;PROGRAMOS PABAIGA           
       mov ah,4ch                   
       int 21h            
program ends              
end start                 
          