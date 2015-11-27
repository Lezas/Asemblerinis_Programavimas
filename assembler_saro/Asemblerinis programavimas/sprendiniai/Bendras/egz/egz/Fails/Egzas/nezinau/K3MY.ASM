masm
model small
stack 1000h
.data
    skdubl db ?,'$'	
    a db ?
    b db ?
    c db ?
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
    messageOK db '<------------------FAILO-TURINYS:----------------------->','$'			
    fileid dw 0
    bufer db 150 dup(?),'$'
    entr db 13,'$'
    info db 'Zodziu kiekis ',3 dup(?),' Eiluciu kiekis ',3 dup(?),' Simboliu kiekis ',3 dup(?),'$'
    File_name db 'chof.txt',0	
.code

formskaicius proc
xor ax,ax
mov delt,100
div delt
mov a,AL ;turime a
mov tmpsk,100
mul tmpsk
mov BL,skdubl
sub BL,AL;gavome bc
mov AL,BL
mov delt,10
div delt
mov b,AL ;Jau turime b
mov tmpsk,10
mul tmpsk
mov BL,skdubl
sub BL,AL
mov c,BL ;turime c
add a,30h
add b,30h
add c,30h
;Graziname argumentus
mov AL,a
mov BL,b
mov CL,c
ret
formskaicius endp
                     
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
	
mov ax,0002h
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
;1.Zodziu skaicius

mov CX,txtlen
xor SI,SI
xor AX,AX
mov skaicius,0

jmp tol
ERROR1:
jmp ERROR
tol:

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

;Skaiciuojame simbolius
mov CX,txtlen
xor AX,AX
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
;Formuojame trizenklio skaiciaus vaizda
;1. dirbame su 'skaicius'
mov AL,skaicius
mov skdubl,AL
call formskaicius
mov info+14,AL
mov info+15,BL
mov info+16,CL

mov AL,skaicius1
mov skdubl,AL
call formskaicius
mov info+33,AL
mov info+34,BL
mov info+35,CL

mov AL,skaicius2
mov skdubl,AL
call formskaicius
mov info+53,AL
mov info+54,BL
mov info+55,CL

mov ah,0002
mov bh,0
mov dh,20
mov dl,0
int 10h

;Tikriname
mov ah,09h
lea dx,info
int 21h
;------------Beveik--viskas----------------------------
;Irasome i faila chof.txt
mov ax,3D01h
mov dx,offset File_name
int 21h
jc ERROR
mov fileID,AX

mov ah,40h
mov BX,fileID
mov CX,56
mov DX,offset info
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