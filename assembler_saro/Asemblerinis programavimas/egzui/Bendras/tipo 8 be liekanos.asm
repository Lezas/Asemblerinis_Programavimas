stekas segment stack                               
        db 256 dup(?)                              
stekas ends                                        
                                                   
duomenys segment                                         
nl equ 10,13

A  equ 2
B  equ 5

ivestas1 db ?,'$'
vidurkis  db 13,10,'Vidurkis=$'
masyvas db A*B dup(?)

klaida 	db 13,10,'KLAIDA! Skaicius per didelis. Turi buti 2-zenklis',13,10
	db 'Prasau ivesti is naujo:',13,10,'$'


        info_v  db 'I uzduotis:',10,13                                                                
                db 'Programa praso ivesti matricos elementus',nl       
                db 'Ir paskaiciuoja visu elementu vidurki (i ekrana isveda tik sveikaja dali',nl
               	db 10,10,10,10,10,13,'$'
        pauze   db 'Noredami testi spauskite bet koki klavisa...$'
	mat	db 'Ivedinekite matricos elementus po viena. Skaicius turi buti 2-zenklis', nl,'$'
duomenys ends                                                                      
                                                                                            
kursinis segment                                                                            
assume cs:kursinis, ds:duomenys, ss:stekas                                                  
                                                                                           
;Pradzia                                                                                    
START:                                                                                      
        mov ax,duomenys                                                                     
        mov ds,ax                                                                           
mov ax,0002h                                                                        
        int 10h                                                                             
                                                                                            

 mov ax,0002h                                      
        int 10h                                           
        mov ah,09h                                        
        lea dx,info_v                                     
        int 21h  
                                         
        mov ah,09h                                        
        lea dx,pauze                                      
        int 21h  
                                         
        mov ah,07h                                        
        int 21h                                           

mov ax,0002h                                                                        
int 10h
        mov ah,09h                                        
        lea dx,mat                                    
        int 21h 
  mov cx,A*B
  lea di,masyvas
  cld				;CLD komanda reiskia Clear Direction Flag, t.y. DF = 0.
;vieno sk. ivedimas
sk1_ivedimas: 
	push cx		;issaugom cx steke
  	xor dx,dx	;nuvalomas dx (dx=0) ;veikia greiciau negu "MOV op, 0"ir "SUB AX, AX"
  	mov [di],dx	;di adresu esancia reiksme permetame i dx
  	mov al,':'
  	int 29h		;veikia greiciau nei int 21h
;ivedam sk.
ivest_sk: 
	mov ah,07h
  	int 21h
;==================================================
  	cmp al,13
  	jz ived_stop
;tikrinam ivesta sk., tik nuo 0 iki 9. Visa kita ignoruojam.
  	cmp al,'0'
  	jl ivest_sk
  	cmp al,'9'
  	jg ivest_sk
;isvedam sk.
  	push ax
  	int 29h
;formuojam skaitmeni
  mov ax,[di]			;i ax permetame reiksme esancia adresu di
  mov bx,10
  mul bx
  pop bx
  cmp ax,99
  jg ivedimo_klaida		;jei ivestas sk. didesnis spausdinam praneshima apie klaida
  and bx,0fh			;0fh-pirmasis registras
  add ax,bx
  mov [di],ax
  jmp ivest_sk
;pranesimo apie klaida isvedimas
ivedimo_klaida: 
	mov ah,9
  	lea dx,klaida
  	int 21h
;ivedimas is naujo
  	pop cx
  	jmp sk1_ivedimas
;irasom sk.
ived_stop: 
	inc di			;padidinamas di ,t.y. poslinkis
  	pop cx
;pereinam i kt. eilute
 	call kita_eilute
;ciklas skaiciu ivedimui
  	loop sk1_ivedimas
  	call kita_eilute
;matricos isvedimas
  	call matrica
;perejimas i kt. eilute 
  mov ah,9
  lea dx,vidurkis
  int 21h
;visu elementu suma
  mov cx,A
  lea si,masyvas
  xor dx,dx
  xor ax,ax
skaiciuojam_1_eilute:
	push cx
	mov cx,B
skaiciuojam_2_eilute: 
	;lodsb
	mov al, [si]	
	inc si
	add dx,ax
loop skaiciuojam_2_eilute
  pop cx
  loop skaiciuojam_1_eilute
;skaiciuojam vidurkio sveikaja dali
  mov ax,dx
  mov bx,A*B
  xor dx,dx
  div bx
  mov dx,ax
;dx-vidurkis
  push dx
  call des
  call kita_eilute
  pop dx

;ekrano uzlaikymas        
mov ah,07h      
int 21h 
;============================================
  pop bx
  push bx
  pop bx
  mov ah,4ch			;programos baigimas
 int 21h
;ciklas matricos isvedimui
matrica: 
	mov cx,A
  	lea si,masyvas
;eiluciu isvedimas
eilutes_1_isvedimas: 
	push cx
  	mov cx,B
;stulpeliu isvedimas
eilutes_2_isvedimas: 
	push cx
  	;lodsb
	mov al, [si]	
	inc si
  	and ax,0ffh		;Kadangi galime gauti skaiciu, kuris netelpa i 16 bitu tai, tai kas bus 							;virsaus bus irasyta i aX ;Asembleris gali apdoroti simbolius tik is 								;diapazono 20H – 0FFH (255)
;lygiavimas
  	cmp ax,9
  	jg lygiavimas
  	push ax
  	mov al,' '
  	int 29h
  	pop ax
;====================================
lygiavimas: 
	call des
  	mov al,' '
  	int 29h
;sekantis stulpelis
  	pop cx
  	loop eilutes_2_isvedimas
  	call kita_eilute
;sekanti eilute
  	pop cx
  	loop eilutes_1_isvedimas
  	ret 
;perejimas i kt. eilute
kita_eilute: 
	mov al,13
  	int 29h
  	mov al,10	
	int 29h
  	ret 
;isvedimas desimtainej formoj
des: 
	xor cx,cx
  	mov bx,10
des_dalyba: 
	xor dx,dx
  	div bx
  	or dx,30h	;dalybos liekana
  	push dx		;issaugom steke
  	inc cx		;skaiciuojam skaitmenu skaiciu
  	or ax,ax	;dalinam kol bus 0
  	jnz des_dalyba
d:
	pop ax		;istraukiam is steko
  	int 29h		;ir isvedam skaitmenu skaiciu

loop d
ret
        jmp Pabaig1 

;Pabaiga                                           
Pabaig1: mov ah,4ch                            
         int 21h                                    
                                                   
kursinis ends                                      
end START                                          
 