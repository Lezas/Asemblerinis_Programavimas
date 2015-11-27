stekas segment stack
db 256 dup (?)
stekas ends
          
duomenys segment
pran    db 'Programa skaiciuoja OA irasytu 10 skaiciu masyva',13,10
        db 'ir ji susumuoja',13,10, '$'
masyvas db 1,2,3,4,5,6,7,8,9,0,'$'
des     db 10
T       db 3 dup (0),'$'
duomenys ends
          
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:  
mov ax, duomenys
mov ds, ax

;ekrano valymas
mov ax, 02h
int 10h
  
;isvedimas i ekrana pran
mov ah, 09h
lea dx, pran
int 21h

       
;skaiciavimas
mov si, 0 
mov ax, 0    
mov al, masyvas[si]
mov cx, 9
ciklas:
inc si 
add al,masyvas[si]
loop ciklas
       
lea bx,T+2
ciklas1:
div des
add ah,30h
mov [bx],ah
mov ah,0    
dec bx
cmp al, 0
jne ciklas1

mov ah, 09h
lea dx, T
int 21h

mov ah, 07h
int 21h

mov ah, 4ch
int 21h

programa ends 
end start




