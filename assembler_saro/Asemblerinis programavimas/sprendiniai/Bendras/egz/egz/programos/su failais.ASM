stekas segment stack                                         
        db 100h dup (?)                                       
stekas ends         
cr equ 13
lf equ 10                                                 
;========================                                            
duomenys segment                                                     
	mas	db 255,?,255 dup ('$')          ;Duomenu masyvas	                                                    
	entr	dw 20,?,20 dup (?)      	;Masyvas eiluciu adresacijai keisti
	laik	dw ?,?,?                        ;Talpykla                      
	sk	db ?                            ;Eiluciu skaicius              
	writeln	db cr,lf
	pran1	db 'Kursinis darbas Nr.3, 08 var.',cr,lf    
		db 'Giedriaus Karaliuno, II-2/3 gr.',cr,lf         
		db cr,lf,'Atspausdinti masyva mazuju raidziu daugejimo',cr,lf      
		db 'eiluteje tvarka',cr,lf,'$'                       
	pran4	db cr,lf,'Reziltatai ATS.TXT faile, spauskite bet kuri klavisa$'
	klaida_pran db 'Ivyko klaida!',cr,lf,'$'
	failo   db 'Iveskite failo varda:' ,'$'
	spausd	db 20,?,20 dup (?)              ;Spausdinimo pagalbinis masyvas
        i_file db 20,?,20 dup (0)               ; ivesto failo masyvas    
        d_file db 20 dup (0)                    ; cia formuosim failo varda     
        o_file db 'ats.txt',0                   ; rezultatu failas
        handle dw 0                             ; atidaryto failo kintamasis 
        symbol_amount db 01h
duomenys ends                                                                  
                                                     
programa segment                                                               
assume cs:programa, ds:duomenys, ss:stekas                                     
start:                                                                         
        mov     ax, duomenys                                                   
        mov     ds, ax                                                    
                                                                               
        mov     ax, 0002h                                                      
        int     10h                                                       
                                                                               
	mov	ah, 09h                                                        
	lea	dx, pran1                                                      
	int	21h   	      	                                          
	                                                                  
	MOV     AH, 09h                                                   
        LEA     DX, failo                                                 
        INT     21h                                                       
                                                                          
        MOV     AH, 0ah                                                   
        LEA     DX, i_file                                                
        INT     21h                                                       
	                                                                  
	;FAILO NUSKAITYMAS                                                
        XOR     CX, CX                                                    
        MOV     CL, i_file + 1  ; koks ilgis                              
        LEA     DI, i_file + 2  ; duom prad                               
        LEA     SI, d_file                                                
ciklas:                         ; pervedam failo masyva i kitoki masyva           
        MOV     AL, [DI]                                                  
        MOV     [SI], AL                                                  
        INC     SI                                                        
        INC     DI                                                        
        LOOP    ciklas                                                       
                                                                          
        MOV     AL, 00h         ; irashom '0' gale                        
        MOV     [SI], AL                                                  
                                                                          
        MOV     AX, 3d02h       ;AH = 3Dh, AL = 02, access and sharing modes                            
        LEA     DX, d_file                                                
        INT     21h             ; atsidarom                               
        JC      er              ; jump if carry                                          
        MOV     handle, AX                                                
                                                                          
        MOV     AH, 3fh                                                   
        MOV     BX, handle                                                
        MOV     CX, 255         ; bandom tiek nuskaityt                   
        LEA     DX, mas + 2                                               
        INT     21h             ; skaitom, AX - perskaite; CX - norim perskaityt  
        JC      er                                                        
                                                            
        LEA     SI, mas + 1                                 
        MOV     [SI], AL        ; kad turetume kiek perskaitem                                
                                                            
        MOV     AH, 3eh         ; uzdarom faila             
        MOV     BX, handle                                  
        INT     21h             ; dabar atidarysim isvedimui
                                                            
        MOV     AH, 3ch         ; paruosiam rezultatu faila   
        MOV     CX, 00000000b                               
        LEA     DX, o_file                                  
        INT     21h             ; atsidarom ATS.txt
        JC      er                                          
        MOV     handle, AX                                  
                                                            
                                                            
        JMP     tesiam                                      
er:                             ; errorai
        JMP     erroras                                     
tesiam:                                             
                                                            
