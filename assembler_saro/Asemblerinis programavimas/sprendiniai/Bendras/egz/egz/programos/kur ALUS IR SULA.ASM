;       teksto rasymas atbulai
                                                     
stekas segment stack                                                     
        db 265 dup (?)                                                   
stekas ends                                                              
                                                                         
eol equ 10,13,'$'
                                                                         
duomenys segment                                                               
        pran1 db '------------------------------------------------------',10,13
              db 'Donatas Malinauskas II-2/1   Laboratorinis darbas Nr.6',10,13
              db '------------------------------------------------------',10,13
              db ' Pradinis tekstas ',eol
   	pran2 db ' sula',eol
   	pran3 db 4 dup(?), eol
	pran5 db 'po pakeitimo',eol
        pran4 db 'Programa baigta. Spauskite bet koki klavisa.$'
        
duomenys ends                 
                              
programa segment              
assume cs:programa, ds:duomenys, ss:stekas
start:                                                
        mov AX, duomenys      
        mov DS, AX            
        
        ;..nuvalome ekrana    
        mov AX, 0002h     
        int 10h 
          
        ;..isvedame pavarde                                             
        mov AH, 09h           
        lea DX, pran1     
        int 21h 
	
	        
                     
        mov di, offset pran2
	mov bx, offset pran3+5

	xor AX, AX
	mov cx, 13

ciklas:
	mov ax, [di]
	add di, 2
	mov [bx], al
	dec bx
	mov [bx], ah
	dec bx
loop ciklas 
	

	mov ah, 09h
	lea dx, pran2
	int 21h                                 
  	
  	mov ah, 02h
  	mov bh, 00h
  	mov dh, 05
  	mov dl, 01
  	int 10h
  	
        mov ah, 09h
	lea dx, pran5
	int 21h  
	
	
	mov ah, 02h
	mov bh, 00h
	mov dh, 05
	mov dl, 01
	int 10h
	
	mov ah, 09h
	lea dx, pran3
	int 21h


        mov AH, 02h       
        mov BH, 00h       
        mov DH, 08
        mov DL, 01   ;perkeliame kursoriu i 6 eilute 
        int 10h           
                           
        mov AH, 09h       
        lea DX, pran4
        int 21h                                                               
                           
        mov AH, 08h   ;laukiame enter     
        int 21h            
        ;..griztame i DOS'a
        mov AH, 4Ch        
        int 21h            
programa ends              
end start