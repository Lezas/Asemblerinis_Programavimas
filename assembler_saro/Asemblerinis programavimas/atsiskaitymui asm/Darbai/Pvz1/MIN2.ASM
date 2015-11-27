; Minimali asemblerio programa
StkSeg  SEGMENT PARA STACK 'STACK'
        DB      100h DUP (?)
StkSeg  ENDS

Data    SEGMENT WORD 'DATA'
Data    ENDS

Code    SEGMENT WORD 'CODE'
        ASSUME  cs:Code, ds:Data
Start   PROC    FAR
        ; Inicializuojam duomen÷
        ; segmento registr–
        mov     ax, Data
        mov     ds, ax

        ; Programos kodas —ia


        ; I’eiti DOS funkcija
        mov     ah, 4Ch
        int     21h
Start   ENDP
Code    ENDS
        END   Start
