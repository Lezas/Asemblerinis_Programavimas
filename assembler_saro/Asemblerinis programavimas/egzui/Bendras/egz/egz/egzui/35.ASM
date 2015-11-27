stekas segment stack                                                              
        db 256 dup (?)                                                           
stekas ends                                                                       
;========================                                                         
duomenys segment                                                                  
	pran1	db 13,10,'Audrius Kundrotas II-2/6 gr.'                            
		db 13,10,'ASM kursinis darbas Nr. 2, 23 var.',13,10
		db 13,10,'Ivedama simboliu eilute ir sesiazenklis skaicius'     
		db 13,10,'a1a2a3a4a5a6, isvedama simboliu eilute, gauta'        
		db 13,10,'uzasifravus pirmaja eilute Griunsfeldo sifru.'        
		db 13,10,'Griunsfeldo sifras pirmaji eilutes simboli, kurio'    
		db 13,10,'kodas n1, vercia i simboli, kurio kodas'              
		db 13,10,'(n1 + a1) mod N, ..., (n6 + a6) mod N, paskui vel'    
		db 13,10,'su a1 ir t.t. Kur N - abeceles simboliu skaicius.',13,10,'$'
	pran2	db 13,10,'Iveskite simboliu eilute:',13,10,'$'                
	pran3	db 13,10,'Iveskite 6 skaiciu eilute:',13,10,'$'               
	duom	db 60,?,60 dup (?)	;Eilute duomenu ivedimui
	error1	db 13,10,'Jusu trumpa eilute arba nieko neivedete$'                              
	error2	db 13,10,'Jei norite pakartoti, spauskite [y]',13,10,'$'      
	error3	db 13,10,'Jus ivedete ne tik skaiciu, pakartokite$'        
	pran4	db 0ah,0dh,'Uzsifruota eilute:',0ah,0dh,'$'                      
	skait	db 7,?,7 dup (?)                                                  
	N	db 95		;Galimu simboliu variantu yra 95 (5Fh) tiesiogiai klaviaturoje   
	atsak	db 60 dup (?)
