stekas    segment stack                        
          db 256 dup(0)                        
stekas    ends                                 
                                               
cr        equ 13 ;enteris                                                    
lf        equ 10 ;nauja eilute                  
                                  
n  equ 10                                                            
                                                                     
                                                                     
duomenys  segment                                                    
                                               
	masyvas: db n DUP (0)	; alokuojame paciame exe faile vieta masyvui							 
	                                       
pran      db '**********************************************************',10,13
          db 'Programa padare II-3/3 Valerija Lialina',10,13                                        
          db '**********************************************************',10,13         
          db 'Laboratorinis',10,13    
          db '**********************************************************',10,13
          db '***UZDUOTIS*** : Suskaiciuoti kiek yra masyve, is desimt',10,13
          db 'elementu aprasytu programoje, teigiamu skaiciu, kiek neigiamu',10,13
          db 'Rezultata isvesti ekrane.',10,13                                       
          db '**********************************************************',10,13                                             
			                                                       
	                                                                           
        teig db ?,'$'                                                
		neig db ?,'$'                                        
		desimt db 10,'$'                                     
		tmp db ?,'$'                                   
		teigsum db 'Teigiamu skaiciu kiekis yra: ','$'
		neigsum db 'Neigiamu Skaiciu kiekis yra: ','$'                   
		eilute db 10,13,'$'                                  
duomenys  ends                                                       
                                                                     
                                                                     
programa  segment                                                    
          assume cs:programa, ds:duomenys, ss:stekas                 
                                                                     
                                                                     
                                                                     
start:                                                               
;Duomenu inicializavimas                                             
          mov ax, duomenys
          mov ds,ax
 		  
;		push cs
; 		pop ds
		
                
; Masyvo inicializacija
                
		mov AL, 07h	      		; inicialiuojame akumuliatoriu
		mov DI, offset masyvas
		mov cx, n
creatarr:             
		mov [DI], AL
		dec AL		; maziname abu taip jis bus ir priliusinis ir minusinis
		inc DI		
		loop creatarr
		      
;Ekrano isvalymas                                                    
          mov ax,0002h
          int 10h                                                    
; Pranesimo isvedimas                                                         
        mov ah,09h                                                   
        lea dx,pran                                                  
        int 21h                                                      
                                                                     
                                                                     
                                                                             
        mov ax,00                                                    
       	mov cx,n                                                                                                          
        mov di,offset masyvas                                        

       	ciklas:                                                      
      	mov dh, [di]
      	cmp dh,0                                                     
      	jng nteig                                                    
			add ah,1 	; ah - teigiami              
      	nteig:                                                       
		cmp dh,0                                             
		jnl nneig                                            
			add al,1	; al - neigiami              
	      	nneig:                                               
      	inc di
		loop ciklas                                          
                                                                     
        mov teig,ah                                                  
		mov neig,al                                          
                                                                     
		mov ah, 09h                                          
        lea dx, neigsum                                              
        int 21h                                                      
                                                                     
		                                                     
		    add neig,30h                                     
			lea dx,neig		                     
			mov ah,09h                                   
			int 21h                                      
		       
		lea dx,eilute
		mov ah,09h
		int 21h
		
		     	mov ah, 09h                                  
			lea dx, teigsum                              
			int 21h                                      
			                                             
		                                                     
                                   
			cmp teig,10
			jl maziau  
			           
			mov ah,0   
			mov al, teig
			div desimt 
			mov tmp,al 
			mov teig,ah
			add tmp,30h
			lea dx,tmp
			mov al,0  			
			mov ah,09h
			int 21h
			       
		maziau:        
		        add teig,30h
			lea dx,teig		
			mov ah,09h
			int 21h
		
		
;laukia klaviso paspaudimo                                     
          mov ah, 07h                                          
          int 21h                                              
                                                               
;grizhta i DOS                                                 
          mov ah,4ch                                           
          int 21h                                              
programa  ends                                                 
          end start                                            
