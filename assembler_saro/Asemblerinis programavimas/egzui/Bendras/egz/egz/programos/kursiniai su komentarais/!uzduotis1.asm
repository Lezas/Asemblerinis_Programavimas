stekas segment stack 
	DB 256 dup(?)
stekas ends          
                     
duom segment         
	;pranesimai
	pran1 db 'Kursinio darbo pirma programa',10,13,'$'
	pran2 DB 'Uzduoti atliko: Giedre Bruzaite',13,10,'$'
	pran3 DB 'Salyga: isvesti dvieju skaiciu suma',10,13,'$'
	pran4 db 10,13,'Skaiciu suma: $'                       
	pran6 db 'Iveskite pirma skaiciu ir paspauskite ENTER: $'
	pran7 db 10,13,'Iveskite antra skaiciu ir paspauskite ENTER: $'                 
	pran8 db 10,13,'Didesnio skaiciaus ivesti nebegalima!!! $'
        klaida db 10,13,'KLAIDA, Galima ivesti tik skaicius.$'
        klaidaa db 'IVESTI SKAICIAI ISLIEKA!!!',10,13,'$'        
        ;duomenys   
        atmp dw 0  ;naudojamas ivedant skaicius kai dauginu is 10
        a dw 0,'$' ;i a talpinu ivesta skaiciu                                              
        b dw 10,'$'; talpinamas antras ivestas skaicius
 	sum db 6 dup(?),'$';sumos talpinimas                                                    
        sumtmp dw 0      ; sumai saugoti kad poto galetumem skaiciuot   vidurki                               
        sveik db 6 dup(?),'$'; sveikajai vidurkio daliai saugoti
        liek db 1 dup(?),'$' ;vidurkio liekanai saugoti                                   
        kab db ',$'  ;atskirti liekana nuo kablelio                                  
        dal dw 2     ;dalinam kai ieskom vidurkio                                  
        des dw 10    ;dalinam skaiciu isvedinejant i masyva
        minus db '-$'
        vienas db 1
        z db 0
        z1 db 0
        z2 db 0
        zz db 0                               
duom ends                                              
;programinis segmentas                 
progr segment                          
assume cs:progr, DS:duom, ss:stekas    
start:                                 
	mov AX,duom                    
	mov DS,AX
       
        ;ekrano valymas	
	mov ax,0002h    
	int 10h         

	;pranesimo isvedimas      
	mov ah,09h          
	lea dx,pran1         
	int 21h         

	;pranesimo isvedimas               
	mov ah,09h          
	lea dx,pran2         
	int 21h             

	;pranesimo isvedimas                    
	mov ah,09h          
	lea dx,pran3        
	int 21h     

	;pranesimo isvedimas      
	mov ah,09h  
	lea dx,pran6
	int 21h     
	jmp programa

	;skaiciaus nuskaitymo is klavos ir talipinimo i a procedura
	ivedimas proc                                              

        ;nuskaito simboli
        mov ah,08h                                                 
        int 21h     
                                               
        ;tikrina ar ivestas skaicius pradzia
        cmp al,2dh
        je zenklas
        cmp al,30h                          
        jb klaida1                          
        cmp al,39h                          
        ja klaida1 
 
        ;tikrinimo ar ivestas skaicius pabaiga                          
        ;rodo ivesta skaiciu ekrane 
        mov ah,02h                 
        mov dl,al                 
        int 21h                   
        ;pavercia is skaiciaus i koda
        sub al,30h                   
        ;nunulina ah kad ivestumem i a gera reiksme
        xor ah,ah                     
        add a,ax                  
                                  
        sk_ivedimas:              
        ;iveda skaiciu
        mov ah,08h                
        int 21h     
        ;tikrina ar enter
        cmp al,13   
        je pab      
        cmp al,30h  
        jb klaida2     ; FALSE  
        cmp al,39h  
        ja klaida2  
        ;padauginam buvusi a is 10 ir pridedam ivesta sk
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
        ;tikrina kad nebutu didesnis skaicius uz word ilgi
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
        ;pranesimo isvedimas
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
        ret      ;tarpas            
        ivedimas endp                     
                                 
	programa:                         
	;iskvieciam skaiciaus ivedimo procedura
	call ivedimas  
        mov al,z
        mov z1,al
	xor ax,ax
	mov ax,a       
	mov b,ax                                         
	mov ah,09h               
	;nunulinam a             
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
	           
	atimtisa: ;kai neigiamas pirmas skaicius(b)
	cmp b,ax   
	jb bmaziau 
	sub b,ax
	mov zz,1
	mov ax,b
	jmp testi
	bmaziau: 
	sub ax,b
	jmp testi
	        
	atimtisb: ;kai neigiamas antras skaicius(a)
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
	        
	atimtisc:  ;kai abu skaiciai neigiami
	xor ax,ax
	mov ax,a
	add ax,b
	mov zz,1
	jmp testi	
	;patalpinam suma i laikina kint kad galetumem suskaiciuot vidurki
	testi:                       
	mov sumtmp,ax                
                                     
                                     
                                     
	                             
	;sumos talpinimas i sum ir pavertimas i skaiciu                                      
	xor dx,dx                    
	mov si,5                                 
	;skaiciaus talpinamas i masyva kad isvest i ekrana
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
	                                             
	;sumos spausdinimas                          
	suma:                                        
	;ziurim ar suma neigiama                     
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

	            
	;stabdo ekrana              
	mov ah,07h    
	int 21h       
	;grazina valdyma dosui              
	mov ah,4ch   
	int 21h                      
	                               
	progr ends                             
	end start     
	