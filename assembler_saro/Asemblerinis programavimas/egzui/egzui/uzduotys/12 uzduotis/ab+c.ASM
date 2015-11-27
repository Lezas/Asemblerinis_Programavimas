stekas segment stack
       db 256 dup(0)
stekas ends
duomenys segment
         a db ?
         b db ?
         c db ?
         pran db 'Laboratorinis darbas Nr.9',13,10
              db 'Uzduotis: apskaiciuoti reiskinio reiksme',13,10
              db 'Darba atliko Joana Maldziute, II-2/5 gr.',13,10,'$'
         pran1 db 10,13,'Iveskite a: ','$'
         pran2 db 10,13,'Iveskite b: ','$'
         pran3 db 10,13,'Iveskite c: ','$'
         des db 10
         klaida db 10,13,'Klaida: skaicius netelpa i baita.',13,10,'$'
         tmp db 0
         rez db 5 dup(0),13,10,'$'
         sk db 0
         min db '-','$'
         klaid db 10,13,'Rezultatas netelpa i viena baita.','$'
         rezult db 10,13,'Rezultas: ','$'
         skaic db 4,?,3 dup(0)
duomenys ends
programa segment
         assume ds:duomenys, ss:stekas, cs:programa
         start: mov ax,duomenys
                mov ds,ax
                 ;Ekrano valymas                                
                mov ah,0002h
                int 10h
                ;pranesimo pran isvedimas
                mov ah,09h
                lea dx,pran
                int 21h
                ;a ivedimas
                mov ah,09h
                lea dx,pran1
                int 21h
                call ivedimas
                call skaicius
                mov a,bl
                ;b ivedimas
                mov ah,09h
                lea dx,pran2
                int 21h
                call ivedimas
                call skaicius
                mov b,bl
                ;c ivedimas
                mov ah,09h
                lea dx,pran3
                int 21h
                call ivedimas
                call skaicius
                mov c,bl                
                ;skaiciavimas
                mov ax,0
                mov bx,0
                mov cx,0
                mov al,a               
                imul b
                ;JO klaidele
                add al,c
                ;JC klaidele
                JNS tol
                mov cx,5
                neg ax
                lea si,rez+4
                call isvedimas
                mov ah,09h
                lea dx,rezult
                int 21h
                mov ah,09h
                lea dx,min
                int 21h
                jmp dos
                tol: ;teigiami skaiciai
                lea si,rez+4
                mov cx,5
                call isvedimas
                mov ah,09h
                lea dx,rezult
                int 21h
                jmp dos
                klaidele:
                mov ah,09h
                lea dx,klaid
                int 21h
                dos:
                mov ah,09h
                lea dx,rez
                int 21h
                ;laukia klaviso paspaudimo
                mov ah,07h
                int 21h
                ;gristam i dos'a
                mov ah,4ch
                int 21h
ivedimas proc
         mov ah,0ah
         lea dx,skaic
         int 21h
         ret
ivedimas endp
skaicius proc
         mov ax,0
         mov bx,0
         mov cx,0
         mov dx,0
         mov tmp,0
         lea si,skaic+2
         mov cl,skaic+1
         mov al,'-'
         cmp [si],al
         jne ciklas
         dec cl
         inc si
         inc tmp
         ciklas: mov al,[si]
                 sub al,30h
                 mov dl,al
                 mov al,bl
                 mul des
                 JO klaidaa 
                 mov bl,al
                 mov al,dl
                 add bl,al
                 JC klaidaa
                 inc si
         loop ciklas
         jmp pab
         klaidaa: mov ah,09h
                  lea dx,klaida
                  int 21h
                  jmp dos
         pab: cmp tmp,1
              jne pabb
              neg bl
         pabb: ret
skaicius endp
isvedimas proc
          ciklas1: mov ah,0
                   div des
                   add ah,30h
                   mov [si],ah
                   cmp al,0
                   je pabbb
                   dec si 
          loop ciklas1
          pabbb: ret
isvedimas endp
programa ends
end start
