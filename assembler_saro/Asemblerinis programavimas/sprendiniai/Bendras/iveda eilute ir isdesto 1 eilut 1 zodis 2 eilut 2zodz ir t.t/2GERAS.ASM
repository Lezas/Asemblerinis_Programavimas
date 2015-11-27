stekas segment stack                                                              
        db 256 dup (?)                                                                                  
stekas ends                                                                                             
                                                               
duomenys segment                                                                                        
	pran1	db 13,10,'Deivydas Pivorius II-21 gr.'           
		db 13,10,'Kursinis darbas Nr 2.',13,10         
		db 13,10,'Programa papraso vartotojo ivesti simboliu eilute'
		db 13,10,'ir simboli skirtuka.'                
		db 13,10,'Isveda ivesta teksta taip:'          
		db 13,10,'pirmoje eiluteje - 1 zodis, antroje - 2'
		db 13,10,'trecioje - 3 zodziai ir t.t.',13,10,'$'
	pran2	db 13,10,'Iveskite simboliu eilute:$',13,10,'$'
	pran3	db 13,10,'Iveskite zodziu atskyreja:',13,10,'$'
	pran    db 13,10,'********************',13,10,'$'
	pran4	db 13,10,'Programos pabaiga',13,10,'$'
	duom	db 255,?,255 dup ()	;pieviska eilute duomenu ivedimui
	ats	db 255 dup ('$')                      
	skirst	db ?		;Skirtukas            
	galinis	dw ?		;Duomenu pabaigos adresas
	prad	dw ?		;Duomenu pradzios adresas
duomenys ends                                                                                           
;========================                                                                               
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

	mov	ah, 09h                                                                                 
	lea	dx, pran2                                                                               
	int	21h	                           
        	                                   
	mov	ah, 0Ah                                                                                 
	lea	dx, duom                                                       
       	int	21h   		
                                                                                          
skirejas:                                          
	mov 	ah, 09h                             
	lea	dx, pran3                           
	int	21h		
                                                    
	mov	ah, 08h                             
	int	21h		;Sirstuko nuskaitymas i al
                                                    
	xor	dx, dx                              
	mov	dl, al                              
                                                    
	cmp	al, 0dh         ;tikrina ar ivesta                    
	jne	toliau		                   
	jmp	skirejas                           
	   	                                    
toliau:                                             
	mov     skirst, al                          
	                                                    
	xor	cx, cx		
	mov	cl, duom + 1	;Isimenamas duomenu failo dydis
	lea	si, duom + 2	;Isimenamas duomenu eilutes pirmasis adresas
	                                            
	push	si   		;Issaugojama pardzia
	add	si, cx                                                         
	mov	galinis, si 	;issaugom gala
	pop	si        	
	                                           
	lea	bx, duom + 1	;Nustatomas pradzios adresas
	mov	prad, bx                            
	xor	bx, bx      	
	xor	ax, ax                              
	lea     di, ats                             
	                                            
	push	ax                                  	                                           
ciklas:                                                                                            
	cmp	si, galinis	;Lyginama, ar ne eilutes pabaiga
	je	galini          
	mov	bl, skirst      ;Lyginama, ar ne skirstukas                  
	cmp	[si], bl                           
	je	zemiau          
	mov	bl, 0dh		;Tikrina, ar ne [ENTERIS]
	cmp	[si], bl                           
	je	entrs                              
	call	simbolis	;Iskvieciame procedura 
	jmp	ciklas		      
entrs:                                             
	add 	si, 2  	  	;Persokamas [ENTER]
      	jmp	ciklas                             
zemiau:                                            
	dec	al              ;Sumazinam zymekli, pagal kuri skaiciuojam zodzius
	cmp	al, 0           ;Lyginam ar dar nera mazesnis uz 0                       
	jl	eil_galas                                        
	call	simbolis2        ;Atspausdinam simboli                        
	jmp	ciklas          ;I pradzia
eil_galas:                                 
	call	new_line            ;isvedimas i nauja eilute
	pop	ax              ;Globaliai zymekli padidinamas ir issaugomas
	inc	ax                                            
	push	ax                                            
	jmp	ciklas          ;I pradzia
galini:                                    
        lea	dx, ats       ;Atsakymo masyvo adreso priskyrimas
	mov	ah, 09h                                       
	int	21h             
	                                 
	mov     ah, 09h                  
	lea     dx, pran                 
	int     21h             
	                                                   
	jmp	pabaiga		;Jau tipo arteja galas              
                                                                                                                                      
pabaiga:       	  	                 
	mov	ah, 09h                                                    
	lea	dx, pran4                                  
	int   	21h  	   	
                                                           
galas:                                                           
	mov	ah, 07h        
	int	21h 
                                       
        mov     ah, 4ch                                            
        int     21h             
simbolis proc                            
	mov	bl, [si]	;Ivedamas masyvo elmentas
	mov	[di], bl                 
	inc	si		
	inc	di                       
	inc	cx                       
	ret	      		
simbolis endp 
         
simbolis2 proc
        mov	bl, [si]	;Ivedamas masyv elmentas
        mov     bl,' '
	mov	[di], bl                 
	inc	si		;Tolesni elementai
	inc	di                       
	inc	cx                       
	ret	    
simbolis2 endp
                                         
new_line proc         
	mov	bl, [si]	;Atspausdinamas simbolis
	mov     bl,' '
	mov	[di], bl
	inc	di                       
	inc	si                       
	mov	bl, 0dh		;Nauja eilute
	mov	[di], bl                 
	inc	di                       
	mov	bl, 0ah                  
	mov	[di], bl                 
	inc 	di                       
	ret	 		
new_line endp

programa ends                                                           
end start        