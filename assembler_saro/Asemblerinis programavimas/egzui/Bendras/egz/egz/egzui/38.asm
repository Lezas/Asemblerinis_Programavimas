stekas segment stack
       db 256 dup(0)
stekas ends

duomenys segment
            eilute db 100,?,100 dup('$')
        KitaEilute db 13,10, '$'         
        atskyrejas db ?
         kiek_simb db ?  
           tekstas db 'Kursinio darbo uzduotis Nr.III.22',10,13   
                   db 'Atliko: Nerijus Gervys, II-2/6',10,13,'$'
             pran1 db 13,10,'Iveskite simboli-atskyreja: $'
             pran2 db 13,10,'Iveskite simboliu eilute: $'
        rezultatas db 13,10,13,10,'Rezultatas:$'         
duomenys ends

programa segment
         assume ss:stekas,ds:duomenys,cs:programa
         start: mov ax,duomenys
                mov ds,ax
                
                mov ax,0002h
                int 10h
;uzduotis                
                lea dx,tekstas
                call isvedimas
;pran1 apie atskyreja               
                lea dx,pran1
                call isvedimas
;ivesti atskyreja                
                mov ah,01h
                int 21h                
                mov atskyrejas,al
;pran2 apie eilute               
                lea dx,pran2
                call isvedimas
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
                  simb_sk: mov al,[si]                                                                                 
                           inc si
                           cmp al,bl
                           je next
                           inc dl
                           loop simb_sk
              next:  mov kiek_simb,dl  ;kiek simb turi 1 zodis                             
;dirbam dirbam
lea dx, rezultatas
call isvedimas
lea dx, KitaEilute
call isvedimas               
                xor ax,ax
                xor bx,bx
                xor cx,cx
                xor dx,dx               
                lea si,eilute+2
                mov cl,eilute+1   ;ciklu_sk
                mov bx, si
                    sukam: mov al,atskyrejas
                           cmp [si], al 
                           jne toliau
                           mov al, ' '
                           mov [si], al
                           inc dl
                           cmp dl, kiek_simb
                           je kita_eilute
                   toliau: inc si
                           loop sukam
                           jmp pabaiga

        kita_eilute:
        mov [si], byte ptr '$'                      
        lea dx, KitaEilute       
        call isvedimas           
        mov  dx, bx               
        call isvedimas
        mov bx, si               
        inc bx
        mov dl, 0
        jmp toliau  
pabaiga:
lea dx, KitaEilute       
call isvedimas
mov dx, bx               
call isvedimas              
;endas
      mov ah,07h
      int 21h                
      mov ah,4ch
      int 21h
isvedimas proc
mov ah,09h                                          
int 21h                                      
ret
isvedimas endp                
programa ends
end start                
                                