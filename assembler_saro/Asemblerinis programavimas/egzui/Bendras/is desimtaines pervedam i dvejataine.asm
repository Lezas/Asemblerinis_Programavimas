stekas segment stack                                         
        db 256 dup (?)                                       
stekas ends                                                          
;========================                                            
duomenys segment                                                     
vp   db 10,13,'Viktorija Briskmanaite, II-04/4','$'
     db 'Programa papraso ivesti skaiciu desimtaineje sistemoje,',10,13
     db 'ir isveda ta skaiciu dvejetaineje sistemoje',10,13,'$'
pran db 10,13,'Iveskit Desimtaini skaiciu:',10,13,'$'
pran_rez  db 10,13,'Dvejetaine forma skaicius:',10,13,'$'
exitas  db 10,13,10,13,'...iseiti, spauskite bet kuri klavisa.','$'
err_msg db 10,13,10,13,' KLAIDA! Programa veikia tik su sveikais skaiciais!'
        db 10,13,'Kartosite? [y - taip]','$'                         
duom  db 6,?,6 dup (0)  ; inicializuojam nuliu
rez   db 50,?,50 dup (?)      
des db 10
du_w  dw 2                    
minus db '-' ; pradzioj kaip palyginimo, poto saugojimui :)
duomenys ends                                                      
;========================                                          
programa segment                                                   
assume CS:programa, DS:duomenys, SS:stekas                         
start:                                                             
        MOV     AX, duomenys                                       
        MOV     DS, AX          ; Pradzia, kaip visada                                   
                                                                   
        MOV     AX, 0002h                                          
        INT     10h             ; ekrano valimas                         
                                                                   
        MOV     AH, 09h                                            
        LEA     DX, vp                                             
        INT     21h             ; pranesimas                         
        LEA     DX, pran                                           
        INT     21h             ; paprasom skaiciaus                         
                                                                   
        MOV     AH, 0ah                                            
        LEA     DX, duom                                           
        INT     21h             ; Gavau skaiciu                        
                                                                   
                                          
        XOR     CH, CH          ; kad nemaisytu ciklui                        
        MOV     CL, duom + 1    ; ciklo inicializavimas
        LEA     SI, duom + 2                          
kontrole:                       ; tikrinsim ar tai sveikas skaicius!                      
        MOV     AL, [SI]      
        CMP     AL, 2dh         ; '-'
        JE      okey            ; jei '-' :/
                              
        CMP     AL, 30h         ; '0'
        JL      klaida          ; jei < '0'
                              
        CMP     AL, 39h         ; '9'
        JG      klaida          ; jei > '9'
                              
        SUB     AL, 30h       
        MOV     [SI], AL               
                              
        JMP     okey          
klaida:                       
        JMP     erroras                     
okey:                         
                                
        INC     SI                 
        LOOP    kontrole           
                              
        ; pradedam skaiciavima                                     
        XOR     AX, AX          ; issivalom                        
        XOR     CX, CX                                             
        LEA     SI, duom + 2    ; ivesto skaiciaus pradzios adresas
                                                                   
        MOV     CL, duom + 1    ; ivesta skaiciu (ciklo skaitliukas)
                                                                   
        XOR     BX, BX          ; del bendros tvarkos              
        MOV     BL, duom + 2    ; BL <- registras su kuruio dirbsim                         
                                                                   
        CMP     BL, minus       ; ar minusas?         
        JE      problemele      ; turim minusa                         
        JMP     pervedimas      ; tai teigiamas skaicius                  
                                                                   
problemele:                     ; spredziam problemele             
        MOV     BL, 1                                              
        MOV     minus, BL       ; taupom baituka :) (minus = 1 TRUE)
        INC     SI              ; kad pimas butu skaicius one zenklas
        DEC     CX              ; maziau suksim skaitliuka LOOP    
                                                               
        XOR     BH, BH                                                           
pervedimas:                     ; pervedam i 001011101... arba mums - HEX
        MUL     des          ; AX pradzioj 0000, poto kaip reik
        MOV     BL, [SI]                                       
        ADD     AX, BX          ; ... ir vis pridedam padaugine
        INC     SI              ; ...einu prie sekancio...     
        LOOP    pervedimas                                                  
        ; dabar CPU supranta ka turejau galvoje ;->                         
                                                                            
        PUSH    '$'             ; pirmasis, paskui paskutinysis :=D              
        CMP     minus, 1        ; tai minusas ?                
       	JE      big_problem                                    
      	JMP     no_problem                                     
big_problem:                    ; konveruojam i neigiama tada      
      	NEG     AX              ; keiciam i neigiama           
no_problem:                     ; ... arba einam toliau        
	MOV     BX,0002h       ; dalybai is dvieju               
istacka:                        ; verciam i "human" kalba :)   
        XOR     DX, DX          ; "devided by zero" isvengimas                                 
	IDIV    BX              ; AX - cveikoji, DX - liekana  
        PUSH    DX              ; po 01001... i stekiuka :)         
                                                               
	CMP     AX, 0000h       ; cveikoji dalis = 0 ? :) einam toliau tada
 	JE      spausdinam      ; sukisom visa skaiciu i steka 
 	JMP     istacka         ;... vis dar kisam...          
                                                               
spausdinam:          	                                       
     	XOR     AX, AX                                                              
     	MOV     AH, 09h                                                             
      	LEA     DX, pran_rez                                                        
      	INT     21h                                                                 
nebekiskistacka:                ; tada spausdinam :)           
 	POP    	DX                                                                  
	CMP  	DX, '$'         ; ar jau pabaiga ?                                  
	JE 	outas           ; kai baiksim tai ir pabaigsim 
	                                                       
	                                                                                                                                      
	                                                       
	ADD    	DX, 30h         ; atverciam i "human" kalba                                        
	MOV    	AH, 02h         ; spausdinimas po viena simboli                                                                                         
      	INT    	21h             ; parodom "human" kalba ka turejo CPU registruose                                        
      	JMP    	nebekiskistacka                                                    
      	      	                                                                            
outas:                          ; baigiam programa
        MOV     AH, 09h         
        LEA     DX, exitas      
        INT     21h             ; pabaigos pranesimas
                      
        MOV     AH, 07h                                               
        INT     21h             ; palaukiam :)                                                        
                      
        JMP     dosas 
startas:              
        JMP     start  
erroras:               
        MOV     AH, 09h
        LEA     DX, err_msg
        INT     21h        
                           
        MOV     AH, 08h         ; tik vienas simboliukas          
        INT     21h             ; turime jau ir skirtuka
        CMP     AL, 79h         ; kartosime? 79h - 'y'
        JE      startas
dosas:                                                                                            
        MOV     AH, 4ch                                            
        INT     21h             ; Laisve DOS'ui !                                                    
programa ends                                                                       
end start        