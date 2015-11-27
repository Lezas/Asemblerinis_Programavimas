masm
model small
stack 10000
.data
message1  db 'Iveskite simboliu eilute 1: ','$'
message2  db 'Iveskite simboliu eilute 2: ','$'
message3  db 'Atliko: Jurijus Antonovas II-2/1. Antra kursinio darbo dalis','$'
message4  db 'Spausdiname abi eilutes','$'
simeil1   db 20,?,21 dup('$')
simeil2   db 20,?,21 dup('$')
len1      db ?,'$'
len2	  db ?
skaicius1 db ?
skaicius2 db ?
.code

skaiciavimas1 proc
xor CX,CX
mov BH,len1
mov si,2
mov skaicius1,0
cycl:
mov CH,simeil1[SI]
cmp CH,96
jg  tikrinti
jle nextstep
tikrinti:
cmp CH,121
jle prideti
jg nextstep
prideti:
add skaicius1,1
nextstep:
inc SI
dec BH
cmp BH,0
je toliau1
loop cycl
toliau1:
ret
skaiciavimas1 endp

skaiciavimas2 proc
xor CX,CX
mov BH,len2
mov si,2
mov skaicius2,0
cycl1:
mov CH,simeil2[SI]
cmp CH,96
jg  tikrinti1
jle nextstep1
tikrinti1:
cmp CH,121
jle prideti1
jg nextstep1
prideti1:
add skaicius2,1
nextstep1:
inc SI
dec BH
cmp BH,0
je toliau11
loop cycl1
toliau11:
ret
skaiciavimas2 endp


 main:
mov ax,@data
mov ds,ax

;Isvalome ekrana
  mov ax,0002h
  int 10h
   
  mov ah,09h
  lea dx,message1
  int 21h
mov ah,0002
mov bh,0
mov dh,1
mov dl,0
int 10h

mov ah,0Ah
lea dx,simeil1
int 21h

mov ah,0002
mov bh,0
mov dh,2
mov dl,0
int 10h

mov ah,09h
lea dx,message2
int 21h

mov ah,0Ah
lea dx,simeil2
int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov AL,simeil1+1
mov len1,AL
mov AL,simeil2+1
mov len2,AL

;Skaiciuojame mazasias raides pirmos eilutes

call skaiciavimas1
call skaiciavimas2

;skaicius1 - pirmos eilutes mazuju raidziu kiekis
;skaicius2 - antros eilutes mazuju raidziu kiekis
mov AL,skaicius1
mov DL,skaicius2
cmp AL,DL
jg pirmaeil
jl antraeil
je abi
pirmaeil:
mov ah,0002
mov bh,0
mov dh,5
mov dl,0
int 10h
mov ah,09h
lea dx, simeil1+2
int 21h
jmp pab
antraeil:
mov ah,0002
mov bh,0
mov dh,5
mov dl,0
int 10h
mov ah,09h
lea dx,simeil2+2
int 21h
jmp pab
abi:
mov ah,0002
mov bh,0
mov dh,5
mov dl,10
int 10h
mov ah,09h
mov dx,offset message4
int 21h
jmp pab

pab:
mov ah,0002
mov bh,0
mov dh,12
mov dl,0
int 10h

mov ah,09h
lea dx,message3
int 21h
 
 mov ah,07h
 int 21h
 mov ah,4Ch
 int 21h
 
 end main