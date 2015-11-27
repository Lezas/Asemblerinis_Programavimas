masm
model small
stack 256h
.data
message1  db 'Iveskite skaiciu: ','$'
message2  db 'Iveskite simboliu eilute: ','$'
message3  db 'Atliko: Jurijus Antonovas II-2/1.Pirma dalis','$'
klaidosms db 'Jus ivedet ne skaiciu','$'
simeil    db 4,?,3 dup(?),'$'
len       db ?
desimt    db 10
skaicius  db ?,'$'
daugiaums db 'Jus ivedet skaicius > 255','$' 
.code

 main:
mov ax,@data
mov ds,ax

prad:
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
lea dx,simeil
int 21h

;Dabar reikia patikrinti ar ivesta informacija yra skaicius
;visi skaitmenys turi priklausyti intervalui [48;57] pagal ASCII kodus
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xor cx,cx
mov dl,simeil+1
mov si,2
cycle1:
mov CH,simeil[SI]
cmp dl,0
je tolll
cmp CH,57
jg myklaida
dec dl
inc SI
loop cycle1
tolll:

mov ah,0002
mov bh,0
mov dh,2
mov dl,0
int 10h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov AL,simeil+1
mov len,AL

mov ah,0002
mov bh,0
mov dh,4
mov dl,0
int 10h


mov skaicius,0
;;;;;Priklausomai nuo ivestu skaitmenu skaiciaus pasirenkame cikla 
cmp len,1
je c1
cmp len,2
je c2
cmp len,3
je c3

jmp tdk
myklaida:
jmp klaida
tdk:

c1:
mov CH,simeil+2
sub CH,30h
mov skaicius,CH
jmp ttt

c2:
mov AL,simeil+2
sub AL,30h
mul desimt
mov skaicius,AL
mov AL,simeil+3
sub AL,30h
add skaicius,AL
jmp ttt

prad1:
jmp prad

c3:
mov AL,simeil+2
sub AL,30h
mul desimt
mul desimt
jc daugiau
mov skaicius,AL
mov AL,simeil+3
sub AL,30h
mul desimt
add skaicius,AL
mov AL,simeil+4
sub AL,30h
add skaicius,AL
jmp ttt
ttt:


mov ah,09h
lea dx,skaicius
int 21h


mov ah,0002
mov bh,0
mov dh,12
mov dl,0
int 10h

mov ah,09h
lea dx,message3
int 21h
jmp pab

daugiau:
mov ah,09h
lea dx,daugiaums
int 21h
jmp prad1
klaida:
mov ah,09h
lea dx,klaidosms
int 21h
jmp prad1
 pab:
 mov ah,07h
 int 21h
 mov ah,4Ch
 int 21h
 
 end main