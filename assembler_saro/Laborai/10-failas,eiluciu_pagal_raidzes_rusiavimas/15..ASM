stekas segment stack                                           
        db 256 dup (?)                                         
stekas ends                                                          
                                                               
duomenys segment                                                     
	mas   	db '1 2 3 4 5',0ah,0dh                         
	  	db 'MMMMmmmmm',0ah,0dh                      
		db 'Mmmmmmmmm',0ah,0dh                         
		db 'MMMMMMmmm',0ah,0dh                         
		db 'MMMMMmmmm',0ah,0dh                    
		db 'MMmmmmmmm',0ah,0dh                    
		db 'MMMmmmmmm',0ah,0dh,'$'                                         
	entr	dw 20,?,20 dup (?)      ;Masyvas eiluciu adresacijai keisti 
	laik	dw ?,?,?                ;Talpykla                           
	sk	db ?                    ;Eiluciu skaicius                           
	enteris	db 13,10,'$'                                                 
	pran1	db 'Programa  papraso vartotojo ivesti  failo varda,',13,10      
		db 'atidaro  nurodyta  faila, sukuria  nauja  faila,',13,10
		db 'ir jame  suraso  visas nurodyto  failo  eilutes,',13,10      
		db 'pirmiausia rasydamas eilutes, kuriose maziausiai',13,10		
		db 'mazuju   raidziu,   po  to  -  eilutes,  kuriose',13,10     
		db 'daugiausia   mazuju  raidziu  ( t.y.  isrusiuoja',13,10		
		db 'eilutes  pagal  mazuju  raidziu  skaiciu  jose).',13,10
		db '************************************************',13,10
		db 'Atliko II-26gr. studentas: M.Veinsreideris',13,10,'$'                    
		                        
	pran2	db 0ah,0dh,'Turimas masyvas: ',0ah,0dh,0ah,0dh,'$'             
	pran3	db 0ah,0dh,'Pakeistas masyvas: ',0ah,0dh,0ah,0dh,'$'        
	pran4	db 13,10                                           
		db 'Baigta. SPAUSKITE BET KOKI KLAVISA!!!',13,10, '$'
	pran5   db 13,10                                           
		db 'Kad ivyktu pakeitimas SPAUSKITE ENTER',13,10,'$'
	spausd	db 20,?,20 dup (?)           ;Spausdinimo pagalbinis masyvas
duomenys ends                                                                  
                                                     
programa segment                                                               
assume cs:programa, ds:duomenys, ss:stekas                                     
start:                                                                         
        mov     ax, duomenys                                                   
        mov     ds, ax          ;Duom segm prijungimas                  
                                                                               
        mov     ax, 0002h                                                      
        int     10h             ;Isvalomas ekranas                             
                                                                               
	mov	ah, 09h                                                        
	lea	dx, pran1                                                      
	int	21h	                                           
                                                                               
program:                                                               
	mov	ah, 09h                                                        
	lea	dx, pran2                                                      
	int	21h	                                           
                                                                               
	mov	ah, 09h                                                        
	lea	dx, mas                                                        
	int	21h	                                           
	                                                           
	mov     ah, 09h                                            
	lea     dx, pran5                                          
	int     21h                                                
	          	                                           
	mov     ah, 07h                                            
	int     21h             ;Laukimas                          
                                                                               
;Adresacijos skaiciavimas                                          
	xor	cx, cx	       	;Isvalomi registrai                
	xor	bx, bx                                                 
	xor	dx, dx                                                 
	lea	si, mas		;1-ojo masyvo adreso nuskaitymas   
	lea	di, entr	;1-ojo pagalbinio masyvo adreso nuskaitymas
	mov	[di], si	;Irasomas masyvo adresas i pagalbini masyva
nuskaitymas:	         	;Begimas per masyvo elementus
	mov	al, [si]                                               
	cmp	al, '$'	 	;Ar masyvas baigesi?                   
	je	tasa1		                                       
	inc 	si  		;Sekantis elem                                 
	inc	cx  		;Skaiciuojami elem eiluteje                    
	cmp	al, 0ah		;ar ne [enter]                                 
	je	irasas		                                               
	cmp	al,91		;Ar > [61h-7Ah] -mazosios raides               
	jl	tink2  		;Taip                                          
	jmp	nuskaitymas	;Ne                                            
tink2:
	cmp     al,64		;Ar < [61h-7Ah] -mazosios raides               
	jl      nuskaitymas    	                                               
	add	bl, 1		;Patenka, padidinamas m.r. skaicius    
        jmp	nuskaitymas                                                    
