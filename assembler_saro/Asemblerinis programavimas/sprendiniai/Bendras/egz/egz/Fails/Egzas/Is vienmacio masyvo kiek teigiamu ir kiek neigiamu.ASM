stekas segment STACK
	db 256 dup(0)
stekas ends                             
            
duomenys segment
  pran db '',10,13
	db 'Uzduotis Nr.5',10,13
	db 'Suskaiciuoti kiek yra masyve,',10,13
	db 'is desimt elementu aprasytu programoje',10,13
	db 'teigiamu skaiciu, kiek neigiamu.',10,13
	db 'Rezultata isvesti ekrane',10,13
        db 'Atliko: Jurij Dashkevich IIno-2',10,13
	db '',10,13
	db 'Masyvas (10,2,63,-44,11,1,66,42,3,-9)',10,13,'$'

  teig db 10,13,'Teigiamu - ','$'       
  neig db 10,13,'Neigiamu - ','$'       
  masyvas db 10,2,63,-44,11,1,66,42,3,-9,'$'
  plius db 2 dup(0),'$'  
  minus db 2 dup(0),'$'  
duomenys ends                                                  
                                                               
programa  segment                                                                                   
	ASSUME CS:programa, DS:duomenys, SS:stekas                                           
START:                                                   
                
;Duomenu inicializavimas                          
	mov AX,duomenys                        
	mov DS,AX                                
                
;Pranesimo isvedimas                                                         
        mov AH,09h                    
        lea DX,pran                                            
        int 21h                       
                           
;Masyvas                               
        lea BX,masyvas                                              
        mov AX,0                                                
        mov DL,[BX]                                             
        mov plius,0                                      
        mov minus,0               
                                               
CIKLAS:                                                                                       
        inc BX                                                                                                             
        mov DL,[BX]                                             

	cmp CX,[BX]
        jns NEIGIAMI
	
	inc plius 
                                                                
        cmp DL,'$'                                              
        jne CIKLAS                                             

;Teigiamu skaichiu ishvedimas
        mov AH,plius
        mov plius,AH                                     
        add plius,30h 
        mov AH,09h                                             
        lea DX,teig                                           
        int 21h                             
        mov AH,09h                                             
        lea DX,plius                                           
        int 21h                              	               

;Neigiamu skaichiu ishvedimas
        mov AH,minus
        mov minus,AH                                     
        add minus,30h 
        mov AH,09h                                             
        lea DX,neig                                           
        int 21h                               
        mov AH,09h                                             
        lea DX,minus                                           
        int 21h   

;Ekrano uzhlaikymas                                      
 	mov AH,07h                                              
 	int 21h	                                                 
                                                                
;Programos pertraukimas                                                        
	mov AH,4Ch                                              
	int 21h                                                 
                                                          
NEIGIAMI:
	inc minus                                                               
	jmp ciklas  
                                                                               
programa  ends                                                 
end start                                            