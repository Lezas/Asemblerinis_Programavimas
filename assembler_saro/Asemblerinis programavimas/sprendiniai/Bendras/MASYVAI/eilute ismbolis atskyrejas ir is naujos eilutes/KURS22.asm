stekas segment stack
db 256 dup(0)
stekas ends

cr equ 13
lf equ 10
        
duomenys segment
         
pran1    db 'Kursinis darbas Nr.2',cr,lf
         db 'Atliko Giedrius Karaliunas, II-2/3 gr.',cr,lf,'$'
pran2    db cr,lf,'Ivesta simboliu eilute programa suskaido tam tikra',cr,lf
         db 'tvarka su simboliu atskyreju, kuri vartotojas turi',cr,lf
         db 'ivesti taip pat. Isvedimas i ekrana.',cr,lf,'$'
eil      db 'Iveskite eilute:',cr,lf,'$'
skirt    db 'Iveskite skirtuko simboli:','$'
eilgal   db 'Neivesta simboliu eilute, arba skirtukas!',cr,lf,'$'
eilread  db 100, 101 dup(0) ; tuscias kintamasis kuris bus naudojamas kaip skaitymo buferis
			   ; maksimalus eilutes ilgis 100, plius 1 isskiriamas dabartiniam eilutes ilgiui saugoti
                           ; gaunas kazkas tokio: [100][0][][][][]...[] (dabartinis eilutes ilgis 0)
			   ; dup(0) uzpildo viska nuliais [100][0][0][0][0][0]...[0]
			   ; kai ikisim i ji pvz zodi LABAS, atrodys taip: [100][5][L][A][B][A][S]
buf      db 10 dup(0)       ; sitas kintamasis bus reikalingas verciant skaiciu i simboli 
bufe     db '$'             ; eilutes pabaigos simbolis
ten      dw 10              ; dw yra 2 baitu kintamasis 
sk       db ?,10,13,'$'     ; ce saugosim skirtuko simboli
tarpelis db ' ','$'
      n  db 0 
      m  db 0 
  eilnr  db 0 
                        
duomenys ends           
                        
programa segment        
	 assume cs:programa, ds:duomenys, ss:stekas
                        
start:                  
                        
	mov ax, duomenys                
        mov ds, ax      
                        
	mov ax, 0002h                  
        int 10h         
                        
   	mov ah, 09h                    
        lea dx, pran1                  
        int 21h         
                        
	mov ah, 09h                    
        lea dx, pran2                  
        int 21h         
eilute:                        
        mov ah, 09h     
        lea dx, eil     
        int 21h         
                        
	lea dx, eilread 
    	mov ah, 0ah        	; ah = 0ah (interupto 21h eilutes nuskaitymo funkcija) 
    	int 21h         	; iskvieciam interupta, eilute bus nuskaityta i kintamaji eilread 
                        
	call writeln            
                        
	lea dx, skirt  	
        mov ah, 09h     
        int 21h         
        
                            
        mov ah, 08h     
        int 21h  
        cmp al,0
        jle nieko_neivede
               
        mov sk,al     		
        mov ah, 09h     
        lea dx,sk       
        int 21h         
	                
	lea si, eilread  
	mov al, [si+1]  
                        
	mov ah, 0       
	                
	cmp ax, 0              
   	jle nieko_neivede 
	                
	lea si, eilread    
        add si, 2              
                            
                        
        mov bx, 0                        ; bx bus counteris skaiciuoti simboliu skaiciu be skirtuko 
        mov cx, ax                        ; i cx nukopijuojam eilutes ilgi, cx bus skaitliukas (kuri naudosime toliau esanciame cikle)
                      	; kuris kiekviena rata darys cx-1 ir tada kai cx bus lygu 0, zinosime, kad jau eilutes pabaiga
                        
; ######## Ejimo per simbolius ciklas ######### 
        mov bh,n        
        xor ax, ax      
        mov ah, sk      
