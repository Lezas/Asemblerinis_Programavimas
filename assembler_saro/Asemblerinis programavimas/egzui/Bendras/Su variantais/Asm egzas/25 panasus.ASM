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
	sa dw 15, "$"
	sb dw -3, "$"
	ats dw 0, "$"
	dal dw 0, "$"
	dal1 dw 0, "$"
	sk1 dw 0, "$"
	msg1 db 10, 13, "Skaicius A=: $"
	msg2 db 10, 10, 13, "Skaicius B=: $"
	msg3 db 10, 10, 13, "Rezultatas=: $" 
	msg4 db 10, 10, 13, "Bilieto Nr. 25, uzduoti atliko Laurynas Kiskys, FMu-2 $"
	
	
	
data ends

main segment

start:
	assume cs:main, ds:data, ss:stk

	mov ax, data
	mov ds, ax

	mov ax, 0002h
	int 10h

	mov ah, 09h
	lea dx, msg1
	int 21h

	xor ax, ax
	mov ax, sa
	call negat
	call print 

	mov ah, 09h
	lea dx, msg2
	int 21h

	xor ax, ax
	mov ax, sb
	call negat
	call print 


	mov ah, 09h
	lea dx, msg3
	int 21h	

	mov ax, sa	
	mov bx, sb
	imul bx

	call negat
	call print
	
	
	jmp end_

	NEGAT PROC NEAR

	cmp ax, 0
	jge neg_nonn

	mov bx, -1
	imul bx
	
	push ax

	mov ah, 02h	; 
	mov dx, 2Dh	; minuso atspausdinimas
	int 21h		;
	
	pop ax


	neg_nonn:

	RET
	NEGAT ENDP


	
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
	mov rez[si], '$'
	dec si

	WRT_ARRY:
		xor bx, bx
		xor dx, dx
		mov bx, 10
		div bx

		mov rez[si], dl
		add rez[si], 30h
		dec si		

	loop WRT_ARRY
		
	mov ah, 09h
	lea dx, rez	
	int 21h

	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx

	RET
	PRINT ENDP
	
	end_:

	mov ah, 09h
	lea dx, msg4
	int 21h


	mov ah, 07h
        int 21h    

	mov ah, 4Ch
	int 21h

main ends                                          
end start

