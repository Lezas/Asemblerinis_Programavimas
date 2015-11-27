Stekas segment stack            
        db 256 Dup(?)           
Stekas ends                     
Duom segment 
        Pran db " ","$"
       Pran1 db "Lina Pranyte II-3/4",10,13,"$"
       Pran2 db "Programa:  kartoja simbolius po du"
             db "kartus ir didziasias raides keicia" 
             db "                          mazosiom"
       masyvas db 10,13,"Iveskite masyva neilgesni nei 20 simboliu:",10,13,"$"
       rezult db 10,13,"Gavome rezultata:",10,13
              db "Simbolius pakartojame 2kartus ir didziasias"
              db " raides keiteme mazosiomis." ,10,13,"$"
       neivede db 10,13,"Jus nieko neivedete, prasome pakartoti:","$" 
       theend db 10,13,"DARBAS BAIGTAS... Paspauskite bet, kuri klavisa.","$"
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
                                                          
        ;KURSORIAUS NUSTATYMAS                            
        MOV AH,02                                         
        MOV BH,00                                         
        MOV DH,01                                         
        MOV DL,45                                         
        INT 10H                                           
        ;pranesimo isvedimas                              
        mov ah, 09h                                       
        lea dx,Pran                                       
        int 21h                                           
        ;KURSORIAUS NUSTATYMAS                            
        MOV AH,02                                         
        MOV BH,00                                         
        MOV DH,02                                         
        MOV DL,45                                         
        INT 10h                                           
        ;Pranesimo1 isvedimas                             
        mov ah,09h                                        
        lea dx,Pran1                                      
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
       ;KEITIMAS DIDZIOSIOM IR DVIGUBAI                                          
          
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
        lea dx,neivede
        int 21h     
        jmp isnaujo 
                                                                                                                                                                                                                                                                                                                                                                      
       pabaiga:                                      
       ;ATSAKYMO ISVEDIMAS                        
       mov ah,09h   
       lea dx,rezult
       int 21h                       
       mov ah, 09h                                    
       lea dx, ats                                    
       int 21h      
                    
       MOV AH,02                                         
        MOV BH,00                                         
        MOV DH,23                              
        MOV DL,00                                   
        INT 10H     
       mov ah,09h   
       lea dx,theend
       int 21h                                   
       ;LAUKIMAS                                      
       mov ah,07h                   
       int 21h                      
       ;PROGRAMOS PABAIGA           
       mov ah,4ch                   
       int 21h            
                           
                          
                          
program ends              
end start                 
          