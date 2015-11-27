; steko segmentas
stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS
 
duomenys SEGMENT
p1 DB 'iveskite pavarde','$'
ivsritis DB 20, ?, 20 DUP(' ')
du DB 2
DOLERIS DB '$'
duomenys ENDS
 
programa SEGMENT
ASSUME CS:programa, DS:duomenys, SS:stekas
 
START: 	MOV AX, duomenys
 	MOV DS, AX
;pranesimas spausdinamas
;isvalo langa     
	MOV AX, 0600h
	MOV BH, 07
	MOV CX, 0 
	MOV DX, 184fh
	INT 10h   
;isveda pranesima, kad ivest pavarde
	MOV AH, 09h
	LEA DX, p1
	INT 21h   
                  
	MOV AH, 0Ah
	LEA DX, ivsritis
	INT 21h   
                  
	LEA BX, ivsritis+2
	ADD BL, ivsritis+1
	MOV CH, DOLERIS
	MOV [BX], CH
                  
	MOV AH,0  
	MOV DL, 80
	SUB AL, ivsritis+1
	DIV du    
	MOV DL, AL
	MOV DH, 12
                  
	MOV AH, 02
	int 10h   
                  
	MOV Ah, 09h
	LEA DX, ivsritis+2
	INT 21h   
                  
	MOV AH, 4Ch
	INT 21h   
programa ENDS     
END START 