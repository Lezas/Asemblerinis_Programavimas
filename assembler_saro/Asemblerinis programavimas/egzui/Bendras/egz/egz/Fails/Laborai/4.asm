
stekas segment stack                                         
        db 256 dup (?)                                       
stekas ends                                                          
;========================                                            
duomenys segment                                                     
	pran1 	db 13,10 
		db 'Valerija Lialina II-3/3',13,10                             
		db 'Programa papraso vartotoja ivesti simboliu eilute ir',13,10       
		db 'isveda nauja eilute, kuri sudaryta ivestos eilutes',13,10         
		db 'mazasias raides pakeiciant didziosiomis, o didziasias -',13,10    
		db 'mazosiomis (kiti simboliai lieka nepakite).',13,10,'$'     
	pran2	db 13,10
		db 'Iveskite simboliu eilute ir paspauskite ENTER:',13,10,'$'
	duom	db 50,?,50 dup (?)   	;Eilute duomenu ivedimui           
	error1	db 13,10                                                   
		db 'Jus neivedete eilutes!!!',10,13,'$'                        
	error2	db 10,13
		db 10,13
		db 'Jei norite pakartoti, spauskite klavisa [A]',10,13
	        db 'Jei norite iseiti lauk, spauskite ENTER',10,13,'$'
	pran3	db 10,13                                              
		db 10,13                                              
		db 'Pakeista eilute:',13,10,'$'                                                                                
                                                                      
duomenys ends                                                         
;========================                                             
programa segment                                                      
assume cs:programa, ds:duomenys, ss:stekas                         
start:                                                             
        mov     ax, duomenys                                       
        mov     ds, ax          ;Duomenu segmento prijungimas  
                                                         
        mov     ax, 0002h                                          
        int     10h             ;Isvalome ekrana        
                                                         
	mov	ah, 09h                                                     
	lea	dx, pran1                                                   
	int	21h	                                 
                                                                            
	program:                                                            
	mov	ah, 09h                                                     
	lea	dx, pran2                                                   
	int	21h	                                 
                                                                            
	mov	ah, 0ah                                                     
	lea	dx, duom                                                    
	int	21h		;Nuskaitoma simboliu eilute                 
                                                                            
        ;Tikriname ivedima                                                  
	xor	cx, cx                                                      
        mov     cl, duom+1      ;Nuskaito ivestu simb sk                    
        cmp     cl, 0           ;Tikrina ar=0                               
        je      klaida1         ;=0                                           
        jmp     tasa1           ;=/0                                        
        klaida1:                                                                         
        mov     ah, 09h                                                                  
        lea     dx, error1                                                               
        int     21h                                                                      
        jmp     tasa5                                                                    
        tasa1:                                                                           
      	mov	ah, 09h                                                                  
	lea	dx, pran3                                                                
	int   	21h		                                                         
                                                                                         
	;=====                                                                           
	lea	si, duom+2	;Isimenamas duomenu eilutes pirmasis adresas             
	ciklas:                                                                          
	xor	dx, dx                                                                   
	mov	dl, [si]	;Isikeliamas eilutes simbolis                            
	cmp	dl, 41h		;Tikrinam ar simbolis mazesnis uz raidziu zona [41h-5Ah,61h-7Ah] 
	jl	cikl_tasa	;Ne raide (<41h) - paprastas spausd                      
	cmp	dl, 5bh		;Ar didzioji raide [41h-5Ah]                             
	jl	mazosios	;T - sumazinam ir spausd                               
	cmp	dl, 61h		;Ar ne mazoji raide (<61h)                               
	jl 	cikl_tasa	;N - paprastas spausd                    
	cmp	dl, 7bh		;Ar mazoji raide [61h-7Ah]                                         
	jl	didziosios	;T - padidinam ir spausd                   
	jmp	cikl_tasa	;Ne raide - paprastas spausd
	mazosios:                                                                        
	add	dl, 20h	 	;Postumis per 20h - mazoji raide
	jmp	cikl_tasa                                         
	didziosios:                                                                      
	sub	dl, 20h		;Postumis per 20h atgal - didzioji raide
	cikl_tasa:    		                                                         
	mov	ah, 02h		;1 simb atspausdinimas                                   
	int	21h                                                                      
	inc     si   		;padidina duomenu elem adresa (next simb)
	loop	ciklas                                                                   
       	jmp	tasa5	                                                                 
                                                                                         
        suolis:                                                                          
        jmp     program                                                     
                                                                            
	tasa5:	       		;Ar dar dirbsime                           
	mov	ah, 09h                                                     
	lea	dx, error2                                                  
	int	21h	                                  
                                                                            
        mov     ah, 08h         ;Nuskaitomas 1 simbolis     
        int     21h                                                         
        cmp     al, 'a'         ;Tikrinam, ar neivesta 'a'
      	   mov     ax, 0002h    ;isvalo ekrana                                      
           int     10h                                                              
        je      suolis                                                     
                                                                           
       	;end                                  
        mov     ah, 4ch                                                    
        int     21h      
programa ends                                                           
end start        