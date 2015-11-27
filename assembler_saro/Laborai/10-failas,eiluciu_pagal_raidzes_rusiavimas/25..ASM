stekas segment stack                                                              
        db 256 dup (?)                                                                                  
stekas ends                                                                                             
;========================                                                                               
duomenys segment                                                                                        
	pran1	db 13,10,'Audrius Kundrotas, II-2/6 gr.'
		db 13,10,'ASM kursinis darbas Nr. 3, 05 var.',13,10
		db 13,10,'Programa papraso vartotojo ivesti failo varda,'
		db 13,10,'atidaro nurodyta faila, sukuria nauja faila,'
		db 13,10,'ir jame isveda visus nurodytame faile sutiktus'                           
		db 13,10,'simbolius bei ju pasirodymo kartu skaicius.',13,10,'$'                  
	pran2	db 13,10,'Iveskite failo varda:',13,10,'$'                                              
	pran    db 13,10,'Failas irasytas',13,10,'$'                                                                              
	duom	db 255,?,255 dup (?)	;Eilute duomenu ivedimui                                                                  
	error0	db 13,10,'Jus neivedete failo vardo$'     
	errr    db 13,10,'Failas tuscias$'                                                                        
	pran4	db 13,10,'Programa baige darba',13,10,'$'                                                                         
	error4	db 13,10,'Nenuskaitomas failas... Spauskit bet kuri klavisa$'                                                     
	vard_f	db 30,?,30 dup (?) 	;failo vardas                                                   
	fvardas	db 20 dup (0) 		;filo vardo formavimui                                          
	atsak	db 255 dup (?)                                                                          
	rez_fil	db 'rez.txt',0  	;rezultatu failas                                               
	handle 	dw 0            	;atidaryto failo kintamasis
	mas	db 100,?,100 dup(0)	;Zinomu simboliu masyvas
	yra	db ' yra '                                    
	pk	db 1			;Pirma karta	      
	kiek	db 0   			;Koks atsakymu masyvas
	des	db 10                               
