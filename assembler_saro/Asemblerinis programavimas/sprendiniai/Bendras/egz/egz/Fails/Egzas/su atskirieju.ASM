  masm
model small
stack 256h
.data
message1 db 'Iveskite simboliu eilute: ','$'
message2 db 'Iveskite simboli atskireja: ','$'
message3 db 'Atliko:Valerija Lialina','$'
simeil   db 30,?,31 dup(?),'$'
atsk     db 2,?,3 dup(?),'$'
len      db ?
ats      db ?,'$'
skaicius db ?
tarpas   db ' '
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

;Dabar keiciame atskirejus i tarpus
XOR CX,CX
mov BH,len
mov si,2
xor ax,ax
cycl:
mov CH,simeil[SI]
cmp CH,ats
je  gochange
jne nextstep
gochange:
mov AL,tarpas
mov simeil[SI],AL
jmp nextstep
nextstep:
inc SI
dec BH
cmp BH,0
je toliau
loop cycl
toliau:

;Kursoriaus padetis
mov ah,0002
mov bh,0
mov dh,10
mov dl,79
sub dl,len
int 10h

;Galutinis isvedimas
mov ah,09h
mov dx,offset simeil+2
int 21h	

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