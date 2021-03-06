stekas SEGMENT STACK
   DB 256 DUP (?)
stekas ENDS

duomenys SEGMENT
   ivsr         DB 255,?,255 DUP(' ')
   pran         DB 'Iveskite Pavarde: ','$'
   failas       DB 'C:\ASM\TASM\Temp\text.FIL',00h
   DESKRIPTOR   DW  ?  ;failo deskriptorius
   Klaidpr      DB ' Klaida!', '$'
duomenys ENDS

programa SEGMENT
   ASSUME CS:programa, DS:duomenys, SS:stekas

START:
; pradzia
   MOV AX, duomenys
   MOV DS, AX
; isvalome ekrana
   MOV AX,0600h  ;operacijos kodas- ekrano valymas
   MOV BH,07
   MOV CX,0000    ;eilute ir stulpelis
   MOV DX,184Fh  ;eilute ir stulpelis
   INT 10h
; pranesimas
   MOV AH, 09h
   LEA DX, pran
   INT 21H
; ivedimas
   MOV AH, 0Ah
   LEA DX, ivsr
   INT 21h
; failo sukurimas
   MOV AH,3CH ; papra�yti sukurti faila
   MOV CX,00  ;nenaudojame atributu
   LEA DX, failas ;kelio eilutes adresas
   INT 21h   ; pertraukimas operacijai ivykdyti
   JC KLAIDA ; jei ivyko klaida
   MOV DESKRIPTOR,AX ;isiminti failo deskriptoriu
; rasymas i faila
   MOV AH, 40H    ; papra�yti u�ra�yti duomenis i faila
   MOV BX, DESKRIPTOR  ;Ira�yti failo deskriptoriu
   MOV CX,100h     ;patalpinti ira�omo fragmento ilgi
   LEA DX,IVSR+2  ;patalpinti i�vedimo srities adresa
   INT 21h   ;ivykdyti pertaukimo operacija duomenu ra�ymui
   JC  KLAIDA  ;     Jei buvo ira�ymo klaida
   CMP  AX,100h    ; Ar visi baitai ira�yti
   JNE  KLAIDA     ;Jei ne visi baitai ira�yti, eiti i klaidos apdorojima.
; failo uzdarymas
   MOV  AH,3EH    ;Papra�yti u�daryti faila
   MOV  BX,DESKRIPTOR   ;U�ra�yti failo deskriptoriu
   INT 21h   ;Ivykdyti pertraukima
   JC KLAIDA   ;perduoti valdyma klaidos apdorojimui.
; baigiam darba
   JMP PABAIGA
KLAIDA:
   LEA DX, Klaidpr
   MOV AH, 09h
   INT 21h

PABAIGA:
; paspausti bet koki klavisa
MOV AH, 07h
INT 21h

; iseiti is programos
MOV AH, 4ch
INT 21h

programa ENDS

END START