duomenys ends                                                                                           
;========================                                                                               
programa segment                                                                                        
assume cs:programa, ds:duomenys, ss:stekas                                                              
start:                                                                                                  
        mov     ax, duomenys                                                                            
        mov     ds, ax          ;Duomenu segmento prijungimas                                           
                                                                                                        
        mov     ax, 0002h                                                                               
        int     10h             ;Isvalomas ekranas                                                      
                                                                                                        
	mov	ah, 09h                                                                                 
	lea	dx, pran1                                                                               
	int	21h		;Isvedamas pranesimas pran1                                             
                                                                                                        
	mov	ah, 09h                                                                                 
	lea	dx, pran2                                                                               
	int	21h		;Isvedamas pranesimas pran2                                             
                                                                                                        
	mov	ah, 0ah                                                                                 
	lea	dx, vard_f                                                                              
	int	21h		;Nuskaitomas failo vardas                                               
                                                                                                        
        ;=====Tikrina ivedima                                                                           
	xor	cx, cx                                                                                  
        mov     cl, vard_f+1    ;Nuskaito ivestu simboliu skaiciu                                                 
        cmp     cl, 0           ;Tikrina ar jis nelygus 0                                               
        je      klaida1         ;=0                                                                     
        jmp     tasa1           ;nelygus 0                                                              
        klaida1:                                                                                        
        mov     ah, 09h                                                           
        lea     dx, error0                                                        
        int     21h             ;Isveda klaida error1                             
        jmp     pabaiga         ;Suolis i pabaiga            
        tasa1:                                                 
                                                             
        ;=====Failo nuskaitymas                              
	xor	cx, cx                                       
	mov	cl, vard_f + 1	;vardo ilgis                 
	lea	di, vard_f + 2	;Pradines raides adresas     
	lea 	si, fvardas	;vardo formavimui            
	vard_cikl:		;duom_f -> vardasf           
	mov	al, [di]        ;Keitimas                    
	mov	[si], al                                     
	inc	si		;Tolesni elementai           
	inc	di                                           
	loop	vard_cikl                                    
                                                             
	mov	al, 0 		;Pabaigoje reikalingas "0"   
	mov  	[di], al                                     
                                                             
	mov	ax, 3d02h                                    
	lea	dx, fvardas                                  
	int	21h		;Atidaromas failas           
	                                                     
	jc	minierr         ;Klaidos atveju -> minierr  
	mov	handle, ax	;Atidaryto failo numerio issaugojimas
                                                             
	mov	ah, 3fh                                      
	mov	bx, handle                                   
	mov	cx, 255	  	;Bandomas 255 baitu nuskaitymas
	lea	dx, duom + 2    ;Priskiriamas pirmo duomens adresas
	int	21h	       	;Skaitymas, ax - perskaityta; cx - norim perskaityti
	jc	minierr         ;Klaidos atveju -> minierr   
                                                               
	lea	si, duom + 1                                   
	mov	[si], al	;Issaugojimas perskaitytas kiekis
                                                                                                                                                                                       
 	cmp     al, 0           ;Tikrinam ar failas ne tuscias
	je      nieko                                         
	jmp     toleliau                                      
	nieko:                                                
	mov     ah, 09h                                       
	lea     dx, errr                                          
	int     21h             ;Isvedamas pranesimas errr    
	jmp     minierr
	toleliau:   
                                                               
	mov	ah, 3eh		;Failo uzdarymas               
	mov	bx, handle                                     
	int 	21h		;Atidarymas isvedimui       
	
	mov	ah, 3ch		;Rez.txt paruosimas                               
	mov	cx, 00000000b                                                     
	lea	dx, rez_fil                                                       
	int	21h		;Atidaromas rez.txt                               
	jc	minierr                                                           
	mov	handle, ax                                                        
	;============                                                             
                                                                                  
	jmp 	jampas3                                                                                              
        minierr:                                                                                                     
        jmp     globerr         ;Globalinis suolis          
        jampas3:                                                                                                     
                                                            
	;========Konvertavimas                              
	xor	cx, cx		;Isvalomas registras        
	mov	cl, duom + 1	;Isimenamas duomenu failo dydis
	lea	si, duom + 2	;Isimenamas duomenu eilutes pirmasis adresas
	lea	di, atsak                                   
	xor	bx, bx  	;Isvalomi registrai         
	xor	ax, ax                                      
	ciklas:                                             
	mov	bl, 0dh	  	;Tikrina, ar ne [ENTERIS]   
	cmp	[si], bl        ;0dh                            
	je	entris          ;0ah                        
	mov	bl, 0ah                                     
	cmp	[si], bl                                    
	je	entris          ;Jei enteris -> entris
	push	cx              ;Issaugojamas ciklo skaiciukas      
	call	masyviukas	;Iskvieciama procedura masyviukas
	entris2:	                            
	pop	cx              ;Grazinamas ciklo skaiciukas        
	entris:                                             
	inc	si              ;Sekantis elementas
	loop	ciklas          ;I pradzia         
                          
        mov     al, kiek  	;Issaugojamas atsakymo masyvo dydis
        mov     duom + 1, al                                                            
	;=========Duomenu irasymas i faila rez.txt          
	xor	cx, cx                                      
	mov	cl, duom + 1    ;Duomenu skaiciaus skaitliukas                           
	lea	dx, atsak       ;Atsakymo masyvo adreso priskyrimas
	mov	ah, 40h                                       
	mov	bx, handle                                  
	int	21h             ;Suvedami duomenys i faila  
	                                                    
	jc	minierr	        ;Klaidos atveju -> minierr  
	                                                    
	mov     ah, 09h                                     
	lea     dx, pran                                    
	int     21h             ;Atspausdinamas pranesimas pran
	                                                    
	jmp    	pabaiga		;Link isejimo               
                                                            
        globerr:                                            
	mov	ah, 09h                                                    
	lea	dx, error4                                                  
	int	21h  	   	;Isvedamas pranesimas error4
                                                            
	jmp	galas                                       
	;=====                                              
                                                                           
	pabaiga:       		;link                       
	mov	ah, 09h                                                    
	lea	dx, pran4                                   
	int   	21h  	   	;Isvedamas pranesimas pran4 
                                                            
        galas:                                                           
	;==========pabaiga===============                                  
	mov	ah, 07h         ;Pristabdymas               
	int	21h                                         
        mov     ah, 4ch                                            
        int     21h             ;Isejimas i DOS'a           
                                                            
