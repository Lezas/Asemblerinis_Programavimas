
stekas segment stack                                         
        db 256 dup (?)          
stekas ends                                                          
;***************                                            
duomenys segment                                                     
	pran1 	db 10,13,'Kursinis darbas'
  	        db ' Atliko: Darjus Paskevic',10,13 
                db ' IIv-4 grupe',10,13                                    
		db 'Ivestam skaiciu, ir programa isveda',13,10
		db 'sio skaiciaus skaitmenu skaiciu.',13,10,'$'  
	pran2	db 13,10,'Iveskite sveikaji skaiciu, ne didesni',13,10 
		db 'kaip 1*(10)^199 ir paspauskite ENTER:',13,10,'$'
	duom	db 200,?,200 dup (?) 
	neig	db '-'                                           
	klaida1	db 13,10,'Jus neivedete skaiciaus, pakartokite...',13,10,'$'
	klaida2	db 13,10,'Ivesdami padarete klaida, pakartokite...',13,10,'$'
	ats	dw ?                                             
	pran3	db 13,10                                         
		db 13,10,'Skaiciaus skaitmenu skaicius yra:  ' ,'$'
	des	dw 10                                            
	pran4	db 13,10                                         
		db 13,10,'Jei norite pakartoti, spauskite klavisa [A]',10,13
	        db 'Jei norite iseiti lauk, spauskite ENTER',10,13,'$'
duomenys ends                                                              
;========================                                                  
programa segment                                                           
assume cs:programa, ds:duomenys, ss:stekas                                 
start:                                                                     
        mov     ax, duomenys                                               
        mov     ds, ax                                                     
                                                                           
        mov     ax, 0002h                                                  
        int     10h             ;Ekrano isvalymas                          
                                                                           
	mov	ah, 09h                                                    
	lea	dx, pran1                                                  
	int	21h    	                                                   
	                                                                   
	program:                                                           
	mov	ah, 09h                                                    
	lea	dx, pran2                                                  
	int	21h	       	                                           
                                                                           
	mov	ah, 0ah                                                    
	lea	dx, duom                                                   
	int	21h		;Nuskaitomas skaicius                      
                                                                           
	;nuskaitymas                                                       
	xor	bx,bx		                                           
	xor 	cx,cx		;isvalomi  registrai                       
                                                                           
	mov	cl,duom+1	;ivestu simb sk                            
                                                                           
	cmp	cl,0		;ar ivesta                                 
	je	suolis1		;jei=0                                     
	jmp	testi1		                                           
                                                                           
	suolis1:                                                           
           mov     ax, 0002h    ;isvalome ekrana                                      
           int     10h                                                     
	mov	ah, 09h                                                    
	lea	dx, klaida1                                                
	int	21h 		                                           
	jmp	program		                                           
                        
      	testi1:	    		    
	lea 	si, duom+2                                                 
	mov	al, [si]        ;issikeliame eil simb    
	cmp 	al, neig	;tikriname, ar simb ne neig                
	je	suolis2		                                           
	jmp	testi2		                                           
                        
	suolis2:                                                           
	inc	si		;didina adr - next simb                    
	dec 	cx		;ivestu simb sumazinimas                   
                                                                           
	cmp	cl,0		                                           
	je	suolis1		                                           
;tikrinama ar ivesti - skaiciai                                                                 
	testi2:	 	       	                                           
 	mov	ats,cx		;issaugomas sk-kiekis                      
	ciklas:                                                            
	mov     al, [si]                                                           
	cmp	al, 30h	        ;tikriname ar sk<[sk:30h-39h]              
	jl  	suolis3		                                           
	jmp  	testi3 	      	                                           
                                                                           
	suolis3:                                                           
           mov     ax, 0002h    ;isvalo ekrana                                      
 	   int     10h                                                     
	mov	ah, 09h                                                    
	lea	dx, klaida2                                                 
	int	21h	                                                   
	jmp	program	                                                   
                                                                           
	testi3:                                                             
	cmp	al, 39h 	;tikrinam sk>39h                           
	jg	suolis3		                                           
	jmp     testi4  	                                           
                                                                           
	testi4:                                                             
	inc	si                                                         
	loop	ciklas                                                     
                                                                           
	;ats                                                               
	mov	ah, 09h                                                    
	lea	dx, pran3                                                  
	int	21h	                                                   
                                                                           
	;sk atspausdinimas                                                 
	push	'$'   	  	;Uzzymima isvedamo steko riba (kada sustot)
	xor     ax, ax          ;ax-sveik
	mov	ax, ats	                   
	mov 	bx, des		; /10                           
	isteka:	      		     
	xor     dx, dx          ;dx-liekana                                           
	div	bx		               
	push	dx		;siunciam sk
	                                                                   
	cmp	ax, 0		     
	jne	isteka		     
                                                                           
	issteko:		;Istraukiami sk 
	pop	dx		                 
	cmp 	dx,'$'		                   
	je	testi5		     
	add 	dx, 30h 	                   
	mov	ah, 02h                                                    
	int 	21h  		;skaitmens atspausd	
	jmp	issteko                                                    
                                                                           
        dirbti:                                                            
        jmp     program                                                    
                                                                           
	testi5:	       		                          
	mov	ah, 09h                                                    
	lea	dx, pran4                                                  
	int	21h	       	               
                                                                           
        mov     ah, 08h         ;Nuskaitomas 1 simb                 
        int     21h                                                        
        cmp     al, 'a'                        
	   mov     ax, 0002h    ;isvalo ekrana                                      
           int     10h                                                     
	je      dirbti                                                     
                                                                           
	;end                                
        mov     ah, 4ch                                                    
        int     21h                  
programa ends                                                              
end start                                                                  
