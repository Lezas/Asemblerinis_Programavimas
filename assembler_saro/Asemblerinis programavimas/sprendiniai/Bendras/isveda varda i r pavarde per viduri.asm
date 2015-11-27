stekas segment stack      
db 256 dup (?)                  
stekas ends               
                          
duomenys segment           
        VardasT db 16,?   
        Vardas  db 18 dup (' ')
        PavardT db 25,?   
        Pavard  db 27 dup (' ')
        pranV db 10,13,"Iveskite varda: ",'$'
        pranP db 10,13,"Iveskite pavarde: ",'$'  
        du db 2
duomenys ends                               
               
h equ 24       
w equ 80       
               
                                           
program segment                       
     	assume cs:program,ds:duomenys,ss:stekas
start:                                         
       	mov ax,duomenys                        
       	mov ds,ax                              
                                                    
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
                             
        mov al,h
        xor ah,ah
        div du
        mov dh,al
        mov dh,10
        xor dl,dl
        xor bh,bh
        mov ah,02h
        int 10h
                                            
        mov al,w            ;Vardas isvedimas
        sub al,VardasT+1
        xor ah,ah
        div du                      
        mov cl,al
        xor ch,ch
   posV: mov dl,' '                  
        mov ah,02h                  
        int 21h                     
   loop posV                         
        mov bl,VardasT+1    ;si - raidziu sk
        xor bh,bh
        mov Vardas[bx+1],10
        mov Vardas[bx+2],'$'
        lea dx,Vardas
        mov ah,09h                  
        int 21h                      
                                    
        mov al,w            ;Pavard isvedimas
        sub al,PavardT+1
        xor ah,ah
        div du                     
        mov cl,al
        xor ch,ch
   posP: mov dl,' '   
        mov ah,02h   
        int 21h      
   loop posP          
        mov bl,PavardT+1    ;si - raidziu sk
        xor bh,bh
        mov Pavard[bx+1],10
        mov Pavard[bx+2],'$'
        lea dx,Pavard
        mov ah,09h   
        int 21h       
                                                                                  
        mov ax,4C00h                                               
        int 21h                                                    
program ends                                                       
                                                                    
end start                                                           
	       	     	     	                       
