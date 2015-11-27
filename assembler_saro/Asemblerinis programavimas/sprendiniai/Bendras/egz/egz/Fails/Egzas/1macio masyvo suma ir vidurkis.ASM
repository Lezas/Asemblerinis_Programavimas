Stekas SEGMENT STACK
	DB	255 DUP(?)
Stekas ENDS

Duomenys SEGMENT
	PRAN db "Kursinis",10,13
	db "Uzduotis:	Masyvo elementu	suma ir	vidurkis",10,13
	db "Atliko:Valerija Lialina II-3/3",10,13
	db " ",10,13,'$'
	PRAN1 db 'Masyvo suma: ',13,10,'$'
	PRAN2 db 'Masyvo vidurkis: ',13,10,'$'
	KABLELIS db ',$'
	des db 10
	a db 0
	ats db ?,13,10,'$'
	SUM db 3 DUP(?),13,10,'$'
	VIDURKIS db 2 DUP(?),'$'
	LIEK db ?
	MAS db 102,2,12,33,-5,'*'
Duomenys ENDS
  
Programa SEGMENT
ASSUME SS:Stekas ,DS: Duomenys, CS: Programa
START:
     			     MOV AX,Duomenys
    			     MOV DS,AX
    			     MOV AX,0002h
   			     INT 10h
        		     MOV SI,0000
			     MOV AL,00

   			     ;sumos skaiciavimas
    			CIK1:

    			     CMP MAS[SI],'*'
		     	     JE	MAS_PAB
 		     	     ADD AL,MAS[SI]
  			     INC SI
    		             INC a
    			     JMP CIK1
  			     MAS_PAB:
    			     MOV ats,AL
    			     MOV CX,0003
    			     MOV SI,0002
   
    			CIK2:

     			     MOV AH,00
   		       	     DIV des
    			     ADD AH,30h
     		     	     MOV SUM[SI],AH
    			     DEC SI
     			     LOOP CIK2
     			     MOV AH,09h
    		             LEA DX,PRAN
     			     INT 21h
     		             LEA DX,PRAN1
     			     INT 21h
     			     LEA DX,SUM
     			     INT 21h
    
    			     ;skaiciuojam sk. pries kableli
     
    			     MOV AX,0000
			     MOV AL,ats
 		             DIV a
		             MOV LIEK,AH
  			     MOV SI,0001
			     MOV CX,0002
   
		       CIK3:
  			     MOV AH,00
 		             DIV des
   			     ADD AH,30h
     		             MOV VIDURKIS[SI],AH
   			     DEC SI
   			     LOOP CIK3
 			     MOV AH,09h
			     LEA DX,PRAN2
     			     INT 21h
   			     LEA DX,VIDURKIS
   			     INT 21h
    		             LEA DX,KABLELIS
   			     INT 21h

  			     ;skaiciuojam skaiciu po kablelio

    		             MOV AL,LIEK
   			     MOV SI,0000
   			     MOV CX,0002
  			     CIK4:
   			     MOV AH,00
 		             MUL DES
		             DIV a
  			     ADD AL,30h
  		             MOV VIDURKIS[SI],AL
  			     MOV AL,AH
    			     INC SI
    			     LOOP CIK4
    			     MOV AH,09h
   			     LEA DX,VIDURKIS
 			     INT 21h
 			     mov ah,07h
 			     int 21h
  			     MOV AH,4CH
   			     INT 21h
Programa ENDS
END START
 
