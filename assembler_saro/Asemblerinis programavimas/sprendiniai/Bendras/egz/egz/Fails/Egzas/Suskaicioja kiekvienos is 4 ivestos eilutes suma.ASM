stekas    segment stack
          db 256 dup(0)      
stekas    ends

cr        equ 13                                                     
lf        equ 10
n equ 5                                                              
m equ 6                                                        
nm equ 30
                                                                     
duomenys  segment
                             
	masyvas: db n DUP (m dup(0))

	pran      db 'Laboratorinis darbas Nr9',lf,cr
          db 'Uzduotis suskaiciuoti masyvo eilutes suma',10,13                           
          db 'Atliko: ',lf,cr
          db 'Donatas Baladinskas IIno2 ',lf,cr    
          db '',10,13,'$'
			                                             

        prn1 db 'Iveskite eilute ','$'
		prn2 db ': ','$'
		
		prn3 db 'Eilutes ','$'
		prn4 db ' suma:','$'

        tarpas db ' ','$'
	 	teig db ?,'$'
	     	neig db ?,'$'                                        
		desimt db 10,'$'
		tmp db ?,'$'
		tmp1 dw ?,'$'
		teigsum db 'teig kiekis yra: ','$'
		neigsum db 'neig kiekis yra: ','$'
		eilute db 10,13,'$'             
duomenys  ends                                  
                                                
                                                
programa  segment                               
          assume cs:programa, ds:duomenys, ss:stekas
                                                
                                                
                                                
start:                                          
;Duomenu inicializavimas                        
          mov ax, duomenys                      
          mov ds,ax                             
                                                
                                                
                                                
;Ekrano isvalymas                               
          mov ax,0002h                          
          int 10h                               
; Pranesimo isvedimas                           
        mov ah,09h                              
        lea dx,pran                             
        int 21h                                 
		mov bx,0 ;eilute                
		mov si,0 ; stulpelis            
                                                
                                                
	; Ivedam                                
     mov tmp1,30h                               
ivedimas:                                       
                                                
     mov ah,09h                                 
     lea dx,prn1                                
     int 21h                                    
                                                
     mov ah,09h                                 
     add tmp1,01h                               
     lea dx,tmp1                                
     int 21h                                    
                                                
     mov ah,09h                                 
     lea dx,prn2                                
     int 21h                                    
                                                
skivedimas:                                     
     mov ah,08h                                 
     int 21h                                    
     mov tmp,al                                 
     sub al,30h                                 
     mov byte PTR masyvas[bx][si],al            
                                                
     mov ah,09h                                 
     lea dx,tmp                                 
     int 21h                                    
                                                
	 mov ah,09h                             
     lea dx,tarpas                              
     int 21h                                    
	                                        
	 inc si                                 
	                                        
	 cmp si, m                              
	 jl skivedimas ;kol si maziau uz 6      
	                                        
	mov ah, 09h                             
	lea   	dx, eilute                      
	int 21h                                 
	                                        
	 add bx,m                               
	 mov si,0                               
	 cmp bx,nm                              
     	 jl ivedimas ; baigesi ivedimo ciklas   
                                                
     ;skaiciavimai                              
	                                        
		mov bx,0 ;eilute                
		mov si,0 ; stulpelis            
     mov tmp1,30h                                 
eil:                                            
                                                
     mov ah,09h                                 
     lea dx,prn3                                
     int 21h                                    
                                                
     mov ah,09h                                 
     add tmp1,01h                               
     lea dx,tmp1                                
     int 21h                                    
                                                
     mov ah,09h                                 
     lea dx,prn4                                
     int 21h                                    
                                                
	mov al,0  	; suma                  
                                                
	skaiciavimas:                           
	 add al,byte PTR  masyvas[bx][si]       
	 inc si                                 
	 cmp si, m                              
	 jl skaiciavimas ;kol si maziau uz 6    
	                                        
	cmp al,desimt                           
	 jl maziau	                        
	                                        
	       	mov ah,0                        
		div desimt
		push tmp1
		mov tmp1,ax                     
		mov tmp,al                      
		add tmp,30h                     
		lea dx,tmp                      
		mov al,0  		     	
		mov ah,09h                      
		int 21h                         
		mov ax,tmp1
		pop tmp1
		mov al,ah                       
	                                        
	maziau:                                 
		add al,30h                      
		mov tmp,al ;al liekana          
		lea dx,tmp		        
		mov ah,09h                      
		int 21h                         
		                                
	mov ah, 09h                             
	lea dx, eilute                          
	int 21h                                 
	                                        
	 mov si,0                               
	 add bx,m 
	 cmp bx,nm                               
     	 jl eil ; baigesi ivedimo ciklas        
                                                
                                                
        
	
;laukia klaviso paspaudimo
          mov ah, 07h
          int 21h  
                   
;grizhta i DOS     
          mov ah,4ch
          int 21h  
programa  ends     
          end start
