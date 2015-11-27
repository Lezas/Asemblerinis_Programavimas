.MODEL SMALL
.STACK
.DATA

a db 3
b db 4
c db 5

message DB 13,10,'Incoming Data on COM1',13,10,'$'

.CODE

START:



mov ax, 0100h
int 21h

mov ax, 4c00h
int 21h

MyProcedure PROC 
    ARG @@SecondParameter:WORD, @@FirstParameter:WORD = @@BytesUsed

    PUSH BP                            ; Save BP
    MOV BP, SP


    MOV AX, [@@FirstParameter]

    MOV AX, [@@SecondParameter]

    
    POP BP                             ; Restore BP
    RET @@BytesUsed
MyProcedure ENDP

END START



