; steko segmentas
stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS

duomenys SEGMENT
prana db 'iveskite a: ','$'
pranb db 10,13, 'iveskite b: ','$'
a DB 0
xa DB 0
b DB 0
rezpan db 10,13
rezultatas DB 3 DUP (0), '$'
des DB 10
trisdes DB 30h
ivsr DB 4, ?, 4 DUP(0)
duomenys ENDS
 
programa SEGMENT
ASSUME CS:programa, DS:duomenys, SS:stekas

grybas proc
ciklas:
MUL des
MOV a,AL
MOV BL, [SI]
SUB BL,trisdes
ADD a,BL
INC SI
LOOP ciklas
MOV BL, a
ret     
grybas endp

START: 	MOV AX, duomenys
 	MOV DS, AX

	;isvedame pranesima apie a
	mov ah,09h
	lea dx,prana
	int 21h

	MOV AH,0Ah
	LEA DX,IVSR
	INT 21h
	

	;isvedamas pirmas skaicius
	MOV CL, IVSR+1
	MOV CH, 0
	LEA SI, IVSR+2
	MOV AH,[SI]

			MOV AL,a
			call grybas

	MOV xa, BL

	;isvedame pranesima apie b
	MOV AH,09h
	LEA DX,pranb
	INT 21h	

	;ivedimas antras skaicius
	MOV AH,0ah
        LEA DX,ivsr
        INT 21h
        
        MOV CL,ivsr+1
        MOV ch,0
        LEA SI,ivsr+2

        		MOV AL,b
   			call grybas

	MOV AL,xa
	ADD AL,b
		
	MOV AH,0
	DIV des  
	ADD AH,trisdes
	MOV rezultatas+2,ah
		
	MOV AH,0
	DIV des
	ADD AH,trisdes
	MOV rezultatas+1,AH
		
	MOV ah,0
	DIV des
	ADD ah,trisdes
	MOV rezultatas, ah
		
	;isvedimas
	MOV ah,09h
	LEA dx,rezpan
	INT 21h

	MOV AH, 4Ch
	INT 21h

   
	programa ENDS     
	END START 