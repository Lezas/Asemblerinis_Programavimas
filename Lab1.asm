Stekas SEGMENT STACK
	DB 256 DUP(?)
Stekas ENDS
Duom SEGMENT
PRAN	DB 'Pirma eilute',10,13
		DB 'Antra eilute','$'
Duom ENDS
Prog SEGMENT
	ASSUME DS:Duom, CS:Prog, SS:Stekas
START: MOV AX,Duom
		MOV DS,AX
		;pasiruosimas
		MOV AH,09h
		LEA DX,PRAN
		INT 21h
		;grizimas is programos i musu sistema
		MOV AH,4Ch
		INT 21h
Prog ENDS
END START