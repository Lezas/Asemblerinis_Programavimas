;Steko segmentas
stekas segment stack
	db 256 dup(?)
stekas ends
         
cr equ 13
lf equ 10
         
;Duomenu segmentas
duomenys segment     
	pran1    db 'Atliko: Giedrius Karaliunas, II-2/3gr', cr, lf, '$'
        i       dw 6                                        
        j       dw 5
	pran2    db 'Matrica: ', cr, lf, '$'
	pran3   db 'Pakeista matrica: ', cr, lf, '$'
	pab     db 'Spauskite bet kuri mygtuka...', cr, lf, '$'
        matrica db 1,0,2,2,0,1
                db 0,5,3,0,4,2
                db 5,0,1,0,2,1
                db 1,0,1,1,0,2
                db 0,3,0,5,0,1        
         eil    db lf, cr, '$'       
         des    dw 10
duomenys ends   
;Programos segmetas                                            
programa segment                               
       assume CS:programa, DS:duomenys, SS:stekas 
       start: mov AX, duomenys                    
              mov DS, AX  
;Ekrano nuvalymas
 	mov ax, 0002h
	int 10h                           
;Kursoriaus nustatymas
	mov AH, 02
	mov BH, 00h
	mov DH, 00h
	mov DL, 00h
	int 10h
         
        mov ah, 09h 
	lea DX, pran1
	int 21h   
         
	call eil_isv
        mov ah, 09h  
	lea DX, pran2
	int 21h
         
        call mat_isv
         
;---Keitimas 0 i 255---
        mov CX, j
        lea BX, matrica
        ciklas_j:           ;eiluciu keitimo ciklas
                   push CX
                   add BX, 0
                   mov CX, i
                   sub CX, 0
                   ciklas_i:              ;stulpeliu keitimo ciklas
                              xor AH, AH
                              mov AL, [BX]
                              cmp AX, 0
                              jnz ne0
                              mov AL, 255
                              mov [BX], AL
                           ne0:   
                               inc BX
                   loop ciklas_i
                pop CX
        loop ciklas_j
        
        call eil_isv
        mov ah, 09h
	lea DX, pran3
	int 21h

        call mat_isv
        
;---Kursoriaus nustatymas---                          
	mov AH, 02                                   
	mov BH, 00h                                   
	mov DH, 15h                                   
	mov DL, 00h                               
	int 10h   

;---Pabaiga---
	mov ah, 09h
	lea DX, pab
	int 21h

;---Isejimas i DOS---
	mov AH, 07h                     
     	int 21h                               
        mov AH, 4Ch                                                         
        int 21h   
        
;---Matricos isvedimas---
mat_isv:  
       	push AX
       	push BX
       	push CX
       	mov CX, j
       	lea BX, matrica
       	xor AX, AX

       	is_ciklas_j:
               	    push CX
                    mov CX, i
 
               	    is_ciklas_i:
                       		mov AL, [BX]
	                       	call sk_isv
	                       	call tarp_isv      ;tarpeliai tarp skaiciu
	                       	inc BX
       	       	    loop is_ciklas_i

               	    call eil_isv
               	    pop CX
     	loop is_ciklas_j

       	pop CX
       	pop BX
       	pop AX
ret      
         
;---Skaiciu isvedimas--- 
sk_isv:
        push AX
        push CX
        push DX
        mov CX, 0
        sk_isv_1:
                     xor DX, DX
                     div des
                     add DX, 30h
                     push DX
                     inc CX
                     cmp AX, 0
        jnz sk_isv_1

        mov AH, 02h
        sk_isv_2:
                     pop DX
                     int 21h
        loop sk_isv_2

        pop DX
        pop CX
        pop AX
ret      
         
;---Isveda tarpeli---
tarp_isv:
        push AX
        push DX
        mov AH, 02h
        mov DL, ' '
        int 21h
        pop DX
        pop AX
ret      
 
;---Nukelia i kita eilute---     
eil_isv:              
        push AX   
        push DX    
        mov AH, 09h 
        lea DX, eil
        int 21h
        pop DX
        pop AX
ret           
programa ends
	end start           
 