STEKAS  SEGMENT STACK

        DB 256 DUP (?)
        
STEKAS ENDS

DUOMENYS SEGMENT

a DB 2
b DB 8
c DB 3

x db 4 dup (?), 10,13,'$'
des db 10,'$'

SV DB 'Rezultatas yra toks: ',10,13,'$'



DUOMENYS ENDS

PROGRAMA SEGMENT

        ASSUME SS:STEKAS, DS:DUOMENYS, CS:PROGRAMA
        
        START:  
             
         MOV AX,DUOMENYS
         MOV DS,AX
                 mov ax,02h
                 int 10h 
             MOV AL,a
             ADD AL,b
             MOV bl,c
             mul bl
                mov si,3
                mov cx,4
               
             ATS:
             mov ah,0
             div des
             add ah,30h
             mov x[si],ah
             cmp al,0
             je baig 
             dec si
             
             
             loop ATS
                 
                 baig:
                 mov ah,09h
                 lea dx,SV
                 int 21h
               
                 mov ah,09h
                 lea dx,x
                 int 21h
               
                 mov ah,07h
                 int 21h
                 mov ah,4ch
                 int 21h
             
         PROGRAMA ENDS
         END START
                 
            