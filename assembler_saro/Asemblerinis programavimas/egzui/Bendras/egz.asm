stk segment stack
	db 256 dup(?)
stk ends

data segment

	charac db ?, '$'
	nl db 10, 13, '$'
	dig db 0, "$"
	inda dw 0, "$"
	indb dw 0, "$"
	rez db 10 dup(?), "$"
	rez1 db 10 dup(?), "$"
	rezas db 10 dup(?), "$"
	inputA db 4, 0, 4 dup(?)
	inputB db 4, 0, 4 dup(?)
	sa db 0, "$"
	sb db 0, "$"
	ats dw 0, "$"
	dal dw 0, "$"
	dal1 dw 0, "$"
	sk1 dw 0, "$"
	msg1 db 10, 13, "Prasome ivesti 1ma skaiciu:", 10, 13, "$"
	msg2 db 10, 10, 13, "Prasome ivesti 2a skaiciu:", 10, 13, "$" 
	msg3 db 10, 10, 13, "Bilieto Nr. 25, uzduoti atliko Laurynas Kiskys, FMu-2 $"
	msg4 db 10, 10, 13, "skaicius su zenklu $"
	
	
data ends

main segment
start:
	assume cs:main, ds:data, ss:stk

	mov ax, data
	mov ds, ax

	mov ax, 0002h
	int 10h

	;=================skaicius A
	mov ah, 09h
	lea dx, msg1		
	int 21h

	mov ah, 0Ah
	lea dx, inputA
	int 21h

	;=================skaicius B
	mov ah, 09h
	lea dx, msg2		
	int 21h

	mov ah, 0Ah
	lea dx, inputB
	int 21h

	xor ax, ax
	xor dx, dx
	mov al, inputA[2]
	
	cmp al, "-"
	je zenklas

	mov ah, 09h
	lea dx, nl
	int 21h		

	;#######################skaicius a su zenklu
	
	zenklas:
	xor ax, ax
	mov ah, 09h
	lea dx, nl
	int 21h		

	xor cx, cx
	mov cl, inputA[1]
	add cx, 1
	mov SI, 3
	

	sk:
	xor dx, dx
	mov al, inputA[si]
	
	push si
	sub si, 3
	mov rez[si], al
	sub rez[si], 30h
	mov inda, si
	pop si
	
	inc SI
	
	loop sk


	xor cx, cx
	mov cx, inda
	mov si, 0

	spausd:
	mov ah, 02h
	mov dl, rez[si]
	add dl, 30h
	int 21h

	inc si
	loop spausd

	
	;=============================================
	mov ah, 09h
	lea dx, nl
	int 21h	


	xor ax, ax
	xor dx, dx
	mov al, inputB[2]
	
	cmp al, "-"
	je zenklas1

		

	;#############################3skaicius b su zenklu
	zenklas1:
	mov ah, 09h
	lea dx, nl
	int 21h	


	xor cx, cx
	mov cl, inputB[1]
	add cx, 1
	mov SI, 3
	

	sk1:
	xor dx, dx
	mov al, inputB[si]
	
	push si
	sub si, 3
	mov rez1[si], al
	sub rez1[si], 30h
	mov inda, si
	pop si
	
	inc SI
	
	loop sk1


	xor cx, cx
	mov cx, inda
	mov si, 0

	spausd1:
	mov ah, 02h
	mov dl, rez1[si]
	add dl, 30h
	int 21h

	inc si
	loop spausd1

	;=============================================
	mov ah, 09h
	lea dx, nl
	int 21h	

	xor cx, cx
	mov cl, ind
	mov si, 1
	daliklis:
	mov al, 1
	mov bl, 10
	mul bl
	add dal, ax
	inc si
	loop daliklis


	xor cx, cx
	mov cl, ind1
	mov si, 1
	daliklis1:
	mov al, 1
	mov bl, 10
	mul bl
	add dal1, ax
	inc si
	loop daliklis1




	xor cx, cx
	mov cl, ind
	mov si, 0

	ska:
	xor ax, ax
	mov al, rez[si]
	mov bx, dal
	mul bx
	add sk1, ax
	mov ax, dal
	mov bx, 10
	div bx
	mov dal, ax
	div 
	inc si
	loop ska



;	xor ax, ax
;	xor bx, bx
;	mov sa, rez
;	mov sb, rez1
;	mov al, sa
;	mov bl, sb
;	mul bl
;
;	mov ats, ax
;	
;	xor ax, ax
;	mov ah, 09h
;	mov dx, ats
;	add dx, 30h
;	int 21h

;  	call print
		 

	jmp end_
	


	PRINT PROC NEAR
	
	; --- skaitmenu kiekis

	push ax
	mov dig, 0
	COUNT_DIGS:	

		xor bx, bx
		mov bx, 10
	
		xor dx, dx
	
		div bx
		inc dig
	
		cmp ax, 0

	ja COUNT_DIGS
	
	pop ax

	; --- surasymas i masyva
	
	xor cx, cx
	mov cl, dig

	xor bx, bx
	mov bl, dig
	mov si, bx
	mov rezas[si], '$'
	dec si

	WRT_ARRY:
		xor bx, bx
		xor dx, dx
		mov bx, 10
		div bx

		mov rezas[si], dl
		add rezas[si], 30h
		dec si		

	loop WRT_ARRY
		
	mov ah, 09h
	lea dx, rezas	
	int 21h

	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx

	RET
	PRINT ENDP

	end_:
	mov ah, 09h
	lea dx, msg3
	int 21h



	mov ah, 07h
        int 21h    

	mov ah, 4Ch
	int 21h


main ends
end start