masm
model small
stack 256h
.data
message1  db 'Iveskite simboliu eilute: ','$'
message2  db 'Iveskite simboli atskireja: ','$'
message3  db 'Atliko: Aleksandr Kovaliov II-2/2. Antra kursinio darbo dalis','$'
simeil    db 30,?,31 dup(?),'$'
atsk      db 2,?,3 dup(?),'$'
len       db ?
ats       db ?
skaicius  db ?,'$'
tarpas    db ' ','$'
tarpai    db ?
simb      db ?,'$' 
tarpaiw   dw ?
teilute   db 79 dup(' ')
ppb       db '$' 
du        db 2  
.code

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
lea dx,simeil
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
lea dx,atsk
int 21h	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov AL,simeil+1
mov len,AL
mov AL,atsk+2
mov ats,AL
mov skaicius,0

;Dabar skaiciuojame zodziu kieki
XOR CX,CX
mov BH,len
mov si,2
xor ax,ax
cycl:
mov CH,simeil[SI]
cmp CH,ats
je  goplius
jne nextstep
goplius:
;;;;;;;Cia zodziu kiekio skaitiklis
add skaicius,1
jmp nextstep
nextstep:
inc SI
dec BH
cmp BH,0
je toliau
loop cycl
toliau:

;Tarpu tarp zodiu skaiciu tarpai:=(79-ilgis)/(zodius_kiekis-1)
xor AX,AX
mov al,79
sub al,len
div skaicius
mov tarpai,al

;DABAR formuojame tarpus
xor CX,CX
xor SI,SI
tcycle:
inc SI
dec tarpai
cmp tarpai,0
je tol
loop tcycle
tol:
mov CH,ppb
mov teilute[SI],CH

;Kursoriaus padetis
mov ah,0002
mov bh,0
mov dh,10
mov dl,0
int 10h
;Dabar spausdiname zodzio raides, o po ju spausdiname tarpus

XOR CX,CX
mov BH,len
mov si,2
xor ax,ax
cycl1:
mov CH,simeil[SI]
mov simb,CH
cmp CH,ats
je  goplius1
jne nextstep1
goplius1:
;;;;;Cia spausdiname tarpus;;;;;;;;;;;;

mov ah,09h
lea dx,teilute
int 21h

nextstep1:

cmp CH,ats
jne spaudinti
je trr
spaudinti:
mov ah,09h
lea dx,simb
int 21h

jmp trr

trr:
inc SI
dec BH
cmp BH,0
je toliau1
loop cycl1
toliau1:

mov ah,0002
mov bh,0
mov dh,12
mov dl,0
int 10h

mov ah,09h
lea dx,message3
int 21h

 pab:
 mov ah,07h
 int 21h
 mov ah,4Ch
 int 21h
 
 end main