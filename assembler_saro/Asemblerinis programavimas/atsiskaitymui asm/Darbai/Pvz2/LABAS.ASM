; labas.asm

        PRNFN   EQU 9

StkSeg  SEGMENT PARA STACK 'STACK'
        DB      100h DUP (?)
StkSeg  ENDS

Data    SEGMENT WORD 'DATA'
Vardas  DB      'Labas,', 10, 13, '$'
Pavarde DB      'pasauli!', 0Ah, 0Dh, '$'
Data    ENDS

Code    SEGMENT WORD 'CODE'
        ASSUME  cs:Code, ds:Data
Start   PROC    FAR
        ; Inicializuojam programos
        ; i’”jimo adres–
        push    ds
        sub     ax, ax
        push    ax
        mov     ax, Data
        mov     ds, ax

        ; Programos kodas —ia
        mov     dx, offset Vardas
        call    Print
        mov     dx, offset Pavarde
        call    Print

        ; I’eiti DOS funkcija
        ret
Start   ENDP

        ; Proced◊ra, kuri i’spausdina eilut“ ‘ ekran–
Print   PROC    NEAR
        mov     ah, PRNFN
        int     21h
        ret
        ENDP
Code    ENDS
        END   Start
