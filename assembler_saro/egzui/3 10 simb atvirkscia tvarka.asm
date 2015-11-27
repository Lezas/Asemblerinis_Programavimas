;ABC->CBA nu isvesim atvirkstine tvarka
stekas segment STACK
       DB 256 DUP(?)
stekas ENDS
duomenys segment
       text DB 'Iveskite zodi: $'
       zodis DB 20, ?, 20 DUP (' ')
       zodis_atv DB 20, '$'
duomenys ENDS
programa segment
       ASSUME SS:stekas, DS:duomenys, CS:programa
START:
       MOV AX, duomenys
       MOV DS, AX
       MOV AX, 02h
       INT 10h
       ;Isveda i ekrana teksta
       MOV AH, 09h
       LEA DX, text
       INT 21h
       ;Paima is klavos
       MOV AH, 0AH
       LEA DX, zodis
       INT 21h
       ;bbz
       MOV CL, zodis+1
       MOV SI, CX ;CX kiek raidziu zodyje...
       MOV DI, 0
CIKLAS:
       MOV AL, zodis[SI+1]
       MOV zodis_atv[DI], AL
       DEC SI ;SI=SI-1
       INC DI ;DI=DI-1
LOOP CIKLAS
       MOV zodis_atv[DI], "$" ;zodzio gale dadedam $

       MOV AX, 02h
       INT 10h
       MOV AH, 02h
       MOV DL, 25
       MOV DH, 12
       MOV BH, 0
       INT 10h
       LEA DX, zodis_atv
       MOV AH, 09h
       INT 21h
       MOV AH, 07h
       INT 21h
       MOV AH, 4CH
       INT 21h
programa ENDS
END START