masyviukas proc            	;Procedura tikrinimui ir skaiciavimui                                 
	mov	bl, pk          ;Tikrinama ar pirmas kartas
	cmp	bl, 1                                       
	je	jump1 	        ;Jei "Taip" -> jump1 
	xor	cx, cx                                      
	mov	cl, mas + 1     ;Isikeliamas raidziu masyvo kiekis                        
	push    di              ;Issaugojamas atsakymo masyvo adresas
	lea	di, mas + 1	;Priskiriamas raidziu masyvo adresas
	masy:                   ;Ciklas skirtas sutikrinti ar tokia raide jau skaiciuota                            
	inc     di              ;Sekantis elementas
	mov	bl, [di]                                    
	cmp	[si], bl        ;Tikrinimas         
	je	yr              ;Jei yra -> yr                 
	loop	masy            ;Atgal              
	mov	cl, mas + 1     ;Ikeliamas raidziu masyvo dydis                          
	inc	cl              ;Padidinamas dydis (viena raide prisideda)
	mov	mas + 1, cl     ;Grazinama
	lea	di, mas + 1     ;Paimamas raidziu masyvo adresas                  
	add	di, cx          ;Pridedamas esamu elementu skaicius (tolesnis uz paskutini elementas)
	mov	cl, [si]        ;Ikeliama nauja raide i raidziu masyva
	mov	[di], cl                                    
	pop     di              ;Grazinamas atsakymo masyvo adresas
	jmp	jump3           ;-> jump3
	yr:                     ;Jei raide yra                   
	pop     di  		;Grazinamas atsakymo masyvo adresas
	pop     cx 		;Sunaikinamas grazinimo adreso numeris
	jmp     entris2		;-> entris2
	jump1:                  ;Jei pirma karta                     
 	mov	pk, 0           ;Pazymima, kad jau pirmas kartas (pk) buvo
	mov	cl, 1                                       
	mov	mas + 1, cl	;I raidziu masyva irasomas kiekis = 1
	mov	cl, [si]        ;Ikelama pirma raide i raidziu masyva
	mov	mas + 2, cl
	jump3:             	;tesiam
	pop     ax              ;Iskeliamas grazinimo adreso numeris                         
	pop	cx   		;Nukopijuojamas ciklo skaiciukas
	push	cx   
	push    ax   		;Grazinamas grazinimo adreso numeris  
 	dec     cl   		;Sumazinamas ciklo nr, reikia iskaiciuoti ir save
	xor	ax, ax     	
	push	si 		;Issaugojama nagrinejama raide
	inc     al        	
	mov	ah, [si]	;ah <- su kuo lyginti
  	skaiciuoti:        
	inc	si         	;Tolesnis masyvo elementas
	cmp	ah, [si]   	;Palyginam
	jne	ggg        	;	Jei nelygus persokam
	inc	al         	;pridejima prie skaiciavimo
	ggg:               
	loop skaiciuoti    
	pop	si         	;Grazinama tikroji nagrinejama raide
	push	ax         	;Issaugoma informacija ax
	mov	[di], ah   	;I atsakymu masyva irasoma raide
	inc	di         	;Tolesnis atsakymo masyvo elementas
	mov	al, kiek   	;al <- atsak masyvo elementu kiekis (dydis)
	inc	al         	;Padidinamas dydis
	push    si         	;Saugoma tikroji nagrinejama raide

	;========Issaugomas atsak masyve ' yra '
	lea	si, yra    	
	mov	cx, 0005h  
	ifile:             
	mov	ah, [si]   
	mov	[di], ah   
	inc	di         
	inc     si         
	inc	al         
	loop ifile
         
	pop     si         	;Grazinama nagrinejama raide
	mov	cl, al     	;atsak masyvo dydis -> cl
	pop	ax      	;Grazinamas ax informacija   	
	xor	ah, ah     	;xor ah, al - raidziu skaicius
	;==========Vertimas i suprantamus skaicius               
	push    '$'   	   	;Steko riba                      
	ides:                                                    
	xor	dx, dx                                           
	div	des   		;Dalijimas is 10, liekana + 30 = 3xh -> stack
	add	ah, 30h                                          
	mov	dl, ah                                           
	push    dx 		;Vertimas i normalias raides     
	xor     ah, ah                                           
	cmp	al, 0   	;Ar dar yra ka dalinti           
	je	lauk                                             
	jmp	ides                                             
	lauk:                                                    
        pop     dx      	;Traukiamas skaiciu              
        cmp     dl, '$' 	;Tikrinamas ar ne "$"            
        je      lauk_is                                          
        mov     [di], dl        ;Kisimas i masyva atsak          
	inc	di                                               
	inc 	cx                                               
	jmp     lauk                                             
        lauk_is:                                                 
	;================Ikeliamas [ENTER]                       
	mov	al, 0dh	 			                 
	mov	[di], al                                         
	inc	di    	      	;Tolesni elementai               
	inc 	cx                                               
	mov	al, 0ah                                          
	mov	[di], al                                         
	inc	di                                               
	inc 	cx                                               
	mov	kiek, cl	;Issaugomas atsak masyvo dydis                                         
	ret                     ;Atgal i cikla   
masyviukas endp                                                  
programa ends                                                           
end start        