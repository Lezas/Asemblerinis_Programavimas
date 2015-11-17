Stekas SEGMENT STACK
	DB 256 DUP(?)
Stekas ENDS
Duom SEGMENT
	des DB 10
	a DB 10
	b DB 20
	c DB 5
	p DB 'NULIS'
	rez DB 4 DUP(' '),'$'
Duom ENDS
Prog SEGMENT
	ASSUME DS:Duom, CS:Prog, SS: stekas
START: MOV AX,Duom
	MOV DS,AX
	MOV AX,0
	MOV AL, a
	SUB AL,b
	CMP AL,0
	JE pranesimas
	JG teigiamas
	NEG AL
	MOV rez, 2Dh
	MOV BL,C
	IMUL BL
	JMP prad
	
teigiamas:
    MOV BL,c
	MUL BL
prad:	
    LEA BX, REZ+3
	MOV CX,3
ciklas: MOV AH,0
	DIV des
	ADD AH,30h
	MOV [BX],AH
	DEC BX
	LOOP ciklas
    MOV AH,09h
	LEA DX,rez
	INT 21h
	
pabaiga:
    MOV AH,4Ch
	INT 21h

pranesimas:
    MOV AH,09h
	LEA DX,p
	INT 21h
	JMP pabaiga

 	
		
Prog ENDS
END START