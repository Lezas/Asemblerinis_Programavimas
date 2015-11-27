stekas SEGMENT STACK
	DB 256 DUP(?); ISSKIRIAME ATMINTYJE 256 BAITUS
stekas ENDS
CR EQU 13
LF EQU 10
duomenys SEGMENT
pran DB 'SVEIKI, ', CR, LF
DB 'LINKEJIMAI IS MARSO ', CR, LF
DB 'MARSIETIS NR.5', '$'
duomenys ENDS
Programa SEGMENT
	 ASSUME CS: Programa, DS: Duomenys, SS: Stekas; programos darbo pradzia
START: MOV AX, Duomenys
       MOV DS, AX
; pranesimo isvedimas
; AH <- nurodome operacija 09h
MOV AH, 09h
LEA DX, pran
INT 21h
MOV AH, 4Ch
INT 21h
programa ENDS
END START