stekas segment stack 
	DB 256 dup(?)
stekas ends          
                     
duom segment         
	;pranesimai
	pran1 db 'Atliko: Giedre Bruzaite',10,13,'$'
	pran2 DB 'EGZMINAS',13,10,'$'
	pran3 DB 'Salyga:c=(a+b)/5: ',10,13,'$'
	pran4 db 10,13,'Skaiciu suma: $'                       
	pran5 DB 10,13,'Padalinus gauname: $'
	pran6 db 'Iveskite pirma skaiciu: $'                       
	pran7 db 10,13,'Iveskite antra skaiciu: $'                 
	pran8 db 10,13,'Didesnio skaiciaus ivesti nebegalima!!! $'
        klaida db 10,13,'KLAIDA, Galima ivesti tik skaicius.$'
        klaidaa db 'IVESTI SKAICIAI ISLIEKA!!!',10,13,'$'        
     
        atmp dw 0  
        a dw 0,'$'                                            
        b dw 10,'$'                          
        nulis db 0,'$'                               
        penki db 5,'$'                               
        sum db 6 dup(?),'$'                            
        sumtmp dw 0      
                sveik db 6 dup(?),'$'
        liek db 1 dup(?),'$'                                   
        kab db ',$'                                 
        dal dw 5     
        des dw 10    
        minus db '-$'
        vienas db 1
        z db 0 
        z1 db 0
        z2 db 0
        zz db 0                                  
duom ends                                              
           
progr segment                          
assume cs:progr, DS:duom, ss:stekas    
start:                                 
	mov AX,duom                    
	mov DS,AX       
       
	mov ax,0002h    
	int 10h         
	    
	mov ah,09h          
	lea dx,pran1         
	int 21h         
	             
	mov ah,09h          
	lea dx,pran2         
	int 21h             
                 
	mov ah,09h          
	lea dx,pran3        
	int 21h     
	     
	mov ah,09h  
	lea dx,pran6
	int 21h     
	jmp programa
	
	ivedimas proc                                              
       
        mov ah,08h                                                 
        int 21h                                                    
            
        cmp al,2dh
        je zenklas
        cmp al,30h                          
        jb klaida1                          
        cmp al,39h                          
        ja klaida1  
                                    
        
        mov ah,02h                 
        mov dl,al                 
        int 21h                   
        
        sub al,30h                   
                      
        xor ah,ah                     
        add a,ax                  
                                  
        sk_ivedimas:              
                       
        mov ah,08h                
        int 21h        
                       
        cmp al,13      
        je pab         
        cmp al,30h     
        jb klaida2     
        cmp al,39h     
        ja klaida2     
                       
        xor dx,dx        
        mov ah,02h     
        mov dl,al                        
        int 21h        
        sub al,30h     
        xor ah,ah      
        mov atmp,ax    
        mov ax,a       
        mul des        
        add ax,atmp    
        mov a,ax       
                       
        cmp a,9999     
        ja klaida3     
        jmp sk_ivedimas                 
                       
        zenklas:       
        mov z,1        
        mov ah,02h     
        mov dl,al      
        int 21h        
        jmp sk_ivedimas                 
        klaida1:          
        mov ah,09h          
        lea dx, klaida      
        int 21h                          
        lea dx,klaidaa
        int 21h    
        mov ah,08h 
        int 21h    
        cmp al,30h 
        jb klaida1 
        cmp al,39h 
        ja klaida1 
        mov ah,02h 
        mov dl,al  
        int 21h    
        sub al,30h 
        xor ah,ah    
        add a,ax           
        jmp sk_ivedimas
                                 
        klaida2:                 
        mov ah,09h               
        lea dx, klaida           
        int 21h                          
        lea dx,klaidaa           
        int 21h                  
        jmp sk_ivedimas
        klaida3:    
        mov ah,09h  
        lea dx,pran8
        int 21h         
        pab:                     
        ret            
        ivedimas endp                     
                                 
	programa:                         
	call ivedimas  
	mov al,z
	mov z1,al
	xor ax,ax
	mov ax,a       
	mov b,ax                                         
	mov ah,09h               
	          
	mov a,0
	mov z,0                  
	lea dx,pran7             
	int 21h                          
	call ivedimas                    
	mov al,z
	mov z2,al
	add al,z1
	cmp al,2
	je atimtisc
	xor ax,ax 
	mov ax,a 
	cmp z1,1
	je atimtisa
	cmp z2,1
	je atimtisb
	mov ax,a
	add ax,b
	jmp testi  
	           
	atimtisa: 
	cmp b,ax   
	jb bmaziau 
	sub b,ax
	mov zz,1
	mov ax,b
	jmp testi
	bmaziau: 
	sub ax,b
	jmp testi
	       
	atimtisb: 
	mov ax,a
	cmp ax,b   
	jb amaziau 
	sub ax,b
	mov zz,1
	jmp testi
	amaziau: 
	sub b,ax
	mov ax,b
	jmp testi                 
	
	atimtisc:  
	xor ax,ax
	mov ax,a
	add ax,b
	mov zz,1
	jmp testi	
	
	testi:                      
	mov sumtmp,ax                
                                          
	xor dx,dx                    
	mov si,5                                 
	
	ciklas:                      
	div des                      
	add dx,30h                   
	mov sum[si],dl               
	xor dx,dx                    
	cmp si,0                     
	je suma                      
	dec si                       
	cmp ax,0                     
	je suma                      
	jmp ciklas                   
	                                      
	suma:                                                       
	cmp zz,1                                     
	je zenklas1                                  
	jmp bezenklo                                 
	zenklas1:                                    
	mov sum[si],'-'                                 
                                         
        bezenklo:                                                          
	mov ah,09h                       
	lea dx,pran4                     
	int 21h                          
	mov ah,09h                       
	lea dx,sum                       
	int 21h                          
         ;(a+b)/5                        
	xor dx,dx                        
	mov ax,sumtmp                                        
	div dal                                    
	         
	cmp dl,0                            
	je liek0                         
	jmp liek5                           
	                                    
	liek0:                           
	add nulis,30h                    
	mov dl,nulis                     
	mov liek[0],dl                   
	mov si,4                         
	jmp vidurkis                     
	liek5:                           
	add penki,30h                    
	mov dl,penki                              
	mov liek[0],dl                          
	                                                
	mov si,5                         
	vidurkis:                                              
	xor dx,dx                        
	div des                          
	add dl,30h                       
	mov sveik[si],dl                 
	cmp si,0
	je atsakymas
	dec si                           
	cmp ax,0                         
	je atsakymas                     
	jmp vidurkis                     
	                                 
                                         
	                                 
	atsakymas:                     
	cmp zz,1                                     
	je zenklas2                                  
	jmp bezenklo2                                 
	zenklas2:                                    
	mov sveik[si],'-' 
	
	bezenklo2:                      
	mov ah,09h                       
	lea dx,pran5                     
	int 21h                          
	                              
	sveikas:
	mov ah,09h
	lea dx,sveik
	int 21h
	
	mov ah,09h
	lea dx,kab
	int 21h
	
	mov ah,09h
	lea dx,liek
	int 21h
	                         
	mov ah,07h    
	int 21h                   
	mov ah,4ch   
	int 21h                      
	                               
	progr ends                             
	end start     
	