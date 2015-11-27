;suskaiciuoti X=(a*2+b*c)/(d-3)
stekas segment stack
      db 256 dup(?)
stekas ends

duomenys segment
uzd db 'Skaiciuojame X=(a*2+b*c)/(d-3)',10,13
 db 'atsakymas:',10,13,'$'
a db -2
b db 3
c db 4
d db 5
du db 2
tris db 3
rez dw 0
duomenys ends

programa segment
         assume ss:stekas, ds:duomenys, cs:programa
         
start: mov ax, duomenys
       mov ds, ax
       
       mov ax, 0002h ; ekrano valymas
       int 10h
 
       mov ah, 09h   ; pranesimo isvedimas
       lea dx, uzd
       int 21h
       
  ; skaiciuojam
       mov al, a
       mov ah, 0
       imul du
       mov bx, ax ; bx'e 2*a
       
       mov al, b
       mov ah, 0
       imul c
       add ax, bx ; ax'e (2*a + b*c)
       mov cx, ax
       
       mov bl, d
       mov bh, 0
       sub bl, tris ; ax'e (d-3)
       idiv bl
       add ax, 30h
       mov ah, 0
       mov rez, ax
              
       mov ah, 09h; rezultato spausdinimas
       lea dx, rez
       int 21h
       
       mov ah, 07h  ; laukia klaviso paspaudimo
       int 21h
       
       mov ah, 4ch  ; grizta i dos
       int 21h
programa ends 
end start