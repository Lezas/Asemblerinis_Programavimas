stekas    segment stack                                                     
          db 256 dup(0)                                                     
stekas    ends                                                              
                                                                            
duomenys  segment                                                           
        Pran1 db ?,'Grupes Nr - II-2/2','$'
        Pran2 db ?,'Iveskite varda ir pavarde:','$'
	ivsr db 22 , ?, 22 dup ('?')
     	du db 2      
     	as db 80                      
duomenys  ends                          
                                        
programa  segment                       
          assume cs:programa, ds:duomenys, ss:stekas
                                     
start:  mov ax,duomenys              
	mov ds,ax                    
                                     
        ;ekrano isvalymas                 
 	mov ax,0002h                 
	int 10h                      
	                             
     	;spausdinam Pran2            
        mov ah,09h                   
        lea dx, Pran2                
        int 21h                      
                                     
        ;Ivedimas is klaviaturos                 
	mov ah,0ah                   
	lea dx,ivsr                  
	int 21h	                                       
 	                             
 	;ekrano isvalymas               
	mov ax,0002h                 
	int 10h                      
	;spausdinimas Pran1 per vyduri ekrano       	        
	mov ah,02                            
	mov bh,00                            
	mov dh,04                            
	mov DL,30
	int 10h                              
        mov ah,09h                           
	lea dx,Pran1                         
        int 21h                              
	                                     
        ;spausdinimas Pran2 per vyduri ekrano                                     
	mov al,as    
	sub al,ivsr+1
	mov ah,00    
	div du       
	             
	mov ah,02                            
	mov bh,00                            
        mov dh,06                            
	mov dl,al    
	int 10h                              
	             
	mov ah,00    
	mov al,ivsr+1                
	mov si,2                     
	add si,ax                    
	             
	mov ivsr[si],'$'
	                
	mov ah,09h      
	lea dx,ivsr+2       	
	int 21h	       
                                             
	mov ah,07h        
        int 21h           
                                             
	MOV ah,4Ch                           
	INT 21h                              
                                             
programa  ends                               
          end start    