;-------------------------------------------------                                                                              
program:                                            
		                                                                               	                                                                                                                        
        ;adresacijos skaiciavimas
	xor	cx, cx		;Isvalomi veliau naudojami registrai           
	xor	bx, bx                                                 
	xor	dx, dx                                                 
	lea	si, mas + 2	;Pirmojo masyvo adreso nuskaitymas     
	lea	di, entr	;Pirmojo pagalbinio masyvo adreso nuskaitymas  
	mov	[di], si	;Irasomas masyvo adresas i pagalbini masyva    
nuskaitymas:  	        	;Begimas per masyvo elementus                  
	mov	al, [si]                                                       
	cmp	al, '$'		;Ar masyvas baigesi?                           
	je	tesiam1		;jei taip, suolis is ciklo
	inc 	si  		;Tolesnis elementas                            
	inc	cx  		;Skaiciuojami elementai eiluteje               
	cmp	al, 0dh		;Tikrinam, ar ne [ENTER]                       
	je	irasas		;jei taip, suolis i eilutes apdorojima
	cmp	al, 7Bh	       	;Ar patenka "is virsaus" i mazuju raidziu zona (ASCII - [61h-7Ah])
	jl	tinka		;Patenka -> tinka
	jmp	nuskaitymas	;Nepatenka -> i tolesni elementa               
tinka:
	cmp     al, 61h		;Ar patenka "is apacios" i mazuju raidziu zona 
	jl      nuskaitymas    	;Nepatenka -> i tolesni elementa               
	add	bl, 1		;Patenka, padidinamas mazuju raidziu skaicius  
        jmp	nuskaitymas     ;i tolesni elementa                            
irasas:   	                                                       
	inc	dl    		;Cia eiluciu skaicius                          
	inc	di 		;Tolesnis pagalbinis elementas                 
	dec     cx 		;-1 masyvo eilutes elementu skaicius (per daug)
	mov	[di], cx	;I pagalbini irasomas elementu eiluteje skaicius
	inc	di  		;Tolesnis pagalbinis elementas                 
	mov	[di], bx	;I pagalbini irasomas mazuju raidziu skaicius  
	xor	bx, bx		;Isvalomi registrai                            
	xor	cx, cx                                                         
	inc	si		;Tolesnis masyvo elementas                     
	inc	di		;Tolesnis pagalbinio masyvo elementas          
	mov	[di], si	;Tolesnes eilutes pirmasis adresas             
	jmp	nuskaitymas	;Vel begimas per eilutes elementus                                
tesiam1:
	mov	sk, dl		;Issaugomas eiluciu skaicius                   
	                                               
	dec	dx		;Burbulo metodui reikia 1 maziau ciklu, nei eiluciu skaicius
	mov	cx, dx		;                                  
	lea	si, entr	;Nuskaitomas eilutes duomenu grupes adresas    
	lea	di, entr+3	;Nuskaitomas tolesnes eilutes duomenu grupes adresas
the_loop:
	push	cx		;Issaugomas didziojo ciklo skaitliukas
        push    si		;Issaugomi adresai                             
        push    di                                                             
loopy:
	xor	ax, ax		                            
	xor	bx, bx                                                         
	mov	al, [si+2]	;Ivedamas eilutes mazuju raidziu skaicius      
	mov	bl, [di+2]	;Ivedamas tolesnes eilutes mazuju raidziu skaicius
	cmp	ax, bx		;Ju palyginimas                                
	jg	change  	;Jei pirmoj eilutej mazuju raidziu daugiau -> eiluciu duomenu sukeitimas
	jmp	tesiam2		;Jei ne -> tesiam2
change:	
	;is pirmesnio i talpykla
	mov	laik+2, ax	;I laikina talpykla sukeliami eilutes duomenys (mazuju raidziu skaicius)
	mov    	ax, [si+1]	;I registra ikeliamas eilutes elementu skaicius
	mov	laik+1, ax	;Perkeliamas i talpykla                        
	mov	ax, [si]	;I registra ikeliamas eilutes adresas          
	mov	laik, ax	;Perkeliamas i talpykla                        
	;is tolesnio i pirmesni
	push	di		;Sukeiciami registrai, kad galetu laisvai operuoti saltiniu ir tikslu
	mov	di, si                                                         
	pop	si                                                             
	mov	ax, [si]	;Analogiskai sukeliami tolesnes eilutes duomenys i pries tai buvusios
	mov	[di], ax	;eilutes vieta                                 
	xor	ax, ax                                                         
	mov	al, [si+1]                                                     
	mov	[di+1], al                                                     
	xor	ax, ax                                                         
	mov	al, [si+2]                                                     
	mov	[di+2],al                                                      
	;is talpyklos i tolesni
	push	di       	;Atkeiciami saltinio ir tikslo registrai                          
	mov	di, si                                                         
	pop	si                                                             
	mov	ax, laik 	;Analogiskai sukeliami eilutes duomenys i po to esancios eilutes vieta
	mov	[di], ax                                                       
	xor	ax, ax                                                         
	mov	ax, laik+1                                                     
	mov	[di+1], al                                                     
	xor	ax, ax                                                         
	mov	ax, laik+2                                                     
	mov	[di+2], al                                                     
