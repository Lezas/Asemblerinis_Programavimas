











stekas segment stack
	db 256 dup (?)
stekas ends

;=================================================================

duomenys segment
	pran1   db 10, 13, 'Darius Sakinis IIv-4 grupe'
		db 10, 13, 'ASM kursinis darbas', 10, 13
		db 10, 13, 'Programa papraso vartotoja ivesti du skaicius'
		db 10, 13, 'ir isveda siu skaiciu suma.', 10, 13,'$'    
	pran2   db 10, 13, 'Iveskite pirma skaiciu', 10, 13, '$'
	pran3	db 10, 13, 'Iveskite antra skaiciu', 10, 13, '$'
	pran4   db 10, 13, 'Jus ivedete ne skaiciu', '$'
	pran5	db 10, 13, 'Ivestu skaiciu suma yra: ', '$'
	pran6	db 10, 13, 10, 13, 'Kartosite darba? [y - taip]'
	        db 10, 13, 'Bet kuris kitas klavisas - ne', 10, 13, '$'
	a db 5, ?, 5 dup (?)  ; pirmo skaiciaus ivedimui
	b db 5, ?, 5 dup (?)  ; antro skaiciaus ivedimui
	des dw 10             ; desimtainis daugiklis
	laik1 dw ?            ; laikinas kintamasis
	laik2 dw ?            ; laikinas kintamasis
	min dw 0              ; neigiamu skaiciu skaitliukas
                                                                           
duomenys ends                                                              
                                                                           
;====================================================                      
                                                             
programa segment                                             
	assume cs: programa, ds:duomenys, ss:stekas          
                                                             
start:                                                       
	mov ax,duomenys                                      
	mov ds,ax                                            
                                                             
;isvalome ekrana                                             
	mov ax, 0002h                                        
	int 10h                                              
                                                             
;1 pranesimo spausdinimas                                    
	mov ah,09h                                           
        lea dx,pran1                                         
        int 21h                                              
        mov ah,07h                                                        
          
prog:           ; nuo cia  kartos darba
          
;2 pranesimo spausdinimas                                    
	mov ah, 09h                                                        
	lea dx, pran2                                        
	int 21h                                              
	mov ah, 07h
	         
;pirmo skaiciaus ivedimas         
	mov ah, 0ah               
	lea dx, a                 
 	int 21h                   
                                  
	xor ax, ax      ; 
 	xor cx, cx      ;   
	mov cl, a+1     ; ciklo skaitliukas i cl 
	lea si, a+2     ; nuskaitom skaiciaus pradzia
                                                       
; tikrinam ar tai teigiamas skaicius                   
	mov al, [si]    ; nuskaitom pirma skaiciaus simboli                               
        cmp ax, 2dh     ; 2dh = '-' (lyginam su minuso zhenklu)
        je okey2        ; jei skaicius neigiamas
	xor ax, ax                                            
	                                                                   
; skaicius ne neigiamas                               
ciklas1:                                                      
	mov bl, [si]    ; skaitmens nuskaitymas               
	cmp bl, 39h     ; tikrinam ar tai skaicius           
	jg klaida1	; jei > 9 blogai                      
	cmp bl, 30h     ; tikrinam ar tai skaicius           
	jl klaida1      ; jei < 0 blogai                      
	                                                      
; viskas gerai, dabar skaiciuosim                            
	mul des         ; cia kad gautume desimtis ir t.t.  
 	add ax, bx      ; desimtys + vienetai, simtai + desimtys ir t.t.
	sub ax, 30h     ; verciam i desimtaini skaiciu     
                                                              
okey1:                                                        
 	inc si          ; imam kita skaitmeni                 
                                                              
loop ciklas1            ; vykdom cikla kol nesibaigia skaitmenys
                                                                
; tesim darba                                                 
jmp toliau                                                      
                                                              
;skaicius neigiamas                                          
okey2:                                                                     
       	xor ax, ax                                            
	mov min, 1     ; isimenam, jog pirmas ivestas skaicius neigiamas
	jmp okey1      ; grizhtam i cikla                     
                                                              
