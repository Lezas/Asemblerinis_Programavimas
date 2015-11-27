stekas segment stack
       db 256 dup(0)
stekas ends

duomenys segment
         junginys db 80,?,80 dup(0),'$'         
         galutinis db 80 dup(0),'$'
         liekana db ?
         tarpas db ?
         kiek db ?
         atskyrejas db ?
         pran1 db 10,13,'Iveskite simboli-atskyreja',13,10,'$'
         pran2 db 'Iveskite simboliu eilute',13,10,'$'
         rezultatas db 'Gautas rezultatas:',13,10,'$'
         VIENAS DB 1         
duomenys ends

programa segment
         assume ss:stekas,ds:duomenys,cs:programa
         start: mov ax,duomenys
                mov ds,ax
                
                mov ah,0002h
                int 10h
                
                mov ah,02
                mov bh,00
                mov dh,00
                mov dl,00
                
                mov ah,09h
                lea dx,pran1
                int 21h
                
                mov ah,08h
                int 21h
                
                mov atskyrejas,al
                
                mov ah,09h
                lea dx,pran2
                int 21h
                
                mov ah,0ah
                lea dx,junginys
                int 21h
                
                lea si,junginys+2
                mov ax,0
                mov bx,0
                mov cx,0
                mov dx,0
                mov cl,junginys+1
                mov bl,atskyrejas
                atskyreju: mov al,[si]
                           cmp al,bl
                           jne toliau
                           inc dl
                           toliau: inc si
                loop atskyreju
                mov kiek,dl
                mov ax,0
                cmp dl,0
                je pab
                mov al,junginys+1
                sub al,kiek
                
                mov bl,al
                mov al,80
                sub al,bl
                div kiek
                mov liekana,ah
                mov tarpas,al
                
                mov dx,0
                lea si,junginys+2
                lea di,galutinis
                mov bl,kiek
                galut: mov al,[si]
                       cmp al,atskyrejas
                       jne forma
                       cmp bl,liekana
                       jne galu
                       MOV BH,VIENAS
                       ADD BH,TARPAS
                       mov tarpas,bh
                       galu: mov cx,0
                             mov cl,tarpas
                             mov al,' ' 
                             ;mov [di],al
                             ;inc di
                             ;dec di
                             ;dec dl
                                                        
                             tarpass: inc di
                                      inc dl 
                                     mov [di],al
                                     ;cmp cx,1
                                     ;je formaa
                                     ;inc di
                                     ;inc dl
                                     ;cmp cx,1
                                     ;je formaa
                             loop tarpass
                             dec bl
                             jmp formaaa
                       forma: mov [di],al
                              inc dl ;------
                              inc di ;------
                       jmp formaaa
                       ;formaa: dec bl
                       formaaa: ;inc di
                                inc si
                                
                       cmp dl,80
                       jg pabaiga
                       jmp galut
                pabaiga:
                mov ah,02
                mov bh,00
                mov dh,10
                mov dl,31
                int 10h
                
                mov ah,09h
                lea dx,rezultatas
                int 21h
                                                
                mov ah,09h
                lea dx,galutinis
                int 21h
                jmp dos
                pab:
                mov ah,09h
                lea dx,rezultatas
                int 21h                
                mov ah,09h
                lea dx,junginys+2
                int 21h
                dos:
                mov ah,07h
                int 21h
                
                mov ah,4ch
                int 21h
                
programa ends
end start                
                                