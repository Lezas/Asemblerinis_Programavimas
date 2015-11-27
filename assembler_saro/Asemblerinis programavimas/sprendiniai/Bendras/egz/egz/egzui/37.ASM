stekas segment stack
       db 256 dup(0)
stekas ends

duomenys segment
            eilute db 60,?,60 dup(),'$'         
               rez db 80,?,80 dup(),'$'
           liekana db ?
            tarpas db ?
              kiek db ?
        atskyrejas db ?
           tekstas db 'Kursinio darbo uzduotis Nr.II.11',10,13   
                   db 'Atliko: Nerijus Gervys, II-2/6',10,13,'$'
             pran1 db 13,10,'Iveskite simboli-atskyreja: $'
             pran2 db 13,10,'Iveskite simboliu eilute:',13,10,'$'
        rezultatas db 13,10,'Rezultatas:',13,10,'$'
            VIENAS DB 1         
duomenys ends

programa segment
         assume ss:stekas,ds:duomenys,cs:programa
         start: mov ax,duomenys
                mov ds,ax
                
                mov ax,0002h
                int 10h
;uzduotis
                mov ah,09h
                lea dx,tekstas
                int 21h
;pran1 apie atskyreja               
                mov ah,09h
                lea dx,pran1
                int 21h
;ivesti atskyreja                
                mov ah,01h
                int 21h                
                mov atskyrejas,al
;pran2 apie eilute               
                mov ah,09h
                lea dx,pran2
                int 21h
;ivesti eilute                
                mov ah,0Ah
                lea dx,eilute
                int 21h
;prasideda darbelis                                
                xor ax,ax
                xor bx,bx
                xor cx,cx
                xor dx,dx               
                lea si,eilute+2
                mov cl,eilute+1   ;ciklu_sk
                mov bl,atskyrejas
             atskyreju_sk: mov al,[si]
                           cmp al,bl
                           jne toliau
                           inc dl
                   toliau: inc si
                           loop atskyreju_sk
                mov kiek,dl
                xor ax,ax
                ;tarpo ilgis
                mov al,eilute+1
                sub al,kiek 
                mov bl,al
                mov al,80
                sub al,bl
                div kiek
                mov liekana,ah
                mov tarpas,al
                ;toliau
                mov dx,0
                lea si,eilute+2
                lea di,rez
                mov bl,kiek
                pradzia: mov al,[si]
                         cmp al,atskyrejas
                         jne neatskyrejas
                         cmp bl,liekana
                         jne tarpass
                         MOV BH,VIENAS 
                         ADD BH,TARPAS 
                         mov tarpas,bh 
                    tarpass: xor cx,cx                   
                             mov cl,tarpas ;ciklu_sk     
                             mov al,' '                                    
                             tarpasss: inc di            
                                       inc dl            
                                       mov [di],al                                    
                                       loop tarpasss     
                                dec bl
                                jmp ar_baigti
                neatskyrejas: mov [di],al
                              inc dl 
                              inc di 
                              jmp ar_baigti
               
                       ar_baigti: 
                       inc si                              
                       cmp dl,80
                       jg pabaiga
                       jmp pradzia
                pabaiga:
                mov ah,09h
                lea dx,rezultatas
                int 21h                                                
                mov ah,09h
                lea dx,rez
                int 21h               
;endas
      mov ah,07h
      int 21h                
      mov ah,4ch
      int 21h
                
programa ends
end start                
                                