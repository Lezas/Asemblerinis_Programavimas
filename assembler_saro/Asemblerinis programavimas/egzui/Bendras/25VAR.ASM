stek segment stack                                                           
	db 256 dup(?)                                                        
stek ends                                                                    
                                                                             
duom segment                                                                 
	des db 10                                                            
	temp db ?                                                            
	 db 'tmp:'                                                           
	tmp db 10 dup (0)                                                    
	 db '$'                                                              
	PranI  db 10,13,'Iveskite '                                          
	ka db ?,':$'                                                         
	a dw ?                                                               
	s dw 100                                                             
	b dw ?                                                               
	daliklis db 10                                                       
	pranAtsakymas db 10,13, 'Atsakymas c= $'                             
	c dw ?                                                               
	tusc  db 10,13,'$'                                                   
	l db ?                                                               
	pranf1 db 'Funkcija c=((a+b)*100)/b', 13, 10, '$'                    
	autorius db 13, 10, 'Arturas Radzivanas, II-0/2', 13, 10, '$'        
duom ends                                                                    
                                                                             
progr segment                                                                
	assume cs:progr,ds:duom,ss:stek                                      
start:                                                                       
       	mov ax, duom                                                         
       	mov ds, ax                                                                    
                                                                             
;Isvalomas ekranas                                                                             
                                                                             
	mov ax, 0600h                                                        
	mov bh, 07                                                           
	mov cx, 0000h                                                        
	mov dx, 184Fh                                                        
	int 10h                                                              
                                                                               
;Nustatoma kursoriaus padetis                                                                             
  	mov ax, 0200h                                                        
	mov bh, 00h                                                          
	mov dx, 0000h                                                        
	int 10h                                                              
                                                                             
;I ekrana isvedamas darbo autorius                                                                           
	mov ah, 09h                                                          
      	lea dx, autorius                                                     
       	int 21h                                                              
	                                                                     
;Isedamos reiksmes	                                                                     
        mov bx, 0                                                                                                    
        mov ka, 'a'                                                          
        call ivedimas                                                        
        mov a, ax                                                            
                                                                             
        mov ka, 'b'                                                          
        call ivedimas                                                        
        mov b, ax                                                            
                                                                                                              
;Tuscios eilutes spaudinimas                                                                          
  	mov ah, 09h                                                          
	lea dx, tusc                                                         
	int 21h                                                              
                                                                             
                                                                             
;Skaiciuojama funkcijos reiksme                                                                             
                                                                             
	mov ah, 09h                                                          
	lea dx, pranf1                                                       
	int 21h                                                              
        mov dx, 0                                                            
        mov Ax, a                                                            
        add Ax, b                                                            
        mul s                                                                
        mov c, AX                                                            
                                                                             
        div b                                                                
        mov c,AX                                                             
                                                                             
                                                                             
i_pabaiga:                                                                   
        mov c, ax                                                            
        mov l, ah                                                            
        call isvedimas                                                       
        mov ah, 09h                                                          
        lea dx, pranAtsakymas                                                
        int 21h                                                              
        lea dx, tmp                                                          
        add dx, 3                                                            
        int 21h                                                              
   	jmp galas                                                            
                                                                             
                                                                             
galas:                                                                       
        mov ah, 4ch                                                          
       	int 21h                                                              
                                                                             
;Procedura                                                                   
ivedimas proc near                                                           
 	mov si, 0                                                            
	mov ah, 09h                                                          
;Isvedimas i ekrana                                                                             
	lea dx, PranI                                                        
	int 21h                                                              
pradzia:                                                                     
        mov ah, 08h                                                          
	int 21h                                                              
        cmp al, 13                                                           
	je pabaiga                                                           
	cmp al, 30h                                                          
	jb pradzia                                                           
	cmp al, 39h                                                          
	ja pradzia                                                           
                                                                             
;Ivestu duomenu atspausdinimas ekrane                                                          
       	mov dl, al                                                           
	mov ah, 02h                                                          
	int 21h                                                              
                                                                             
	sub al, 30h                                                          
	mov tmp[si], al                                                      
	inc si                                                               
	jmp pradzia                                                          
pabaiga:                                                                     
        mov cx, si                                                           
        sub cx, 1                                                            
        mov al, tmp[0]                                                       
        mov dx, 00h                                                          
        mov bx, 00h                                                          
        mov ah, 00h                                                          
        mov si, 00h                                                          
        cmp cx, 0                                                            
        je endas                                                             
;Is skaitmenu kuriamas skaicius                                                                            
ciklas:                                                                      
        mul des                                                              
        mov bl, tmp[si+1]                                                    
        add al, bl                                                           
        inc si                                                               
	loop ciklas                                                          
endas:                                                                       
ret                                                                          
ivedimas endp             	                                             
                                                                             
isvedimas proc near                                                          
        mov si, 9                                                            
        mov ax, c                                                            
ciklas_2:                                                                    
        mov ah, 0                                                            
        div des                                                              
        mov tmp[si-4], ah                                                    
        add tmp[si-4], 30h                                                   
        dec si                                                               
        mov ah, 0                                                                                              
        cmp ah, al                                                           
jb ciklas_2                                                                  
        mov al, l                                                            
        mov si, 7                                                            
        mov cx, 3                                                            
        mov tmp[6], 2Eh                                                      
ciklas_3:                                                                    
        mul des                                                              
        div daliklis                                                         
        add al, 30h                                                          
        mov tmp[si], al                                                      
        mov al, ah                                                           
        inc si                                                               
loop ciklas_3                                                                
ret                                                                          
isvedimas endp                                                               
                                                                             
progr ends                                                                   
	end start       