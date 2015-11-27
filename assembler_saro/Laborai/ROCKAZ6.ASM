SSEG SEGMENT STACK  
db 256 dup (?)              
ENDS SSEG                   
                           
DSEG SEGMENT     
        ind dw 28
        _10 db 10                             
        rez db 'Ivestu skaitmenu suma yra:   .$'
        msg1 db 'Iveskite po viena skaicius, ir spauskite [ENTER]', 10, 13, '$'
        msg2 db 'Noredami baigti, spauskite [ESC]', 10, 13,'$'
        sum db 0                  
        count db 0                
ENDS DSEG                         
                                  
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG  
                                  
doinit proc                       
        mov ax, DSEG                     
        mov ds, ax                                 
	mov ax, 0002h             
        int 10h                          	
        mov sum, 0
        ret                       
doinit endp                       
                                  
print_msg1 proc                                                                         
        mov ah, 09h   
        lea dx, msg1              
        int 21h                   
        ret                       
print_msg1 endp                         
                                                    
print_msg2 proc                                                                         
        mov ah, 09h                  
        lea dx, msg2                 
        int 21h                      
        ret                          
print_msg2 endp                      
                                     
goto_line proc                    
        mov ah, 2                 
        mov bh, 0                 
        mov dl, 0                 
        int 10h 
        ret     
goto_line endp                    
                                     
read_byte proc                            
        mov ah, 08h
        int 21h                      
        ret                          
read_byte endp          
                      
prep_result proc        
rasom:                  
        div _10         
        add ah, 30h     
        mov si, ind     
        mov rez[si], ah 
        xor ah, ah      
        dec ind         
        cmp al, 0       
        jne rasom
        ret
prep_result endp        
                        
                                                    
START:                                           
        call doinit                              
      	call print_msg1           
      	call print_msg2      	  
      	mov dx, 0                 
      	mov ax, 0                 
ciklas_1:      	                  
        mov dh, 3
        call goto_line            
        ; Perskaitom simboli      
	call read_byte            
	; Jei ESC - iseinam       
	cmp al, 27                
	je pabaiga                
	; Jei maziau nei ASCII '0' - kartojam
	cmp al, 48                           
	jl ciklas_1                          
	; Jei daugiau nei ASCII '9' - kartojam	
	cmp al, 57                
	jg ciklas_1
	; Keiciam is ASCII i skaiciu
	sub al, 48
	; Pridedam prie bendros sumos
 	add sum, al
 	; Atstatom i ASCII 
 	add al, 48 	          
    	; Parasom ka ivedem       
	mov ah, 02
 	mov dl, al
 	int 21h   
        jmp ciklas_1	
pabaiga:                
        ; Imetam suma i AX
        mov ah, 0       
        mov al, sum     
        ; Suformuojam rezultata
        call prep_result
        ; Parasom suma i reikiama eilute
        mov dh, 4
        call goto_line  
        mov ah, 09h                     
        lea dx, rez                     
        int 21h         
        ; Tipo press any key...
;        call read_byte         
        ; bye           
 	mov ah, 4Ch               
	int 21h                           
ENDS CSEG                                 
END START                                 