tesiam2:
	add	si, 3    	;Lyginamos kitos dvi eilutes                   
	add	di, 3     	;Tolesne -> esama eilute                       
	loop    loopy         	;Dar tolesne -> tolesne
	pop     di  		;Grazinami didieji adresai - vel lyginamos pirmosios eilutes       		
	pop     si                                                                                              
	pop	cx                                                                                              
	loop    the_loop                                                                                     
                                                                                                                
	;Atspausdinimas
                                                                                                                
	xor	cx, cx          ;Isvalomas skaitliuko registras                                                 
	mov	cl, sk 		;Isivedamas eiluciu skaicius                                                    
	lea	si, entr	;Suadresuojamas pagalbinis masyvas entr                                         
	lea	di, entr                                                                                        
atspausdinimas:                                                                                         
	push	cx     		;Issaugomas eiluciu skaicius	                                                
	mov 	cl, [si+1]      ;Ivedamas eilutes elementu skaicius                                             
	push	si              ;Issaugojamas adresas                                                           
                                                                                                 
	mov	si, [di]       	;I si ikeliam eilutes adresas                  
	push	di     		;Issaugojam pagalbinio masyvo adresa           
	lea	di, spausd	;Pagalbinio masyvo pirmojo adreso priskyrimas  
symbol:
	xor     ax, ax 		;Isvalomas eilutes adreso siuksles (?!)        
	mov     ax, si                                                         
	xor     ah, ah                                                         
	mov     si, ax                                                         
	mov     al, [si]	;Perkeliamas masyvo elementas i pagalbini atspausdinimo masyva
	mov	[di], al                                                                          
	inc	si      	;Sekantys elementai                                   
	inc	di                                                             
	inc     symbol_amount ;sumuojam kiek simboliu turim rasyti i faila
	loop    symbol
			                                                       
 	pop 	di          	;Grazinamas globalus adresai                   
	add	di, 3           ;Padidinami tolesnei eilutei spausdinti              
	pop	si                                                             
	add	si, 3                                                          
                                                                               
                                                                                
        MOV     AH, 40h         ; rasysim i faila                              
        MOV     BX, handle      ;                                              
        MOV     CH, 00h                                                        
        MOV     Cl, symbol_amount ; tiek kiek reikia irasyti
        LEA     DX, spausd     ; pati eilute                                   
        INT     21h             ; rasom...                                     
        JC      erroras                                                        
                                                                               
        mov     ah, 01h                                                        
        mov     symbol_amount, ah  ; kitai eilutei paruosiam
                                                                               
        MOV     AH, 40h         ; rasysim i faila                              
        MOV     BX, handle      ;                                              
        MOV     CX, 2           ; enter simbolis faile 2 baitai                   
        LEA     DX, writeln     ; 13,10 - enter simbolis                       
        INT     21h             ; rasom...                                     
        JC      erroras                                                                                                                                                                                                                                                                           
	pop	cx              ;Grazinamas eiluciu skaiciaus skaitliukas                           
	loop    atspausdinimas                                                    
                                                                               
	;pabaiga
	mov	ah, 09h                                                        
	lea	dx, pran4                                                      
	int	21h    		;Isvedamas pranesimas pran4                    
	                                                                       
	MOV     AH, 3eh         ; uzdarom rezultatu faila                      
        MOV     BX, handle                                                     
        INT     21h             ; close rez.txt file...                                           
                                                                               
	jmp     dosas               ; persokam klados pranesima                            
erroras:                        ;jei buvo klaida dirbant su failu                            
	mov	ah, 09h                                                        
	lea	dx, klaida_pran                                                   
	int	21h		;Isvedamas pranesimas apie klaida              
                                                                               
dosas:                                                                 
	mov	ah, 07h	 	;Pristabdymas                                  
	int	21h                                         
                                                            
        mov     ah, 4ch                                            
        int     21h             ;Isejimas i DOS'a           
programa ends                                                           
end start        