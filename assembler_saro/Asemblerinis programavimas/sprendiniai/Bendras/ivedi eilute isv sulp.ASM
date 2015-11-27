stekas segment stack
        db 256 dup(?)
stekas ends
;duomenu segmentas
duomenys segment
mas db 10 dup(10 dup(?))
masyvas db 50,?,50 dup(?),'$'
pran db 'Iveskite masyva. Kaip simboli-atskyreja naudokite tarpa.',13,10,'$'
masyvas2 db 80 dup(?),'$'
naujas db 'Gautas rezultatas:',13,10,'$'

duomenys ends
; programos segmentas
programa segment
 assume cs:programa,ds:duomenys,ss:stekas
 start: mov ax,duomenys
        mov ds,ax
        ;ekrano isvalymas
        mov ax,0002h
        int 10h
        ;pranesimo isvedimas
        mov ah,09h
        lea dx,pran
        int 21h
        mov ah,0ah
        lea dx,masyvas
        int 21h
        lea si,masyvas+2
        lea di,masyvas2
        mov cx,0
        mov cl,masyvas+1
        mov bx,0
        mov bl,' '
        ciklas: mov al,[si]                
                cmp al,bl
                jne nauja
                mov dl,13
                mov [di],dl
                inc di
                mov dl,10
                mov [di],dl
                jmp naujaa
                nauja: mov [di],al
                naujaa: inc di
                        inc si       
       loop ciklas
       mov bl,'$'
       mov [di],bl
       mov ah,09h
       lea dx,naujas
       int 21h
       mov ah,09h
       lea dx,masyvas2
       int 21h  
       
       mov al,'a'
       mov mas,al
       mov mas+10,al       
                
 galas: mov ah,07h
        int 21h
        ;darbo pabaiga
        mov ax,4C00h
        int 21h
 programa ends
    end start
