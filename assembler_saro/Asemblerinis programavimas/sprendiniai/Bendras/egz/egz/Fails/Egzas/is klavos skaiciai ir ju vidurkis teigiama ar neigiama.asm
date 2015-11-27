;Steko segmentas
stekas segment stack
db 256 dup (?)
stekas ends
           
;Duomenu segmentas
duomenys segment
pran1 db 'Egzamino darbas.','$'
pran2 db 'Uzduotis: isvesti skaiciu vidurki','$'
prana db 'Atliko: Julija Skapova, II-1/6','$'
pran  db '*','$'
pran11 db 'Veskite simbolius (po kiekvieno spauskite "enter").','$'
pran12 db 'Kai noresite baigti ivedima. spauskite *','$'
pra db '',13,10,'$'
rez   db 'Rezultatas:','$'
rezt   db 'Rezultatas teigiamas.','$'
rezn   db 'Rezultatas neigiamas.','$'
over   db 'Ivyko perpildymas. Darbas bus nutrauktas','$'
           
       a dw 6,?, 6 dup (0),'$'
       b dw 0,'$'
      c db 0,'$'
     r db 6 dup (' '),'$'
    d dw 10,'$'
duomenys ends                                          
                                                       
;Programos segmentas
programa segment                   
assume cs:programa, ds:duomenys, ss:stekas
                 
 start: mov ax,duomenys	; i ds registra perkeliu
       	mov ds,ax	; duomenu segmento adresa
                                                  
;Duomenu ivedimas                                 
	mov ax,0002h	;Isvalau ekrana           
	int 10h          
                         
	mov ah,02	 
	mov dh,8        ;y
	mov dl,20       ;x
	int 10h 	                                 
        mov dx,0 	 
        mov ah,09h                                    
        lea dx,pran1     
        int 21h          
                         
	mov ah,02	 
	mov dh,9        ;y
	mov dl,20       ;x
	int 10h 	                                 
        mov dx,0 	 
        mov ah,09h                                    
        lea dx,pran2     
        int 21h          
                         
	mov ah,02	 
	mov dh,10       ;y
	mov dl,20       ;x
	int 10h 	                                 
        mov dx,0 	 
        mov ah,09h                                    
        lea dx,prana     
        int 21h          
                         
	mov ah,02	 
	mov dh,12       ;y
	mov dl,20       ;x
	int 10h 	                                 
        mov dx,0 	 
        mov ah,09h                                    
        lea dx,pran11    
        int 21h          
                         
	                 
	mov ah,02	 
	mov dh,13       ;y
	mov dl,20       ;x
	int 10h 	                                 
        mov dx,0 	 
        mov ah,09h                                    
        lea dx,pran12    
        int 21h          
	                 
	mov ah,02	 
	mov dh,12       ;y
	mov dl,25       ;x
	int 10h

;Ivedimas 
zyme: 
 	                                 
        mov dx,0 	
        mov ah,09h                                    
        lea dx,pra
        int 21h
                
        mov ah,0ah      ;nuskaitau elementa
        lea dx,a
        int 21h
	
	mov ax,a+2
	mov ah,0
	cmp ax,2Ah	;'*'
	je ivp
                                                                                                              
        lea si,a	;tekstini el. paverciu skaiciumi                                  
        mov di,00	;di saugosim skaitini elementa
        mov bx,01       ;bus desimtainis skaitliukas
        mov cx,[si+1]   ;kiek kartu buvo paspaustas klavisas
        mov ch,00
        add si,cx       ;imu i paskutini nari
        inc si          ;/  
        dec cx          ;pirma ivesta nari tikrinsim ar ne minusas
        jcxz z8             
    z7: mov ax,[si]     ;paimu nari
        sub al,30h          
        mov ah,00           
        mul bx          ;dauginam is 10^n
        add di,ax       ;di saugosim suma
        mov ax,bx       ;\  
        mul d           ; | bx*10
        mov bx,ax       ;/  
        dec si          ;keiciu adresa
    loop z7                 
        mov ax,[si]         
        cmp al,2dh          
        jne z8              
        neg di
        jmp z9
   z8:  mov dx,0 
        sub al,30h
        mov ah,00
        mul bx          ;dauginam is 10^n
        jno z18
        cmp dx,0
   z18: add di,ax       
z9:      
;skaiciavimas
	 
	mov bp,b 
	add bp,di	
	jno ok
	jmp z20
ok:	mov b,bp
	add c,1
         
jmp zyme 
         
ivp:     
;Reiskinio skaiciavimas
	mov ax,b
	mov bl,c
	idiv bl           
                          
;Duomenu isvedimas        
z50:    lea bx,r          
                          
	mov ah,0          
                          
  ;Sveikoji dalis         
	add bx,5          
   z3:	mov dx,0	;Skaidymas
	cmp ax,10         
	jl z4             
	div d	    	;/10
	add dl,30h        
	mov [bx],dl	;liekana issaugau
	dec bx            
	jmp z3            
   z4:	add al,30h	;paskutinis skaitmuo 
        mov [bx],al       
	cmp cl,1        ;ar neneigiamas
	jne z5            
	dec bx            
	mov dl,2dh        
	mov [bx],dl       
	mov ah,02	;'Rezultatas neigiamas'	
	mov bh,00         
	mov dh,16         
	mov dl,20         
	int 10h                   
	mov ah,09h                
	lea dx,rezn               
	int 21h           
	jmp z6            
   z5:	cmp si,0          
	je z6             
	mov ah,02	;'Rezultatas teigiamas'	
	mov bh,00         
	mov dh,16         
	mov dl,20         
	int 10h                   
	mov ah,09h                
	lea dx,rezt               
	int 21h            
   z6:	mov ah,02	;'Rezultatas:'
        mov bh,00          
	mov dh,14	;y 
	mov dl,20	;x 
	int 10h            
	lea dx,rez         
	mov ah,09          
	int 21h            
        mov ah,09h	;atspausdinam
	lea dx,r           
 	int 21h            
 	jmp z21            
   z20:	mov ah,02	;Perpildymas
        mov bh,00          
	mov dh,14	;y 
	mov dl,20	;x 
	int 10h            
	lea dx,over        
	mov ah,09          
	int 21h            
   z21:	mov ah, 07h	;Laukiu klaviso paspaudimo
	int 21h                
	mov ah,4ch	;Grizta i DOS
	int 21h           
                          
programa ends             
end start                 
