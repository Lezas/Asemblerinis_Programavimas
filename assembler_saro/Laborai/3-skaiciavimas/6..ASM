stekas segment stack                                                     
        db 265 dup (?)                                                   
stekas ends                                                              
                                                                         
eilg equ 10,13,'$'
                                                                         
duomenys segment                                                               
        pran1 db 'Agne Katkute II-2/1   Laboratorinis darbas Nr.5',10,13
              db 'y=(a+b-c)*2, kai a=-5, b=3, c=6',eilg
   	pran2 db 'y=$'
	pran3 db 'y=0$'
	pran4 db 'y<0$'
	pran6 db 'y>0$'
        pran5 db 'Programa baigta. Spauskite bet koki klavisa.$'
        a db -5
        b db 3
        c db 6
	du db 2 
	y db 3 dup(?) ,eilg      
          desimt db 10          
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
                     
        ;..skaiciuojame reiskini (a+b-c)*2
        xor AX, AX
        mov AL, a 
        add AL, b
        sub AL, c
	mul du
	mov BH, Al

	mov SI, 1
	desimtaine:   ;verciam atsakyma i desimtaini
        	div desimt
	        add AH, 30h
        	mov y[SI], AH
	        dec SI
	        xor AH, AH	
	        cmp AL, 0
	        je lyginimas
	loop desimtaine  
	
lyginimas:
	
        cmp BH, 0
	JE lygu
      	JL maziau                 
      	JG daugiau
lygu:
        mov AH, 09h        
        lea DX, pran3     
        int 21h 
	jmp exit           
maziau:
   	mov AH, 09h        
        lea DX, pran4  
        int 21h    
        jmp exit
daugiau:
        mov ah, 09h
        lea dx, pran6
        int 21h
        jmp exit
exit:
        mov AH, 02h       
        mov BH, 00h       
        mov DH, 08
        mov DL, 01 
        int 10h           
                           
        mov AH, 09h       
        lea DX, pran5     
        int 21h                                                               
                           
        mov AH, 08h   
        int 21h   
         
        mov AH, 4Ch        
        int 21h            
programa ends              
end start