; pratesim darba                                              
toliau:                                                       
	mov laik1, ax  ; atlaisvinam ax
                                                                          
;3 pranesimo spausdinimas                                                 
	mov ah, 09h                                           
	lea dx, pran3                                         
	int 21h                                               
                                                              
;antro skaiciaus ivedimas                                    
	mov ah, 0ah                                           
	lea dx, b                                             
 	int 21h                                               
                                                              
; taip pat kaip ir su pirmu skaiciumi          
        xor ax, ax      
 	xor cx, cx      
	mov cl, b+1     ; ciklo skaitliukas i cl 
	lea si, b+2     ; nuskaitom skaiciaus pradzia       
                                                              
; tikrinam ar tai teigiamas skaicius                         
	mov al, [si]    ; nuskaitom pirma skaitmeni                            
        cmp al, 2dh     ; 2dh = '-', tikrinam ar tai ne minusas
        je ok2          ; jei skaicius neigiamas             
	xor ax, ax                                            
	                                                      
; skaicius ne neigiamas (vieni pliusai)                       
ciklas2:                                                      
	mov bl, [si]    ; skaitmens nuskaitymas                 
	cmp bl, 39h     ; tikrinam ar tai skaicius            
	jg klaida1	; jei > 9 blogai                      
	cmp bl, 30h     ; tikrinam ar tai skaicius            
	jl klaida1      ; jei < 0 blogai                      
	                                                      
; viskas gerai, dabar skaiciuosim                            
        mul des         ; cia kad gautume desimtis ir t.t.     
 	add ax, bx      ; desimtys + vienetai, simtai + desimtys ir t.t.
	sub ax, 30h     ; verciam i desimtaini skaiciu     
	                                                      
ok1:                                                                       
 	inc si          ; imam kita skaitmeni                 
                                                              
loop ciklas2            ; vykdom cikla                        
                                                              
; susitvarkem antra skaiciu, tesim darba                                        
jmp testi                                                     
                                                              
; per toli sokam                                             
klaida1:                                                      
	jmp klaida                                            
                                                              
                                                              
;skaicius neigiamas                                           
ok2:                                                          
	xor ax, ax                                            
	mov ax, min    ; antras skaicius neigiamas           
	add al, 2                                             
	mov min, ax    ; isimenam jog yra minusas                  
	xor ax, ax                                            
	jmp ok1        ; griztam i cikla                      
	                                                      
; tesiam darba                                                
testi:                                                        
	mov laik2, ax  ; atlaisvinam ax
                                                              
;skaiciavimas                                                 
	mov ah, 09h                                           
	lea dx, pran5                                         
	int 21h        ; isvedam pranesima                  
	xor bx, bx                                            
	mov bx, min    ; ziurim kiek neigiamu skaiciu                     
	cmp bx, 1                                             
	jl nulis       ; jei abu skaiciai teigiami           
	je vienas      ; jei pirmas skaicius neigiamas       
	cmp bx, 2                                             
	je du          ; jei antras skaicius neigiamas       
	jg trys        ; jei abu skaiciai neigiami           
                                                              
; abu skaiciai teigiami	         
nulis:                  
	xor ax, ax      
	xor bx, bx      
	mov ax, laik1  ; pasiimam pirma skaiciu 
	mov bx, laik2  ; pasiimam antra skaiciu        
	add ax, bx     ; skaiciuojam
	xor bx, bx
	jmp spauzd           
                        
; pirmas skaicius neigiamas                        
vienas:                 
	xor ax, ax     
	xor bx, bx     
	mov ax, laik1  ; pasiimam pirma skaiciu
	mov bx, laik2  ; pasiimam antra skaiciu 
	cmp ax, bx     ; lyginam skaicius
	jl atim1       ; jei pirmas > antras
	je spnul       ; jei pirmas = antras
	jg atim2       ; jei pirmas < antras
	    
