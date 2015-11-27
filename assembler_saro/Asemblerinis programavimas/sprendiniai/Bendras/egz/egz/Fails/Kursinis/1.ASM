stekas segment stack                                         
        db 256 dup (?)
stekas ends                                                          
;========================                                            
duomenys segment                                                     
	pran1	db 10, 13, 'Valerija Lialina'
		db 10, 13, 'Programa papraso vartotoja ivesti simboliu eilute '
		db 10, 13, 'ir viena simboli,'
		db 10, 13, 'suskaiciuoja nurodyto simbolio pasirodymu eiluteje'
		db 10, 13, 'skaiciu, ir si skaiciu isveda i ekrana', 10, 13,'$'
	pran2	db 10, 13, 'Iveskite simboliu eilute', 10, 13,'$'          
	duom	db 50,?,50 dup (?)	;Eilute duomenu ivedimui           
	er1	db 10, 13, 'Jus neivedete eilutes$'
	er2   	db 10, 13, 'Jei norite pakartoti, spauskite [y]', 10, 13,'$'
	er3     db 10, 13, 'Jus neivedete simbolio$'
	pran3	db 10, 13, 'Iveskite skaichiuojama simboli', 10, 13,'$'
	pran4	db 10, 13, 'Simbolis kartojasi tiek kartu: $'               
	des	dw 10                                                       
duomenys ends                                                               
;========================                                                   
programa segment                                                            
assume cs:programa, ds:duomenys, ss:stekas                                  
start:                                                                      
        mov     ax, duomenys
        mov     ds, ax          ;Duomenu segmento prijungimas               
                                                                            
        mov     ax, 0002h                                                   
        int     10h             ;Ishvalomas ekranas                          
                                                                            
	mov	ah, 09h                                                     
	lea	dx, pran1                                                   
	int	21h		;Ishvedamas praneshimas pran1                 
                                                                            
program:
	mov	ah, 09h                                                     
	lea	dx, pran2                                                   
	int	21h		;Ishvedamas praneshimas pran2                 
                                                                            
	mov	ah, 0ah                                                     
	lea	dx, duom                                                    
	int	21h		;Nuskaitoma simboliu eilute                 
                                                                            
; Tikrina ivedima                   
        mov     cl, duom+1      ;Nuskaito ivestu simboliu skaichiu
        cmp     cl, 0           ;Tikrina ar jis nelygus 0                   
        je      klaida1         ;=0                                           
        jmp     tesiam1           ;nelygus 0
        klaida1:                                                            
        mov     ah, 09h                                                     
        lea     dx, er1                                                  
        int     21h             ;Ishveda klaida er1                     
        jmp     tesiam5           ;Shuolis, ar norite testi               
        tesiam1:                                                                   
	mov   	ah, 09h                                                     
	lea	dx, pran3                                               
	int	21h	 	;Ishvedamas praneshimas pran3           
                                                                            
        mov     ah, 08h         ;Nuskaitomas vienas simbolis            
        int     21h		;kuris patalpintas al                       
; Tikrina ivedima                                                       
  	cmp	al, 0dh		;Tikrinama, ar nebuvo nuspaustas [ENTER]
	je	klaida2                                                 
       	jmp	tesiam2                                                   
        klaida2:                                                            
        mov     ah, 09h                                                     
        lea     dx, er3                                                 
        int     21h             ;Ishveda klaida er3                     
        jmp     tesiam5           ;Shuolis, ar norite testi               
        tesiam2:                                                                   
        xor     dx, dx                                                  
        mov     dl, al                                                  
        mov     ah, 02h         ;Atspausdinamas simbolis                
        int     21h               	                                                             
;skaichiuojam pasikartojima                                             
	lea	si, duom+2                                                  
	xor	cx, cx                                                      
	xor	bx, bx                                                      
	mov	cl, duom+1                                                  
	ciklas:                                                             
	mov	ah, [si]                                                    
	cmp	ah, al                                                      
	je	prideda                                                     
	jmp	tesiam3                    
	prideda:                         
	inc  	bl                       
	tesiam3:                                             
	inc     si                       
	loop	ciklas                                     
                                                           
; Atspausdinam atsakymas
	mov	ah, 09h                                    
	lea	dx, pran4                                  
	int	21h  	    	;Ishvedamas pranesimas pran4
	                                                   
	mov	ax, bx		;Atsakyma isikeliam i ax   
	push	'$'   		;Uzhzhymima ishvedamo steko riba (kada sustot)
	mov 	bx, des		;Dalinimui is 10                           
                                                           
	isteka:	      		;Dedam skaichius i steka
	xor     dx, dx                                                     
	div	bx		;ax - sveikoji, dx - liekana               
	push	dx		;Kisham skaichius                            
	                                                                   
	cmp	ax, 0		;Ar dar liko skaichiu?                      
	jne	isteka		;Liko, -> isteka:                          
                                                                           
	issteko:		;Ishtraukiami skaichiai is steko             
	pop	dx		;Ishtraukiamas sheshioliktainis skaichius
	cmp 	dx,'$'		;Ieshkoma steko riba ("$")                  
	je	tesiam5		;ats: "taip"                               
	add 	dx, 30h 	;Verchiama i normalu atvaizdavima           
	mov	ah, 02h                                                    
	int 	21h  		;Atspausdinamas skaitmuo   	           
	jmp	issteko                                                    
                                                                           
        megasuolis:                                                        
        jmp     program                                                    
                                                                           
	tesiam5:	      	;Ar tesim darba?
	mov	ah, 09h                                                    
	lea	dx, er2                                                  
	int	21h   	   	;Ishvedamas praneshimas er2
                                                                           
        mov     ah, 08h         ;Nuskaitomas vienas simbolis
        int     21h                                                        
        cmp     al, 'y'         ;Tikrinama, ar neivesta 'y'                
        je      megasuolis                                                 
                                                                           
; pabaiga
                                                                           
        mov     ah, 4ch                                                    
        int     21h             ;Ishejimas i DOS'a
programa ends                                                              
end start        