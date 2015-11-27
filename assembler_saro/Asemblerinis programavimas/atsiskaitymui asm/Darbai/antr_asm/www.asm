stckseg	SEGMENT PARA STACK 'STACK'

	db 300h dup (?)

stckseg	ENDS

data	SEGMENT WORD 'DATA'

help	db "",10,10,10
	db "        {^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^}",13,10
	db "        {        Programa daugina du sesioliktainius skaicius         }",13,10
	db "        {         pirmas iki 255 skaitmenu, antras [00h-FFh]          }",13,10
	db "        {                <naudoti didziasias raides>                  }",13,10
	db "        {   atliko            Eduard Novicenko             12 grupe   }",13,10
	db "         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ",13,10,'$'
pirm	db 10,10,'  Iveskite pirma skaiciu :  ','$'
antr	db 10,10,'  Iveskite antra skaiciu :  ','$'
rezultatas db 10,'  Rezultatas : ','$'
sk1max	db 255
sk1dyd	db  (?)
sk1skaic	db 256 dup (?)
sk2max	db 3
sk2dyd	db (?)
sk2skaic	db 4 dup (?)
kit_eil	db 13,10,'$'
lentele	db '0123456789ABCDEF'
blog	db '  Neteisingai ivestas(-ti) skaicius(-iai) ' ,13,10,'$'
x1_i	db (?)
ylast	db (?)
yfirst	db (?)
pirmas	db 260 dup (?)
antras	db 260 dup (?)	
desimt	db 10h
data	ENDS

code	SEGMENT WORD 'CODE'
	ASSUME cs:code, ds:data
begin:
	mov	ax, data
	mov	ds, ax

	cmp	byte ptr es:[81h], ' '
	jne	tol
	cmp	byte ptr es:[82h], '/'
	jne	tol
	cmp	byte ptr es:[83h], '?'
	jne	tol

	mov	ah, 9h					;printas
	mov	dx, offset help
	int	21h
	jmp	viskas

tol:	mov	ah, 9h					;printas
	mov	dx, offset pirm
	int	21h

	mov	ah, 0ah 			        ;read sk1
	mov	dx, offset sk1max
	int	21h

	mov	ah, 9h					;i kita eilute	
	mov	dx, offset kit_eil
	int	21h

	mov	ah, 9h					;printas
	mov	dx, offset antr
	int	21h

	mov	ah, 0ah					;read sk2
	mov	dx, offset sk2max
	int 21h

	mov	ah, 9h					;i kita eilute
	mov	dx, offset kit_eil
	int	21h

        xor     ax, ax
        mov     al, sk2dyd
        mov     di, ax					; di - antro dydis
        xor     cx, cx
        mov	cl, sk1dyd
	mov	bx, offset lentele
	xor	dx, dx
	mov	si, 01h

	dec	di			;antro skaiciaus paskutinis skaitmuo
	mov	dl, -1h			; i ylast
iesk:	inc	dl
	cmp	dl, 0fh
	jg	blog_sk_t
	mov	al, dl
	xlat
	cmp	al, [sk2skaic[di]]
	jne	iesk
	mov	ylast, dl

	cmp	di, 0h			; antro skaiciaus pirmas skaitmuo
	je	nulis			; i yfirst
	dec	di
	mov	dl, -1h
iesk1:	inc	dl
	cmp	dl, 0fh
	jg	blog_sk_t
	mov	al, dl
	xlat
	cmp	al, [sk2skaic[di]]
	jne	iesk1
	mov	yfirst, dl
	jmp	ppp

nulis: 	mov	yfirst, 0h	; jei antras skaicius is vieno skaitmens

ppp:	mov	di, cx
	xor	cx, cx
	
sk1:    dec	di
	mov	dl, -1h			;pirmojo skaiciaus i-tasis skaitmuo
					;i x1_i
iesk2:	inc	dl
	cmp	dl, 0fh
	jg	blog_sk_t
	mov	al, dl
	xlat
	cmp	al, [sk1skaic[di]]
	jne	iesk2

	mov	x1_i, dl     ;dauginam pirma skaiciu is ant. sk. pask. skait.
	mov	al, ylast    ; rezultata irasom i pirmas	
	mul	x1_i
	add	ax, cx
	div	desimt
	mov	cl, al
	mov	offset pirmas[si], ah
	inc	si
	cmp	di, 0h
	jg	sk1
		
	mov	offset pirmas[si], cl		; is atminties
	inc	si
	xor	cx, cx
	mov	offset pirmas[si], cl		;du nulius i pirmo prieki
	inc	si
	mov	offset pirmas[si], cl
	jmp	uuu
blog_sk_t:  jmp blog_sk

uuu:	mov	cl, sk1dyd	;antro sk. pir. sk. daugyba is pirmo sk.
	mov	si, 02h		; rezultatas i antras
	mov	di, cx
	xor	cx, cx
	xor	ax, ax
	xor	dx, dx
	
sk2:    dec	di
	mov	dl, -1h			;pirmojo skaiciaus i-tasis skaitmuo
					; i x1_i
iesk3:	inc	dl
	cmp	dl, 0fh
	jg	blog_sk
	mov	al, dl
	xlat
	cmp	al, [sk1skaic[di]]
	jne	iesk3

	mov	x1_i, dl
	mov	al, yfirst
	mul	x1_i
	add	ax, cx
	div	desimt
	mov	cl, al
	mov	offset antras[si], ah
	inc	si
	cmp	di, 0h
	jg	sk2
		
	mov	offset antras[si], cl
	mov	cl, 0h
	mov	di, 01h				
	mov	offset antras[di], cl		; antro gale padedam nuli	
	
	mov	di, 0h			; pirmas ir antras sudetis i steka
	xor	cx, cx			; pradzios pozimis x
	xor	ax, ax
	xor	dx, dx
	push	'x'
	inc	si
sudeti:	inc	di
	mov	al, offset antras[di]
	mov	dl, offset pirmas[di]	
	add	ax, dx
	add	ax, cx
	div	desimt
	mov	cl, al
	mov	al, ah
	mov	ah, 0h
	push	ax
	cmp	si, di
	jg	sudeti
	push	cx
	xor	ax, ax
	xor	cx, cx
	mov	si, 0h
	jmp	rrr

blog_sk: mov	ah, 09h
	mov	dx, offset blog
	int	21h
	jmp	tol

rrr:	mov	ah, 9h			; i kita eilute
	mov	dx, offset kit_eil
	int	21h
	
	mov	dx, offset rezultatas		;printas
	int	21h	
	
dar:	pop	cx		;ismetame nulius
	cmp	cx, 0h
	je	dar
	push	cx

spauzd:				;is steko perkoduojam ir spauzdinam
	pop	ax
	cmp	ax, 'x'
	je	pab
	xlat
	mov	dl, al
	mov	ah, 02h
	int	21h
	inc	si
	jmp	spauzd

pab:				; jei vienas is skaiciu lygus 0
	cmp	si, 0h		; isspauzdinam 0
	jne	viskas
	mov	dl, '0'
	mov	ah, 02h
	int	21h

viskas:	mov	ah, 0h					;readln
	int	16h

	mov	ax, 4C00h				;grizti i dosa
	int 21h

code	ENDS

	end	begin