; antras skaicius neigiamas	         
du:              
	xor ax, ax
	xor bx, bx
	mov ax, laik1  ; pasiimam pirma skaiciu
	mov bx, laik2  ; pasiimam antra skaiciu
	cmp ax, bx     ; lyginam skaicius                       
	jl atim4       ; jei pirmas > antras
	je spnul       ; jei pirmas = antras
	jg atim3       ; jei pirmas < antras
                    
; abu skaiciai neigiami                
trys:               
	mov dx, '-' 
	mov ah, 02h 
	int 21h        ; atspausdinam minuso zenkla
	xor ax, ax  
	xor bx, bx  
	mov ax, laik1  ; pasiimam pirma skaiciu
	mov bx, laik2  ; pasiimam antra skaiciu
	add ax, bx     ; skaiciuojam
	xor bx, bx   
	jmp spauzd   
	             
spnul:               
        jmp spauzdnul
                     
atim1:               
	xor ax, ax                                                         
	xor bx, bx   
	mov ax, laik2  ; pasiimam antra skaiciu
	mov bx, laik1  ; pasiimam pirma skaiciu
	sub ax, bx   
	xor bx, bx   
	jmp spauzd   
                     
atim2:               
	mov dx, '-'  
	mov ah, 02h  
	int 21h        ; atspausdinam minuso zenkla
	xor ax, ax   
	xor bx, bx   
	mov ax, laik1  ; pasiimam pirma skaiciu
	mov bx, laik2  ; pasiimam antra skaiciu
	sub ax, bx     ; is didesnio skaiciaus atimam mazesni
	xor bx, bx   
	jmp spauzd   
                    
atim3:               
	xor ax, ax   
	xor bx, bx   
	mov ax, laik1  ; pasiimam pirma skaiciu
	mov bx, laik2  ; pasiimam antra skaiciu
	sub ax, bx     ; is didesnio skaiciaus atimam mazesni
	xor bx, bx   
	jmp spauzd   
                     
atim4:               
     	mov dx, '-'  
	mov ah, 02h  
	int 21h        ; atspausdinam minuso zenkla
	xor ax, ax   
	xor bx, bx   
	mov ax, laik2  ; pasiimam antra skaiciu
	mov bx, laik1  ; pasiimam pirma skaiciu
	sub ax, bx     ; is didesnio skaiciaus atimam mazesni
 	xor bx, bx   
     	jmp spauzd   
                     
spauzdnul:           
        mov ah, 02h  
	mov dx, '0' 
	int 21h        ; atspausdinam '0'
	jmp iseinam
                    
spauzd:             
 	xor dx, dx  
	div des     
	push dx        ; irasom i atminti
	add bx, 1      ; ciklo skaitliukas (vietoj $)
 	cmp ax, 0000h  ; tikrinam ar rezultatas perkeltas i atminti
	je spauzdint
 	jmp spauzd  
                    
spauzdint:          
	pop dx         ; istraukiam is atminties
	cmp bx, 0000h  ; tikrinam ar ciklas nebaigtas
	je ish         ; jei taip iseinam
	sub bx, 1      ; sumazinam ciklo skaitliuka	                                                    
	add dx, 30h    ; verciam i deshimtaini
	mov ah, 0002h
	int 21h      
 	jmp spauzdint
                     
ish:                 
        jmp iseinam
                     
; kartojam darba     
startas:            
        mov min, 0  
        jmp prog    
                     
; ivyko klaida         
klaida:              
	mov ah, 09h  
        lea dx, pran4
        int 21h        ; pranesimas apie klaida                                                    
iseinam:
        mov ah, 09h  
        lea dx, pran6
        int 21h        ; klausiam ar nori testi           
        mov ah, 08h    ;ivedam tik viena zenkla
        int 21h     
        cmp al, 79h    ; jei y tai kartoja
        je startas  
                    
;grizti i OS       
	mov ah, 4ch
        int 21h
         
;programos pabaiga        
programa ends
end start