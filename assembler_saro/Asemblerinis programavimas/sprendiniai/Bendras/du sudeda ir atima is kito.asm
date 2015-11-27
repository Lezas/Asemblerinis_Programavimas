



stekas segment stack
       db 256 dup (?)
stekas ends

duomenys segment
a db 4
b db 3
c db 1
rez db 0 , '$'
pran db 'rezultatas - ' , '$'
duomenys ends

programa segment
assume cs: programa, ds: duomenys, ss:stekas
 start:
 mov ax, duomenys
 mov ds, ax

;ekrano valymas
 mov ax, 0002h
 int 10h    ; Screen

 ;skaiciavimai
 mov al, a
 add al, b
 sub al, c ; atimtis
 add al, 30h ;skaiciai ASCII lenteleje prasideda nuo 30h simbolio
 mov rez, al

 ;isvedimas i ekrana
 mov ah, 09h
 lea dx, pran ; LEA - load effective adress
 int 21h ; kreipiames i dos :P (interupt - pertraukimas)

 mov ah, 09h ; isvedimas
 lea dx, rez
 int 21h

;laukia paspaudimo
 mov ah, 07h ; laukia kol bus ivestas simbolis, paspaudimo
 int 21h

;
 mov ah, 4ch ; uzdaro programa
 int 21h

 programa ends
 end start