
stekas segment stack                                         
        db 100h dup (?)                                       
stekas ends                                                          
;========================                                            
duomenys segment                                                      
	pran1	db 0ah,0dh,'Ana Bikevic.'            
		db 0ah,0dh,'Mazasias raides vercia i didziasias.',0ah,0dh,'$'
	pran2	db 0ah,0dh,'Iveskite simboliu eilute:',0ah,0dh,'$'    
	duom	db 50,?,50 dup (?)	;Eilute duomenu ivedimui           
	error1	db 0ah,0dh,'Jus neivedete eilutes$'                        
	error2	db 0ah,0dh,'Jei norite pakartoti, spauskite [y]',0ah,0dh,'$'
	pran3	db 0ah,0dh,'Modifikuota eilute:',0ah,0dh,'$'          
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
	int	21h   		;Isvedamas pranesimas pran1                 
                                                                            
	program:                                                            
	mov	ah, 09h                                                     
	lea	dx, pran2                                                   
	int	21h		;Isvedamas pranesimas pran2                 
                                                                            
	mov	ah, 0ah                                                     
	lea	dx, duom                                                    
	int	21h		;Nuskaitoma simboliu eilute                 
                                                                            
        ;=====Operuojama eilute                                       
	xor	cx, cx		;Isvalomi registrai                   
        mov     cl, duom+1      ;Nuskaito ivestu simboliu skaiciu                                                 
        cmp     cl, 0           ;Tikrina ar jis nelygus 0                   
        je      klaida1         ;=0                                           
        jmp     tiesa1           ;nelygus 0                                           
        klaida1:                                                            
        mov     ah, 09h                                                     
        lea     dx, error1                                                  
        int     21h             ;Isveda klaida error1                       
        jmp     pabaiga         ;Suolis, kur paklaus, ar norite testi         


                                  
        tiesa1:                                        
	mov	ah, 09h                                                     
	lea	dx, pran3                                                   
	int	21h		;Isvedamas pranesimas pran3                
	lea	si, duom+2	;Isimenamas duomenu eilutes pirmasis adresas




	ciklas:                                                     
	mov	dl, [si]	;Isikeliamas eilutes simbolis
	cmp	dl, 61h		;Ar ne mazoji raide (<61h)
	jl	cikl_tiesa	;Ne mazhoji -> paprastas spausdinimas
	cmp	dl, 7bh		;Ar mazoji raide [61h-7Ah]
	jl	didziosios	;"Taip" -> padidinimas ir spausdinimas
	jmp	cikl_tiesa	;Ne raide -> paprastas spausdinimas
	didziosios:                                   
	sub	dl, 20h		;Postumis per 20h atgal, kad butu didzioji raide
	cikl_tiesa:   		                      
	mov	ah, 02h		;vieno simbolio atspausdinimas
	int	21h                                   
	inc     si		;padidinamas duomenu elemento adresas (sekantis simbolis)
	;=========Tarpu cikliukas                     
	push	cx		;Issaugojamas tarpu skaitliukas 
	
	loop	ciklas
	jmp	pabaiga		;Shuolis link pabaigos

        pradzion:                                                        
        jmp     program                                                    

	pabaiga:	       		;Ar dar dirbsit?                           
	mov	ah, 09h                                                    
	lea	dx, error2                                                  
	int	21h	   	;Isvedamas pranesimas error2
                                                                           
        mov     ah, 08h         ;Nuskaitomas viena simboli                 
        int     21h                                                        
        cmp     al, 'y'         ;Tikrinama, ar neivesta 'y'                
        je      pradzion                                                 
                                                                           
	;==========pabaiga===============                                  
        mov     ah, 4ch                                            
        int     21h             ;Isejimas i DOS'a
programa ends                                                           
end start        