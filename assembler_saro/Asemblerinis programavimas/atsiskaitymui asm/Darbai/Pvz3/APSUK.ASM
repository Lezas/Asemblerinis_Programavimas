; apsuk.asm

        PRNFN   EQU 09h
        INPFN   EQU 0Ah

StkSeg  SEGMENT PARA STACK 'STACK'
        DB      100h DUP (?)
StkSeg  ENDS

Data    SEGMENT WORD 'DATA'
IveEil  DB      'Ωveskite eilut“: $'
ApsEil  DB      'Eilut” atvirk’—iai: $'
MaxLen  DB      50
ActLen  DB      0
Buffer  DB      51 DUP (?)
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
        mov     dx, offset IveEil
        call    Print

        mov     ah, INPFN
        mov     dx, OFFSET MaxLen
        int     21h

        mov     si, OFFSET Buffer       ; si <- @Buffer
        sub     ax, ax                  ; ax <- 0
        mov     al, [ActLen]
        mov     di, OFFSET Buffer
        mov     BYTE PTR [di + 1], '$'
        add     ax, di
        mov     di, ax

l:      cmp     si, di
        jge     ll

        mov     ah, [si]
        mov     al, [di]
        xchg    ah, al
        mov     [si], ah
        mov     [di], al

        jmp     short l

ll:     mov     dx, OFFSET Buffer
        call    Print
        

        mov     dx, offset ApsEil
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



INT 21
    AH = 0Ah
    DS:DX -> buffer

Note:   first byte of buffer must contain maximum length
    on entry, second byte contains actual length of previous line which
      may be recalled with the DOS line-editing commands
    on return the second byte contains actual length, third and
      subsequent bytes contain the input line

