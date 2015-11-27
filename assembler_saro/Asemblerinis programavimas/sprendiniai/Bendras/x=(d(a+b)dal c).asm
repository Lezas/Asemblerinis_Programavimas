stekas segment stack
              
	db 256 dup (?)
              
stekas ends   
                                              
duomenys segment                              
                                              
	pran1 db 'Skaiciuojama triju skaiciu suma (d*(a+b)/c)',13,10
              db 'Skaiciai yra tokie: a=1,b=2,c=3,d=2',13,10    
              db 'Atliko: Viktorija Briskmanaite, II-04/4 ',13,10,'$'          
        pran2 db 'Skaiciavimu rezultatas:','$'
                                              
        a db 1                                
	b db 2                                
	c db 3                                
	d db 2                                
	product db ?,'$'                      
                                              
duomenys ends                                 
                                              
                                              
programa segment                              
	assume cs:programa, ds:duomenys, ss:stekas
start:                                        
       mov ax,0002h
       int 10h
       
       	mov AX,duomenys                       
       	mov DS,AX                             
                                              
	mov AH,09h                            
        lea dx,pran1                          
        int 21h                               
        lea dx,pran2                          
        int 21h                               
                                              
        mov BH,a	                      
        add BH,b                              
	                                      
	mov AL,BH                             
	mov AH,0                              
        mul d                                 
                                              
        div c                                                
     	mov product,AL	                      
	add product,30h	                      

	mov ah, 09h                           
	lea DX, product                       
	int 21h		                      
                                              
mov ah, 07h   
int 21h  
mov Ah, 4ch
int 21h                                       
programa ends                                 
end start