duomenys ends                                                                     
                                                        
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
                                                                                  
	program:                                                                  
	mov	ah, 09h                                                           
	lea	dx, pran2                                                         
	int	21h		;Isvedamas pranesimas pran2                       
                                                                                  
	mov	ah, 0ah                                                           
	lea	dx, duom                                                          
	int	21h		;Nuskaitoma simboliu eilute                       
                                                                                  
        ;=====Tikrina ivedima simboliu eilutes                                    
	xor	cx, cx                                                            
        mov     cl, duom+1      ;Nuskaito ivestu simboliu skaiciu                                                 
        cmp     cl, 0           ;Tikrina ar jis nelygus 0                         
        je      klaida1         ;=0                                               
        jmp     tasa1           ;nelygus 0                                           
        klaida1:                                                                  
        mov     ah, 09h                                                           
        lea     dx, error1                                                        
        int     21h             ;Isveda klaida error1                             
        jmp     tasa5           ;Suolis, kur paklaus, ar norite testi                                           
        tasa1:                                                                    
	mov	ah, 09h                                                           
	lea	dx, pran3                                                         
	int	21h		;Isvedamas pranesimas pran3                       
                                                                                  
	mov	ah, 0ah                                                           
	lea	dx, skait                                                         
	int	21h		;Nuskaitoma skaiciu eilute                        
                                                                                  
        ;=====Tikrina ivedima skaiciu eilutes                                     
	xor	cx, cx                                                            
        mov     cl, skait+1     ;Nuskaito ivestu simboliu skaiciu                                                 
        cmp     cl, 6           ;Tikrina ar jis nelygus 0                         
        jl      klaida1         ;<6, o turi buti 6                                
                                                                                  
	lea	si, skait+2     ;Priskiriamas pirmo skaitmens adresas                  
	sk_ciklas:                                                                
	mov     al, [si]        ;Nuskaitomas skaitmuo                                                  
	cmp	al, 30h	        ;tikrinam skaiciu is apacios (sk<30h)             
 		 		;ekrane skaicius atvaizduojamas                   
		 		;30h-39h ASCII lenteles simboliais                
	jl  	jampas1		;ats: "taip"                                      
	jmp  	tasa2 		;ats: "ne"                                        
                                                                                  
	jampas1:                                                           
	mov	ah, 09h                                                    
	lea	dx, error3                                                 
	int	21h		;Isvedama klaida error2                    
                                                                           
	jmp	tasa1		;grazhina i ivedimo vieta                  
                                                                           
	tasa2:                                                             
	cmp	al, 39h 	;tikrinam skaiciu is virsaus (sk>39h)
	jg	jampas1		;ats: "taip"                         
                                                                     
	sub     al, 30h         ;Paverciamas i HEX skaiciu                                     
	mov     [si], al        ;Grazinama pakeista reiksme i masyva                                                   
	inc	si              ;sekantis elementas                                          
	loop	sk_ciklas                                            
	;========                                                    
                                                                     
	mov	ah, 09h                                                     
	lea	dx, pran4                                                   
	int	21h		;Isvedamas pranesimas pran3                
	;=====Konvertavimas                                          
	xor	cx, cx		;Isvalomi registrai                  
	xor	bx, bx                                               
	xor	dx, dx
	mov	dl, 6		;Ivedam neteisinga skaiciu tikrinimui, kad
				;pradetu nuo pirmo sifravimo skaiciaus                                               
                                                                     
	lea	di, atsak	;Nuskaitomas atsakymo masyvo adresas 
	lea	si, duom+2	;Nuskaitomas doumenu masyvo adresas  
	mov	cl, duom+1 	;Ikeliamas ciklo skaitliukas         
	ciklas:                                                      
	xor	ax, ax		;Operuojamo registro isvalymas       
	cmp	dl, 5           ;Tikrinama, ar ne pasibaige skaiciu masyvas [0-5]                                       
	jg	pravalymas      ;>5, einam i pertvarkyma skaiciu masyvo adresacija
	jmp	tasa3           ;Ats: "ne"
	pravalymas:                                                  
	xor	dx, dx          ;Isvalomas skaitmenu numerio skaiciavimo registras                                     
	lea	bx, skait+2	;Nuskaitomas skaiciu masyvo pirmasis adresas	          
	tasa3:                                                                    
	mov	al, [si]        ;Isikeliamas sifruojamo teksto elementas a
	mov	ah, [bx]        ;Isikeliamas raktinis skaicius n          
	add	al, ah          ;a + n
	xor	ah, ah          ;Paruosimas dalybai      
	push    dx              ;Issaugojama skaiciu eile
	xor     dx, dx          ;Isvalomas registras, kad dalyba veiktu gerai
	div	N               ;(a +n) / N; mod yra ah, div yra al patalpinta
	pop     dx              ;Grazinama skaiciu eile
	add     ah, 30h         ;Uztikrina kad nebutu valdymo simboliu	                        ;
	                        ; ('$', [ENTER], [BACKSPACE] ir pan)), 
	                        ;
	mov	[di], ah        ;Gautas elementas nukopijuojamas i ats masyva                
	inc	di              ;Tolesnis ats masyvo elementas
	inc	si              ;Tolesnis duom masyvo elementas      
	inc	dl              ;Padidinamas rakto elemento skaitliukas
	inc     bx              ;Tolesnis rakto skaicius
	loop	ciklas
	         
	mov     al, '$'         ;I ats masyva patalpinamas "$", kad butu apribotas
	mov	[di], al        
	                                                  
        lea 	dx, atsak       ;Atspausdinamas atsakymas (ats masyvas)
	mov	ah, 09h                                                           
	int 	21h                                                   
	         
	jmp	tasa5		;Link isejimo                         
                 
        suolis:                                                        
        jmp     program         ;Pakartoti uzduoti
                                                                           
	tasa5:	       		;Ar dar dirbsit?                           
	mov	ah, 09h                                                    
	lea	dx, error2                                                  
	int	21h	   	;Isvedamas pranesimas error2
                                                                           
        mov     ah, 08h         ;Nuskaitomas viena simboli                 
        int     21h                                                        
        cmp     al, 'y'         ;Tikrinama, ar neivesta 'y'                
        je      suolis                                                 
                                                                           
	;==========pabaiga===============                                  
        mov     ah, 4ch                                            
        int     21h             ;Isejimas i DOS'a 
programa ends                                                           
end start        