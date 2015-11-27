Stekas segment stack            
        db 256 Dup(?)           
Stekas ends    
                 
Duom segment 
       Pran1       db "Giedrius Leisis II-2/1",10,13,"$"
       Pran2       db "Programa pakeicia mazasias raides i didziasias ir suskaiciuoja jas$"
       ivedimas    db 10,13,"Iveskite masyva neilgesni nei 20 simboliu:",10,13,"$"
       rezult      db 10,13,"Gautas rezultatas ir suskaiciuota mazuju raidziu" ,10,13,"$"
       neivede     db 10,13,"Nieko neivesta, pakartokite:","$"
       theend      db 10,13,"DARBAS BAIGTAS... Paspauskite bet, kuri klavisa.","$"
       zodis       dw 20 dup(?),10,13,"$"                   
       ats         DB 40 DUP(?),"$"
       d_pagr      db 10 
       kiekis      db 2 dup (?),' $' 
        
                                           
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
        MOV DL,20
        INT 10H   
                                        
        ;pranesimo isvedimas                              
        mov ah, 09h                                       
        lea dx,Pran1                                       
        int 21h     
                                          
        ;KURSORIAUS NUSTATYMAS                            
        MOV AH,02                                         
        MOV BH,00                                         
        MOV DH,04
        MOV DL,00
        INT 10h     
                                        
        ;Pranesimo2 isvedimas
        mov ah,09h                                        
        lea dx,Pran2
        int 21h
             
        mov ah,02
        mov bh,00
        mov dh,07
        mov dl,00
        int 10h
                        
        mov ah,09h                 
        lea dx,ivedimas
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
       
gerai:                                           
       xor si,si   ;KEITIMAS DIDZIOSIOM IR DVIGUBAI                                          
       mov cl,bl
       xor di,di
       add si,2
                 
ciklas:
       mov ax,zodis[si]            
       cmp al,61h
       jge pagavau
                
geras:                                                            
       mov ats [di],al
       add di,2
       inc si
       loop ciklas
       jmp pabaiga          
                             
pagavau:             
       cmp al,41h
       jge aha    
       jmp geras  
       
aha:       
       sub al,32
       jmp geras       
                
neivedete:
        mov ah,09h
        lea dx,neivede
        int 21h 
        jmp isnaujo 
                                                                                                                                                                                                                                                                                                                                                                      
pabaiga:                                         
        ;nustatome kursoriu i paskutine eilute
	mov AH, 02h                                   
	mov BH, 00h                  
	mov DH, 14                   
	mov DL, 00h                               
	int 10h                      
                                  
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
          