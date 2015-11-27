;Rasti desimt kas antro baito reiksmiu vidurki (OA masyvo pavidalu) ir rezultata 
;atspausdinti ekrane. Vidurkis su vieno zenklo po kablelio tikslumu
STEKAS SEGMENT STACK
   DB 256 DUP (?)
STEKAS ENDS
          
DUOMENYS SEGMENT
;IVSR DB 5, ?, 5 DUP(?) 
mas db 20 dup(?)  
nulis db 0
;penki db 5
desim DB 10 
SVEIK DB 3 DUP(' '),'$'
LIEK DB 3 DUP(' '),'$'
;PRAN DB 'iveskite skaiciu: ','$'
SVEIKAS DB 'Sveikoji dalis: ','$'
LIEKANA DB 'Liekana: ', '$'          
          
DUOMENYS ENDS             
                                                       
PROGRAMA SEGMENT                                           
ASSUME CS:PROGRAMA, DS:DUOMENYS, SS:STEKAS 
          
START:                                    
          
MOV AX, DUOMENYS                                 
MOV DS, AX
          
; issivalom ekrana
MOV AX, 0002h
INT 10h   
          
; pranesimas1
;MOV AH, 09h
;LEA DX, PRAN
;INT 21h   
          
;LEA DX, IVSR ; IVSR adresas uzduodamas registre DX
;MOV AH, 0Ah  ; duomenu ivedimo operacijos kodas, nurodomas registre AH
;INT 21h      ; ivedimo vykdymas
                
; KURIAM MASYVA 
 MOV BP,0  ;MASYVO KINTAMASIS
 MOV CL,20       
; CIKLAS        
CIKLAS:         
   ;IS KLAVIETUROS PAIMAM REIKSME IR JA ISSAUGOM AL REIGSTRE
  MOV AL, nulis    
                
   MOV Mas[BP], AL ; AL REIKSME PERDUODAM I MASYVO ELEMENTA
   INC AL
   INC BP ; DIDINAM VIENETU BP
LOOP CIKLAS     
                
; VIDURKIO SKAICIAVIMAS
   MOV AL, 0 ; SVEIKOJI DALIS
   MOV AH, 0 ; LIEKANA
   MOV CL, desim
; ANTRAS CIKLAS
CIKLAS2:
   ADD AL,MAS[BP] ; PRIDEDAM  MASYVO ADRESA I AL
   INC BP ; DIDINAM VIENETU BP
   INC BP ; DIDINAM VIENETU BP
LOOP CIKLAS2
DIV desim  ; KINTAMASIS 5
; AL IR AH DB PERVESTI I SVEIKUS SKAICIUS REIKIA IR ATSPAUZDINTI EKRANE

; KURIAM SKAICIU
MOV liek, AH 
MOV AH, 0

; SVEIKOJI DALIS

DIV desim
MOV sveik+1, AH
ADD sveik+1, 30h
MOV AH, 0

DIV desim
MOV sveik, AH
ADD sveik, 30h

; LIEKANA
MOV AL, liek
MOV AH, 0

DIV desim
MOV liek,AH
ADD liek,30h

; SPAUSDINAM REZULTATA
MOV AX, 0002h
INT 10h

MOV AH, 02
MOV BH, 00
MOV DH, 01 ; kursoriaus pervedimas i pirma eilute
MOV DL, 00 ; kursoriaus nustatymas i 0 kolonele
INT 21h   
MOV AH, 09h
LEA DX, SVEIKAS
INT 21h   

MOV AH, 02     
MOV BH, 00     
MOV DH, 01     
MOV DL, 14     
INT 21h   
MOV AH, 09h
LEA DX, SVEIK
INT 21h          

;LIEKANOS DALIS
MOV AH, 02
MOV BH, 01
MOV DH, 02
MOV DL, 00
INT 21h   
MOV AH, 09h
LEA DX, LIEKANA
INT 21h        
               
MOV AH, 02     
MOV BH, 01     
MOV DH, 02     
MOV DL, 14     
INT 21h   
MOV AH, 09h
LEA DX, LIEK
INT 21h    

; stabdom darba (programos uzlaikymas)
MOV AH, 07h
INT 21h

;PABAIGA  
MOV AH, 4ch
INT 21h   
PROGRAMA ENDS
END START 
























