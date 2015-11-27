
;
;  Isvedimas i ekrana..
;
stekas SEGMENT STACK
 DB 256 DUP (?) ; isskiriame atmintyje 256 baitus
stekas ENDS

CR EQU 13
LF EQU 10

duomenys SEGMENT
; CR ir LF padaro nauja eilute
 pranesimas DB ' Sveiki, ', CR, LF
            DB ' Linkejimai is Marso!', CR, LF, CR, LF
            DB '  Marsietis Nr.3', '$'
duomenys ENDS

programa SEGMENT
 ASSUME CS:programa, DS:duomenys, SS:stekas

START:
; pradzia
MOV AX, duomenys
MOV DS, AX

; isvalyti ekrana
MOV AX, 0002h
INT 10h

; pranesimo isvedimas
MOV AH, 09h
LEA DX, pranesimas
INT 21h

; paspausti bet koki mygtuka
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START