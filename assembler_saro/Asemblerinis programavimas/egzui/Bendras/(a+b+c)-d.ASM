 STeCK segment stack 
	db 256 dup (?)
STeCK ends                       
                                 
DATA segment                     
	                         
	a dw 16, "$"             
	b dw 1, "$"              
	c dw 3 , "$"
	GrNr dw 3, "$"
              
	d dw 10, "$"             
	                         
	masyvas db 3 dup (0) , "$"
	                         
        eil db 'Egzamino darbas ',13,10  
	    db 'Atliko R.Stulgaite',13,10  
	    db '(a+b+c)-GrNr=',"$"
	                         
DATA ends                        
                                 
CODE segment                     
	assume CS: CODE, DS: DATA, SS: STeCK
                                 
START:                           
          	                 
	MOV ax, DATA             
	MOV ds, ax  ;i ax uzkraunami duomenys
	
	mov ax,0002h
        int 10h              ; isvalo ekrana 
                                            
        MOV ah, 09h                         
        LEA dx, eil                        
        INT 21h     
                  
                                 
	MOV ax, a               ; 
	ADD ax, b                
	ADD ax, c                
	SUB ax, GrNr             
                                 
                                 
	MOV SI, 1 ;paskiria masyvo elemento numeriui skaiciu 1
                                 
	MOV cx, 2 ;kartoja cikla 2 kartus nes gauname dvizenkli skaiciu
	LOOP_:                   
		                 
		MOV dx, 0        
		DIV d            
		MOV masyvas[SI], dl
		ADD masyvas[SI], 30h
	 	DEC SI
	 	           
                                
	LOOP LOOP_               
                                 
                                 
                                 
	MOV ah, 09h              
	LEA dx, masyvas          
	INT 21h                  
                                 
	mov ah,07h
	int 21h                   
                                 
	MOV ah, 4ch              
	INT 21h                  
                                 
	                         
CODE ENDS                        
END START