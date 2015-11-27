SSEG SEGMENT STACK  
db 256 dup (?)              
ENDS SSEG                   
                           
DSEG SEGMENT     
        ind dw 0
	_2 db 2                             
        msg1 db 'Iveskite savo varda ir pavarde (max 40 simb.) ir spauskite [ENTER]', 10, 13, '$'
        msg2 db 'Noredami baigti, spauskite [ESC]', 10, 13,'$'
	rez db '                                         $'
        count db 0 
ENDS DSEG                         
                                  
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG  
                                  
doinit proc                       
        mov ax, DSEG                     
        mov ds, ax                                 
	mov ax, 0002h             
        int 10h                          	
        ret                       
doinit endp                       
                   
clr_screen proc    
	mov ah, 02h
	int 10h    
        mov ah, 2  
        mov bh, 0                 
        mov dx, 0                  
        int 10h	         
	ret         
clr_screen endp    
                     
print_msgs proc                                                                         
	lea dx, msg1
        mov ah, 09h   
        int 21h                   
	lea dx, msg2
        mov ah, 09h   
        int 21h                   
        ret                       
print_msgs endp                         
                                     
goto_middle_line proc                    
        mov ah, 2              
        mov bh, 0                 
        mov dh, 12
        int 10h        
        ret                        
goto_middle_line endp                    
                                     
read_byte proc                            
        mov ah, 08h    
        int 21h                      
        ret                          
read_byte endp          
                                                    
START:                 
        call doinit    
ciklas_1:              
	call clr_screen
	call print_msgs
        ; Perskaitom simboli      
	call read_byte            
	; Jei ESC - iseinam       
	cmp al, 27     
	je pabaiga   
	; Jei nebetelpa - neberasom
        cmp count, 40 
      	jne hop_1   
      	cmp al, 8
      	jne ciklas_1
hop_1:	         
	; Jei nera nieko parasyta, negalime trinti
	cmp count, 0                              
	je continue
        ; Jei paspaude BACKSPACE, elgiames atatinkamai ;)        
        cmp al, 8                                        
        jne continue                                     
        mov si, ind                                      
        mov rez[si], 32                                  
        dec ind                                          
        dec count                                        
        jmp skip_append                                  
continue:                                                
	; Padidinam simboliu skaitliuka                  
	inc count      
	inc ind
   	; Irasom simboli i stringa 
        mov si, ind                
        mov rez[si], al
skip_append:        
	; Paskaiciuojam nuo kurios vietos viska rasysim
	mov ax, 0      
	mov al, count  
	div _2         
	mov bl, 40     
	sub bl, al     
	; Pereinam i atitinkama vieta ekrane
	mov dl, bl  
	call goto_middle_line
	; Isvedam stringa
        mov ah, 09h                     
        lea dx, rez                     
        int 21h     
        jmp ciklas_1  	
pabaiga:                
;	mov ah, 02h
; 	int 10h   
        ; bye
 	mov ah, 4Ch               
	int 21h                           
ENDS CSEG                                 
END START                                 
