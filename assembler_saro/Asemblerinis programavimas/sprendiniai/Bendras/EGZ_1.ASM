stekas segment stack      
db 256 dup (?)                  
stekas ends               
                          
duomenys segment           
        VardasT db 16,?   
        Vardas  db 16 dup (' '),13,10,'$'
        PavardT db 25,?        
        Pavard  db 25 dup (' '),13,10,'$'
        pranV db 10,13,"Iveskite varda: ",'$'
        pranP db 10,13,"Iveskite pavarde: ",'$'  
        
        pirmas dw ?
        antras dw ?
        skai   dw 89D4h
duomenys ends                               
               
program segment                                
       	assume cs:program,ds:duomenys,ss:stekas
start:                                         
       	mov ax,duomenys                        
       	mov ds,ax                              
; intro ivedimas                                                    
        lea dx,pranV        ;Vardas ivedimas
        mov ah,09h                         
        int 21h                            
        lea dx,VardasT                     
        mov ah,0Ah                         
        int 21h                            
        lea dx,pranP        ;Pavard ivedimas
        mov ah,09h                         
        int 21h                            
        lea dx,PavardT              
        mov ah,0Ah                         
        int 21h                            
                                    
        mov cx,0000h        ;cls               
        mov dx,184Fh     
        mov ax,0600h                   
        mov bh,07h                     
        int 10h 
; intro isvedimas     
        mov bl,VardasT+1    ; paruosimas isvedimui
        xor bh,bh          
        mov Vardas[bx+1],10
        mov Vardas[bx+2],'$'
        lea dx,Vardas       ; isvedimas                             
        mov ah,09h                  
        int 21h                      
        mov bl,PavardT+1    ; paruosimas isvedimui
        xor bh,bh          
        mov Pavard[bx+1],10
        mov Pavard[bx+2],'$'
        lea dx,Pavard       ; isvedimas
        mov ah,09h         
        int 21h       
; uzd
        mov ax,skai
        lea bx,skai
        
                                                                                  
        mov ax,4C00h                                               
        int 21h                                                    
program ends                                                       
                                                                    
end start                                                           
	       	     	     	                       
