stekas segment stack                               
        db 256 dup(?)                              
stekas ends                                        
                                                   
duomenys segment                                         

mas		db	1,2,3
szLine		equ	$-mas
		db	1,2,3
		db	1,2,3
pran		db	13,10,'suma=$'
summa		db	szLine dup(?)

duomenys ends                                                                      
                                                                                            
programa segment
assume cs:programa, ds:duomenys, ss:stekas
                                                                                           
;Pradzia                                                                                    
START:                                                                                      
        mov ax,duomenys                                                                     
        mov ds,ax                                                                 	
        	mov	ax,0002
		int	10h
		cld			;CLD komanda reiskia Clear Direction Flag, t.y. DF = 0.
		mov	cx,szLine
		lea	si,mas
;pirmasis ciklas eilutems
ciklas_1:	push	cx
		lea	di,summa
		mov	cx,szLine
;antrasis ciklas eilutei
ciklas_2:	;lodsb
		mov al, [si]	
		inc si
;skaichiuojam suma stulpeliuose
		add	[di],al
		inc	di
		xor	ah,ah
;ishvedam rez
		call	outDecimal
		loop	ciklas_2
;pereinam i kt. eilute
		call	outNext
		pop	cx
		loop	ciklas_1
;skaichiuojam bendra suma
		mov	cx,szLine
		lea	si,summa
		xor	dx,dx
;ciklas bendrai sumai
ciclas_3:	;lodsb
		mov al, [si]	
		inc si
		xor	ah,ah
		add	dx,ax
;ir ishkarto isvedam stulpelio suma
		call	outDecimal
		loop	ciclas_3
;isvedam praneshima
		push	dx
		mov	ah,09
		lea	dx,pran
		int	21h
		pop	dx
;bendros sumos isvedimas
       	mov	ax,dx
	call	outDecimal
;ekrano uzlaikymas        
mov ah,07h 
int 21h 
;isejimas
		mov	ah,4ch
		int	21h  
;perejimas i nauja eilute
OutNext:	mov	al,13
		int	29h
		mov	al,10
		int	29h
		ret
;skaichiaus isvedimas desimtaineje formoje
outDecimal:	push	dx
		push	cx
		push	ax
;pradinis tarpas

		mov	al,' '
		int	29h
		pop	ax
;skaichiuojam deshimt. sk. kieki
		xor	cx,cx
		mov	bx,10
;dalinam ir liekana issaugom steke
outA:		xor	dx,dx
		div	bx
		push	dx
		inc	cx
		or	ax,ax
		jnz	outA
;cikle isvedam skaichius is steko
outB:		pop	ax
		or	al,30h
		int	29h
		loop	outB

;griztam
		pop	cx
		pop	dx
		ret


jmp Pabaig1

;Pabaiga                                           
Pabaig1: mov ah,4ch                            
         int 21h                                    
                                                   
programa ends
end START   