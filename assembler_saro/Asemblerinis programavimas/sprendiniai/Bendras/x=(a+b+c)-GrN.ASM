stekas segment stack
	db 256 dup (?)
stekas ends                       
                                 
duomenys segment
	                         
	a dw 16, "$"             
	b dw 1, "$"              
	c dw 83 , "$"             
	GrNr dw 4, "$"
              
	d dw 10, "$"             
	                         
	masyvas db 3 dup (0) , "$"
	                         
        eil db 'Egzamino darbas ',13,10  
	    db 'Atliko Viktorija Briskmanaite, II-04/4',13,10  
	    db '(a+b+c)-GrNr=',"$"
	                         
duomenys ends
                                 
programa segment                     
	assume CS: programa, DS: duomenys, SS: stekas
                                 
START:                           
          	                 
	MOV ax, duomenys             
	MOV ds, ax  ;i ax uzkraunami duomenys
	
	mov ax,0002h
        int 10h              ; isvalo ekrana 
                                            
        MOV ah, 09h                         
        LEA dx, eil                        
        INT 21h     
                  
                                 
	MOV ax, a           
	ADD ax, b  ; (a+b)             
	ADD ax, c  ;(a+b+c)              
	SUB ax, GrNr  ;(a+b+c)-grnr           
                                 
  	MOV SI, 1 ;paskiria masyvo elemento numeriui skaiciu 1
        MOV cx, 2 ;kartoja cikla 2 kartus nes gauname dvizenkli skaiciu
	LOOP_:                   
		                 
	MOV dx, 0
	DIV d
	MOV masyvas[SI], dl
	ADD masyvas[SI], 30h
	DEC SI  ;si sumazinam vienetu
	 	           
        LOOP LOOP_  ; kartojam cikla
                                 
       	MOV ah, 09h
	LEA dx, masyvas          
	INT 21h                  
                                 
	mov ah,07h
	int 21h                   
    	MOV ah, 4ch              
	INT 21h                  
                                 
	                         
programa ENDS
END START