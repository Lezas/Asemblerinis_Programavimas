masm
model small
stack 100h
.data
    skdubl db ?,'$'	
    delt db 0
    tmpsk db 0	
    txtlen equ 150
    skaicius db  ?
    skaicius1 db ?
    skaicius2 db ?
    message db ' Iveskite failo varda:','$'
    prskirtukas db ' Iveskite simboli atskireja ','$'
    ivsr db 19,?,20 dup(?),'$'                                                            
    ivsr2 db 2,?,3 dup(?),'$' 
    filename db 15 dup(?),0,'!$'
    message1 db ' IVYKO I/O klaida! ','$' 
    messageOK db '<-------------------TURINYS:----------------------->','$'			
    fileid dw 0
    bufer db txtlen dup(?),'$'
    entr db 13,'$'
    info db 'Atliko Jurijus Antonovas II-2/1. Trecia dalis','$'
    File_name db 'galut.txt',0
    pirmzod db ?,'$'
    tarpas db ' ','$'	
.code
                   
main:  
        mov ax,@data
        mov ds,ax

 	mov ax,0002h ;ekrano isvalymas            
	int 10h   

        mov ah,09h
        lea dx, message       
        int 21h  

	mov ah,0ah
	lea dx,ivsr
	int 21h	                                    
	
mov ah,0002
mov bh,0
mov dh,2
mov dl,0
int 10h

mov ah,09h
lea dx,prskirtukas
int 21h

mov ah,0Ah
lea dx,ivsr2
int 21h
	mov ax,0002h ;ekrano isvalymas            
        int 10h   
		
	mov ah,0002
	mov bh,0
	mov dh,0
	mov DL,0
	int 10h
      
mov CX,12  
mov DL,ivsr+1
mov BX,offset ivsr+2
xor SI,SI

cycl:
mov AL,[BX][SI]
mov filename[SI],AL
INC SI
DEC DL
cmp DL,0
je toliau
loop cycl

toliau:

mov ah,09h
mov dx,offset messageOK       
int 21h 

mov ax,3D00h
mov dx,offset filename
int 21h
jc ERROR1

mov fileid,AX   
mov ah,3Fh
mov bx,fileid
mov cx,txtlen
mov DX,offset bufer
int 21h

jc ERROR1

mov ah,0002
mov bh,0
mov dh,2
mov dl,0
int 10h

;Failo turinys
mov ah,09h
mov dx,offset bufer
int 21h

;Skaiciuojame teksto charakteristikas.
mov CX,txtlen
xor SI,SI
xor AX,AX
mov skaicius,0

jmp tol
ERROR1:
jmp ERROR
tol:

;Simboliu skaicius
cyclsimb:
mov CH,bufer[SI]
inc SI
cmp CH,ivsr2+2
je goadd
jne nextstep
goadd:
add skaicius,1
jmp nextstep
nextstep:
loop cyclsimb
add skaicius,1

;Skaiciuojame eilutes
mov CX,txtlen
xor AX,AX
xor SI,SI
mov skaicius1,0
cycleilut:
mov CH,bufer[SI]
inc SI
cmp CH,entr
je goadd1
jne gonext2
goadd1:
add skaicius1,1
gonext2:
loop cycleilut

;Skaiciuojame zodzius
mov CX,txtlen
xor SI,SI
mov skaicius2,0

cycleof:
mov CH,bufer[SI]
inc SI
cmp CH,entr
je govsio
jne goaddk
govsio:
mov DH,skaicius2
goaddk:
add skaicius2,1
loop cycleof
mov skaicius2,DH
;;;;;;;;;;;;;;;;;
;Skaiciuojame pirmojo zodzio raides
xor CX,CX
xor ax,ax
xor si,si
XOR DL,DL
cycle1:
mov CH,bufer[SI]
cmp CH,ivsr2+2
je ttk
jne addone
addone:
add SI,1
add DL,1
loop cycle1
ttk:
mov pirmzod,DL
;;;;;;;;;;;Keiciame simbolius skirtukus i tarpus
XOR CX,CX
mov BH,txtlen
mov SI,0
xor ax,ax
mycycle:
mov CH,bufer[SI]
cmp CH,ivsr2+2
je mychange
jne mynext
mychange:
mov AL,tarpas
mov bufer[SI],AL
jmp mynext
mynext:
inc SI
dec BH
cmp BH,0
je tt
loop mycycle
tt:

;Dabar suskaidom masyva bufer i eilutes
mov tmpsk,0

mov CX,txtlen
xor SI,SI
mov DL,pirmzod 

cycleof1:
mov CH,bufer[SI]
cmp CH,tarpas
je govsio1
jne goaddk1
govsio1:
add tmpsk,1
cmp tmpsk,DL
je inss
jne goaddk1
inss:
mov bufer[SI],13
mov tmpsk,0
goaddk1:
add SI,1
loop cycleof1
mov ah,0002
mov bh,0
mov dh,20
mov dl,0
int 10h

mov ah,09h
lea dx,info
int 21h

;Irasome i faila galut.txt

mov ax,3D01h
mov dx,offset File_name
int 21h
jc ERROR
mov fileID,AX

mov ah,40h
mov BX,fileID
mov CX,56
mov DX,offset bufer
int 21h
jc ERROR

jmp pab
ERROR:
mov ah,09h
lea dx,message1
int 21h
jmp pab       

pab:         
	mov ah, 07h ;laukimas
        int 21h
        
        MOV ah,4Ch
        INT 21h                     
                                
end main