irasas:      	
	inc	dl    	  	;Eiluciu sk                                              
	inc	di 		;Tolesnis pagalbinis elementas                           
	dec     cx 		;-1 masyvo eilutes elementu skaicius             
	mov	[di], cx	;I pagalbini irasomas elementu eiluteje skaicius    
	inc	di  		;Tolesnis pagalbinis elementas                      
	mov	[di], bx	;I pagalbini irasome m.r. skaiciu              
	xor	bx, bx		;Isvalome registrus                                 
	xor	cx, cx                                                              
	inc	si		;Tolesnis masyvo elementas                          
	inc	di		;Tolesnis pagalbinio masyvo elementas               
	mov	[di], si   	;Tolesnes eilutes 1-asis adresas               
	jmp	nuskaitymas	;Begimas per eilutes elementus                  
tasa1:
	mov	sk, dl		;Issaugomas eiluciu sk                         
	;suskirstom eilutes                                                    
	dec	dx		;Reikia 1 maziau ciklu, nei eiluciu skaicius   
	mov	cx, dx		;I skaitliuka                                       
	lea	si, entr	;Nuskaitomas eilutes duomenu grupes adresas         
	lea	di, entr+3	;Nuskaitomas tolesnes eilutes duomenu grupes adresas          
didysis_ciklas:
	push	cx	  	;Issaugojamas didziojo ciklo skaitliukas                      
        push    si		;Issaugomi adresai                                            
        push    di                                                                            
cikliukas:
	xor	ax, ax		;Isvalomi registrai                                           
	xor	bx, bx                                                                        
	mov	al, [si+2]	;Ivedame eilutes m. r. sk                            
	mov	bl, [di+2]	;Ivedamas tolesnes eilutes m.r. sk                   
	cmp	ax, bx		;Jas palyginime                                                                  
	jg	sukeitimas	;Jei 1 eil m.r.> eil duom sukeitimas                 
	jmp	tasa2		;Jei ne                                                       
sukeitimas:	
	;is pirmesnio i talpykla                                                              
	mov	laik+2, ax	;I laikina talpykla sukeliami eilutes duomenys (m.r. sk)
	mov	ax, [si+1]	;I registra ikeliamas eilutes elementu sk                          
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
tasa2:
	add	si, 3    	;Lyginamos kitos dvi eilutes       
	add	di, 3     	;Tolesne -i esama eilute           
	loop cikliukas    	;Dar tolesne -i tolesne            
	pop     di		;Grazinami didieji adresai - vel lyginamos 1-osios eilutes       		
	pop     si                                                                                        
	pop	cx                                                 
	loop didysis_ciklas                                        
                                                                   
	;Atspausdinimas                                            
	mov	ah, 09h                                                     
	lea	dx, pran3                                                   
	int	21h	  	                                   
	xor	cx, cx          ;Isvalomas skaitliuko registras    
	mov	cl, sk		;Isivedamas eiluciu sk             
	lea	si, entr	;Suadresuojamas pagalbinis masyvas entr                                   
	lea	di, entr                                           
atspausdinimas:
	push	cx     		;Issaugomas eiluciu skaicius	                                   
	mov	cl, [si+1]      ;Ivedamas eilutes elementu sk      
	push	si              ;Issaugojamas adresas              
	;***************                                           
	mov	si, [di]       	;I si ikeliam eilutes adresa           
	push	di     		;Issaugojam pagalbinio masyvo adresa         
	lea	di, spausd	;Pagalbinio masyvo pirmojo adreso priskyrimas
simbolis:
	xor     ax, ax 		;Isvalomas eilutes adresas         
	mov     ax, si                                             
	xor     ah, ah                                             
	mov     si, ax                                             
	mov     al, [si]	;Perkeliamas masyvo elementas i pagalbini atspausdinimo masyva
	mov	[di], al                                           
	inc	si      	;Sekantys elementai                                   
	inc	di                                                                            
	loop simbolis                                              
	mov     al, '$'		;I pagalbini spausdinimo masyvo pabaiga ikeliamas "$" masyvo apribojimui
	mov	[di], al                                                                          
	pop	di      	;Grazinami globalus adresai        
	add	di, 3           ;Padidinami tolesnei eilutei spausdinti              
	pop	si                                                                                       
	add	si, 3                                              
	lea	dx, spausd      ;Atspausdinama eilute              
	mov	ah, 09h                                            
	int	21h                                                
	lea     dx, enteris	;Atspausdinamas [ENTER]            
	mov     ah, 09h                                            
	int     21h                                                                            
	pop	cx              ;Grazinamas eiluciu skaiciaus skaitliukas                           
	loop atspausdinimas                                        
                                                                   
	;end                                                       
	mov 	ah, 09h                                                     
	lea	dx, pran4                                                   
	int	21h		                                   
                                                                            
	mov	ah, 07h	 	;Laukimas                          
	int	21h                                                         
                                                                   
        mov     ah, 4ch                                            
        int     21h                                                
programa ends                                                           
end start           