nununu:                 ;tikrinimas ar nera skirtuku pries eilute, PVZ.: *****Petras*myli*ona (kad neisvestu daug enteriu ten kur *****)
        cmp [si], ah    
        je next         
        jmp cikliukas   
                        
cikliukas:              
        cmp cx, 0    	; patikrinam ar cx ne 0, t.y. ar ne eilutes galas jau 
    	je endas        ; jump if equal i zyme skaicius                                                                                                 
    	        	; i ah padesime skirtuko simboli
    	xor ax, ax      
  	mov ah, sk                                               
   	cmp [si], ah    ; pirma rata si saugomas musu pirmos eilutes raides (tos L) adresas, taigi 
        jne rasykraide    	
    	                ; rasyk raide, jeigu neskirtukas sokam i zyme kuri paraso raide
                     	; viena raide patikrinom taigi pereinam prie sekancios raides 
                                                       
        inc si       	; adresa padidinam 1, dabar si bus sekancios raides adresas     inc - increase 
        dec cx       	; eilutes ilgi numazinam vienu                                             
        cmp bh,m        
        je kelimas      
                        
tarpas:                 
        lea dx, tarpelis
        mov ah, 09h     
        int 21h         
        inc m           
        jmp cikliukas   
                        
kelimas:                
        call writeln    ; kadangi priejom skirtuka tai reik kita eilute pradet, nes isvedinesim kita zodi 
        inc eilnr       
        add bh, eilnr   
        jmp cikliukas   ; vel sokam i zymes pradzia ir vykdom ta pati
                                                                     
; ######## Vienos zodzio raides isvedimas ####### 
rasykraide:             
        mov dx, [si]    ; i dx dedame tai ka turime adresu si (musu raide) 
        mov ah, 06h   	; 21h interupto 06h funkcija naudojama vieno simbolio isvedimui 
    	int 21h         ; iskvieciame interupta 
        inc si        	; padidinam vienetu si, pereinam prie kitos raides 
                	; padidinam simboliu skaiciu be skirtuko
        dec cx       	; eilutes ilgi numazinam vienu 
    jmp cikliukas   	; sokam vel i cikliukas ir vykdom ejimo per simbolius cikla
                        
    jmp endas           ; viskas, uzbaigiam programa 
                        
; ######## Simboliu be skirtuko skaiciaus isvedimas jeigu ivesta tuscia eilute ###### 
    next:               
        inc si          
        jmp nununu      
     nieko_neivede:     
        call writeln    ; nusokam i kita eilute ekrane
        lea dx, eilgal  
        mov ah, 09h     ; uzrasom ekrane kintamaji eililg2 ('Eilutes ilgis be tarpu: $')
        int 21h         
        jmp eilute                  
     ;   mov ax, 0       ; procedurai writeskaicius skaiciu reik paduot ax'e
                        ; nereikia ir jumpint i endas (programos uzbaigimo zyme) jis vistiek eina po to
;praleidziam:            
 ;add si, 1              
 ;jmp cikliukas          
; ######## Pabaiga ######### 
     endas:             
    mov ah, 07h         
    int 21h   ; viska padarem, reikia baigti programos vykdyma 
    mov ah, 4ch             ; tam naudojama 21h interupto funkcija 4ch 
    int 21h            ; iskvieciam interupta, fsio 
                        
   writeln proc far          	; procedura kuri permeta i kita eilute ekrane 
      mov dl, 0dh               ; windows'uose kita eilute reiskia simboliai ascii lenteleje pazymeti numeriu 13 ir 10 
      mov ah, 06h               ; uzrasome ant ekrano 13'a simboli (0dh - h raide reiskia kad 16'ioliktainis, o kaip zinia D=13) 
      int 21h                   ; 06h funkcija vieno simbolio isvedimui 
      mov dl, 0ah               ; uzrasome ant ekrano 10'a simboli 
      int 21h                   ; 
      ret            ; ret grazina is proceduros i ta vieta kur ji buvo iskviesta 
   endp                 
                        
programa ends           
end start               
                        
                        
                        
