STEKAS SEGMENT STACK
	DB 256 DUP(?)
STEKAS ENDS

DUOM SEGMENT 
 PRAN DB 'Pirmas laboratorinis darbas.', 13,10, '$'
 PRAN1 DB 'ATLIKO MANTAS',13,10,'$'
DUOM ENDS

;PROGRAMOS SEGMENTAS

PROGR SEGMENT
	ASSUME CS:PROGR, DS:DUOM, SS:STEKAS
	START:     
	           
	MOV AX,DUOM
	MOV DS,AX
;isvalom ekrana
        MOV AX, 0002H
        INT 10H
;ISVEDIMAS I EKRANA
;PADUODAM KINTAMAJI I DX REGISTRA IR JI SPAUSDINAM

	MOV AH, 09H
	LEA DX,PRAN
	INT 21H 
                
	MOV AH, 09H
	LEA DX,PRAN1
	INT 21H	
                
        MOV AH,07H
        INT 21H
               
	MOV AH,4CH
	INT 21H 
	        
	
        	 
      	         
PROGR ENDS       
	END START