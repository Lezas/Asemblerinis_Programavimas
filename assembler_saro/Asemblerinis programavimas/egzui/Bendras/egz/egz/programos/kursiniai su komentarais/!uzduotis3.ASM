
stekas segment stack
        db 256 dup(?)
stekas ends
duomenys segment
masyvas db 50,?,50 dup(' '),'$'
pran db 'Iveskite zodziu masyva (max 6 zodziai). Kaip simboli-atskyreja naudokite tarpa.',13,10,'$'
masyvas2 db 80 dup(?),'$'
zodis1 db 15 dup(?)
zodis2 db 15 dup(?)
zodis3 db 15 dup(?)
zodis4 db 15 dup(?)
zodis5 db 15 dup(?)
zodis6 db 15 dup(?)
zodis7 db 15 dup(?)
tarpas db 'Rezultatas: ',13,10,'$'
duomenys ends
programa segment
 assume cs:programa,ds:duomenys,ss:stekas
 start: mov ax,duomenys
        mov ds,ax        
        mov ax,0002h
        int 10h        
        mov ah,09h
        lea dx,pran
        int 21h
        mov ah,0ah
        lea dx,masyvas
        int 21h
        lea si,masyvas+2
        mov ah,' '
        mov dl,13
        mov dh,10
        mov bh,'$'
        lea di,zodis1
        mov cx,6
        skaidymas: push di
                   add di,1
                   mov bl,0
                   call zodis
                   pop di
                   mov [di],bl
                   add di,15
        loop skaidymas        
        mov ah,02
        mov bh,00
        mov dh,04
        mov dl,00
        int 10h
        mov ah,09h
        lea dx,tarpas
        int 21h        
        mov bx,0        
        mov cx,15
        lea si,zodis1
        ciklasa: push cx
                 push si
                 mov cx,6
                 ciklass: mov bh,[si]
                          cmp bl,bh
                          jne kitas
                          mov ah,09h
                          lea dx,[si]+1
                          int 21h
                          kitas: add si,15
                 loop ciklass
                 pop si
                 pop cx
                 inc bl
        loop ciklasa
        mov ah,07h
        int 21h        
        mov ax,4C00h
        int 21h        
        zodis proc
        ciklas: mov al,[si]                
                cmp al,ah
                je tt
                cmp al,dl
                je tt
                mov [di],al
                inc bl
                inc si
                inc di
                jmp ciklas                
                tt: inc si                
                mov [di],dl
                inc di               
                mov [di],dh
                inc di                
                mov [di],bh
        ret
        zodis endp
programa ends
end start
