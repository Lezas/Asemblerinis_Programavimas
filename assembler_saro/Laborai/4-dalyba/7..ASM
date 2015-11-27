;       y=(2a+b)/c
                                                     
stekas segment stack                                                     
        db 256 dup (?)
stekas ends                                                              
                                                                         
eilg equ 10,13,'$'
                                                                         
duomenys segment                                                               
        pran1 db 'Agne Katkute II-2/1   Laboratorinis darbas Nr.4',10,13
              db 'Reiskinio (2a+b)/c, kai a=216, b=4 ir c=25',eilg
   	pran2 db 'sveikoji dalis - $'
	pran3 db 'liekana -$'
        pran4 db 'Programa baigta. Spauskite bet koki klavisa.$'
        a db 216
        b db 4
        c db 25
	sveikas db 2 dup (?),eilg
	liekana db 2 dup (?),eilg
        desimt db 10          
duomenys ends                 
                              
programa segment              
assume cs:programa, ds:duomenys, ss:stekas
start:                                                
        mov AX, duomenys      
        mov DS, AX            
        
        mov AX, 0002h     
        int 10h           
                           
        mov AH, 09h           
        lea DX, pran1     
        int 21h           
                     
        xor AX, AX
        mov AL, 2 
        Mul  a
        add AL, b
	div c
	mov liekana,ah
	mov sveikas,al     	
	
	mov SI, 2
	xor ax,ax
	mov al,liekana
	ciklas2:
                div desimt
                add AH, 30h
                mov liekana[SI], AH
                dec SI
                xor AH, AH
                cmp AL, 0                                                     
                je toliau
        loop ciklas2 
               
        toliau: 
	mov SI, 2
	xor ax,ax
	mov al,sveikas
       
        ciklas:       
                div desimt
                add AH, 30h
                mov sveikas[SI], AH
                dec SI
                xor AH, AH
                cmp AL, 0                                                     
                je pabaiga
        loop ciklas     

pabaiga:  
        mov AH, 02h
        mov BH, 00h       
        mov DH, 03
        mov DL, 01   
        int 10h 
                
        mov AH, 09h        
        lea DX, pran2     
        int 21h            
        lea DX, sveikas          
        int 21h 
         
        mov AH, 02h
        mov BH, 00h       
        mov DH, 05
        mov DL, 01   
        int 10h 
          
        mov AH, 09h        
        lea DX, pran3     
        int 21h            
        lea DX, liekana         
        int 21h         
        
        mov AH, 02h       
        mov BH, 00h       
        mov DH, 15
        mov DL, 01   
        int 10h           
                           
        mov AH, 09h       
        lea DX, pran4     
        int 21h                                                               
                           
        mov AH, 08h   
        int 21h            
       
        mov AH, 4Ch        
        int 21h            
programa ends              
end start