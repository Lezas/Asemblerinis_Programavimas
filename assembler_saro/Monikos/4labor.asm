 ; steko segmentas
stekas SEGMENT stack
DB 256 dup (?)
stekas ENDS

duomenys SEGMENT
liekana DB 10,13,'liekana'
svd DB 10,13,'sveikoji dalis '
des DB 10
a DB 15
b DB 13
c DB 5
x DB 0
du DB 2
trys DB 3
rez DB 0
liek DB 0 
duomenys ENDS

programa SEGMENT
ASSUME CS:programa, DS:duomenys, SS:stekas
; paruosiame duomenu segmento registra

START:	MOV AX,duomenys
	MOV DS,AX  

	MOV AL,a; AL=15(turesime f)
	MOV BL,b; BL=13 (turime D)
	MOV CL,c; CL=5(turime 5)
	ADD al,bl
	SUB al,cl
	MOV dl, du
	MUL dl
	MOV dl,trys
	DIV dl
	MOV liek,ah
	MOV rez,al
	
Ciklas: MOV bl,10
	DIV bl
	ADD ah,30h
	ADD al,30h
	MOV cl,al
	MOV ch, ah
	
	;LOOP Ciklas


	MOV AH, 4Ch
	INT 21h
programa ENDS
END START
	