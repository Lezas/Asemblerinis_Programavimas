;steko segmentas       
stekas SEGMENT STACK   
DB 256 DUP (?)         
stekas ENDS            
                       
CR equ 13 ;eilutes pratesimas
LF equ 10 ;eilutes pabaiga
                       
duomenys SEGMENT       
pran DB 'sveiki, tai as',CR,LF
DB 'jusu kelrode zvaigzde',CR,LF
DB 'pabaiga','$'               
duomenys ENDS          
                       
programa SEGMENT       
ASSUME CS:programa, DS:duomenys, SS:stekas
;paruosiame duomenu segmento registra
START: MOV AX, duomenys
      	MOV DS, AX     
;pranesimo spausdinimas
MOV AH, 09h            
LEA DX, pran
INT 21h                
MOV AH, 4ch             
INT 21h                
programa ENDS          
                       
END START