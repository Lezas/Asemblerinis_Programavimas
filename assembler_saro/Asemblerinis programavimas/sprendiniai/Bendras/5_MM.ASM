Stekas SEGMENT stack
DB 256 DUP(?)
Stekas ENDS
Duom SEGMENT
a db 8
b db 1
c db 2
du db 2
des db 10
rezult db 'rezultatas - '
sk db 3 dup(' ')
liekana db ' liekana - '
liek db 3 dup(' '),'$'
Duom ENDS

Prog SEGMENT
ASSUME SS:Stekas , DS:Duom , CS:Prog
Start:                              
MOV AX,Duom
MOV DS,AX  
MOV AL,a   
MOV AH,0   
MUL a      
MUL du     
ADD AL,b   
DIV c      
ADD AH,30h 
MOV liek+2,ah
MOV liek+1,0h
MOV liek,0h
MOV AH,0
DIV des 
ADD AH,30h

MOV SK+2,AH
MOV AH,0
DIV des 
ADD AH,30h
MOV SK+1,AH
MOV AH,0
DIV des 
ADD AH,30h
MOV SK,AH

MOV AH,09h
LEA DX,rezult
INT 21h
MOV AH,4ch
INT 21h
Prog ENDS
END Start
