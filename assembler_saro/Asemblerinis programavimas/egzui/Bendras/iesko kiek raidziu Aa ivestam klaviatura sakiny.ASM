stekas segment stack
	db 256 dup (0)
stekas ends
duomenys segment
	desimt db 10
	rez db '    ','$'
	temp db 0
	Masyvas db 'Stai mano masyvas: ','$'
	mas db 'A','V','R','A','R','A','A','*','$'
	raides db 255,?,255 dup (?),'$'
	ats db 10,13, 'Masyve yra tiek A raidziu: ','$'
duomenys ends        
egzas segment        
assume cs:egzas, ds:duomenys
start:               
	mov ax, duomenys
	mov ds, ax   
                     
	mov ax, 02h  
	int 10h      
                     
	mov ah, 09h  
	lea dx, masyvas
	int 21h      
                     
        mov ah, 0ah   
        lea dx, raides
        int 21h       
                      
                      
                      
      mov ah , 09h    
      lea dx, raides+2     
      int 21h        
                     
       	mov si,0     
	xor ax,ax    
	xor bx,bx    
masy:                
	mov dl,raides[si]+2
	cmp dl, '*'        
	je desim           
	cmp dl, 'A'        
	je skaiciuojam 
	cmp dl, 'a'  
	je skaiciuojam
	             
	inc si             
	jmp masy           
skaiciuojam:               
	inc al             
	inc si             
	jmp masy           
desim:  
        mov temp, al
        mov al, byte ptr temp
	div desimt          
  	add ah,30h   
	mov si,3       
	mov rez[si], ah
	dec si 
	add al, 30h
	mov rez[si], al            
;	xor ah,ah          
 ;	cmp al,0           
  ;	jne fin 
       
	             
	         
                           
	mov ah, 09h        
	lea dx,ats         
	int 21h            
	                   
	lea dx,rez         
 	int 21h            
                           
;	mov al,bl          
 	;xor ah,ah         
	;mov si,3           
                           
fin:                       
	mov ah,07h         
	int 21h            
	mov ah, 4ch        
	int 21h            
egzas ends                 
end start                  
                           
	                   
	