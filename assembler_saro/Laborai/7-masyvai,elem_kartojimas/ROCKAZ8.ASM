SSEG SEGMENT STACK     
db 256 dup (?)              
ENDS SSEG                   
                           
DSEG SEGMENT         
        _10 dw 10        
        _10_b db 10        
        ind dw 68
        tmp dw 0
	count db 0                                                           
	pirmas db 0                                                          
       	pirmo_ind db 0                                                       
        rez db 	'Eiluciu skaicius, kuriose kartojasi pirmas eilutes elementas, yra:   ', 10, 13, '$'
  
;mas db 0,1,2,3,4,0,6,7,8,9 ;YRA
;    db 1,2,3,4,5,6,7,8,9,1 ;YRA
;    db 1,3,4,5,6,7,8,9,0,1 ;YRA                                                  
;    db 1,4,5,6,7,8,9,0,1,3 ;YRA                                              
;    db 1,5,6,7,8,9,0,1,2,3 ;YRA                                                  
;    db 1,6,7,8,9,0,1,2,3,4 ;YRA                                                   
;    db 1,7,8,9,0,1,2,3,4,5 ;YRA                                              
;    db 1,8,9,7,1,2,3,4,5,6 ;YRA                                              
;    db 1,9,0,1,2,3,4,5,6,7 ;YRA                                                  
;    db 1,0,1,2,3,4,5,6,7,8 ;YRA                                                  
                                                                             
mas db 0,1,2,3,4,0,6,7,8,9 ;YRA                                             
    db 1,2,3,4,5,6,7,8,9,0
    db 2,3,4,5,6,7,8,9,0,1                                                  
    db 3,4,5,6,7,8,9,0,1,3 ;YRA
    db 4,5,6,7,8,9,0,1,2,3                                                  
    db 5,6,7,8,9,0,1,2,3,4
    db 6,7,8,9,0,6,2,3,4,5 ;YRA                                             
    db 7,8,9,7,1,2,3,4,5,6 ;YRA
    db 8,9,0,1,2,3,4,5,6,7                                                  
    db 9,0,1,2,3,4,5,6,7,8
    
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
                   
print_msg proc                                                                         
	lea dx, rez
        mov ah, 09h    
        int 21h                           
        ret                               
print_msg endp     
                   
prep_result proc        
rasom:                  
        div _10_b  
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
	mov cx, 10                        
ciklas_1:                                 
        ; Pasiimam pirma elementa         
        mov ax, 10     
        sub ax, cx     
        mul _10        
                       
        ; di registre bus eilutes numeris 
        mov di, ax                            
        mov dl, mas[di]
        ; Irasom pirmo skaiciaus reiksme i "pirmas"
        mov pirmas, dl
        ; Pradedam skaiciuoti nuo ANTRO elemento
        mov bx, 1                               
        ciklas_2:                                  
                ; Paskaiciuojam kelinta elementa ziuresim -> si
                mov si, di                         
                add si, bx                         
                ; Pasiimam elemento reiksme        
                mov dl, mas[si]                    
                ; Palyginam su pirma reiksme       
                cmp dl, pirmas                  
                                                
                jne continue_ciklas_2              
                inc count                       
                                                
                jmp end_ciklas_2                   
        continue_ciklas_2:                         
                inc bx                             
                cmp bx, 10                         
                je end_ciklas_2                    
                jl ciklas_2                        
        end_ciklas_2:                              
loop ciklas_1
        mov ax, 0    
        mov al, count
	call prep_result
        call print_msg
pabaiga:                                        
 	mov ah, 4Ch                             
	int 21h                                 
ENDS CSEG                                       
END START                                 