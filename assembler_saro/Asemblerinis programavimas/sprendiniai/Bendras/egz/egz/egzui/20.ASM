Stekas SEGMENT stack  
	db 256 dup (?)
Stekas ENDS

Duomenys SEGMENT
	Pran	db 'Kursinio darbo uzduotis Nr1',13,10
		db 'Atliko: Donatas Puzas, II-2/5 gr.',13,10,'$'
	Pran2	db 'Uzduotis:',13,10
	        db 'Ivedami du skaiciai ir isvedamas ju vidurkis',13,10,'$'
                Pran3   db 'Iveskite pirma skaiciu: ','$'
	Pran4   db 13,10,'Iveskite antra skaiciu: ','$'                  
	Pran5   db 13,10,'Stai ir musu gautas atsakymas: ','$'
	Pran51  db 13,10,'Stai ir musu gautas atsakymas: -','$'
	Pran6   db 13,10,'progamos pabaiga',13,10,'baigti spauskite bet kuri klavisa...',13,10,'$'
	Pran7   db 13,10,'uzsiknisau','$'                     
	kablys  db ',5',13,10,'$'
	klaida  db 'KLAIDA!!! Jus ivedete ne skaiciu, prasome pakartoti ivedima',13,10,'$'
	klaida1 db 'KLAIDA!!! Jus blogai ivedete, prasome pakartoti ivedima',13,10,'$'
	spenter db 'KLAIDA!!! Jus neivedete jokio simbolio, prasome pakartoti ivedima',13,10,'$'
        minn    db 13,10,'minusas',13,10,'$'	     
	     Sk1 db 5,?,5 DUP (?)
		Sk2 db 5,?,5 DUP (?)
	     rez dw ? ,' $'
	       x dw ?  
	       y dw ?
	       du dw 2
	       k dw ?
	        ten dw 10
	        a db ?,'$'
	        l db ?,'$'
	        
Duomenys ENDS
Programa SEGMENT
ASSUME SS:Stekas, DS:Duomenys, CS:Programa
START:
        ;pradzia
        MOV AX, Duomenys
	MOV DS,AX
	;ekrano isvalymas
	mov ax,0002h
	int 10h
	;pranesimo spauzdinimas
	MOV AH,09h
	LEA DX,Pran
	INT 21h
	;Antro pransesimo spauzdinimas
	MOV AH,09h
	LEA DX,Pran2
	INT 21h
pradzia:
        ;Trecio pranesimo isvedimas
        MOV AH,09h
        LEA DX,Pran3
        INT 21h
;------------------------------------------------
	mov ah,0Ah     ;pirmo skaiciaus ivedimas
        lea dx,sk1
        int 21h
        cmp sk1[2],13	;lyginam ar pirmas ne enter
        je enteris
        cmp sk1[2],'-'	;lyginam ar pirmas skaicius ne minusas
        je suminusu1
        cmp sk1[2],48          ;
        jl neskaicius1                    ;
        cmp sk1[2],57          ;
        jle skaicius1                   ;
        neskaicius1:                            ;         ar skaicius?
        mov ah,09h                  ;
        lea dx,klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
        skaicius1:                            ;
        mov ax,0
        sub sk1[2],30h
        mov al,sk1[2]
        cmp sk1[1],1
        je far ptr iseiname2
        neig1:
        mov ch,0
        mov cl,sk1[1]
        sub cl,1
        mov si,3
        zz3: mul ten
        cmp sk1[si],48         ;
        jl Nerskaiciaus                    ;
        cmp sk1[si],57         ;
        jle zyme21                   ;
        Nerskaiciaus:                            ;         ar skaicius?
        mov ah,09h                  ;
        lea dx, klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
enteris:
        mov ah, 09h
        lea dx, spenter
        int 21h
        jmp far ptr pradzia
suminusu1:
        cmp sk1[1],1
        je tikminus1 
        mov cl,sk1[3]
        sub cl,30h
        cmp cl,0
        je neignulis 
        mov ax,0
        jmp neig1                ;
tikminus1:
	mov ah,09h 
	lea dx, klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
neignulis:
        mov ah, 09h
        lea dx, klaida1
        int 21h
        jmp far ptr pradzia
zyme21:
        sub sk1[si],30h
        add al,sk1[si]
        inc si              
        loop zz3 
	iseiname2:
		;-------------------------------------------------
	mov x,Ax
	xor ax, ax
        ;Trecio pranesimo isvedimas
        MOV AH,09h
        LEA DX,Pran4
        INT 21h
	mov ah,0Ah     ;Antro skaiciaus ivedimas
        lea dx,sk2
        int 21h
        cmp sk2[2],13	;lyginam ar pirmas ne enter
        je enteris2
        cmp sk2[2],'-'	;lyginam ar pirmas skaicius ne minusas
        je suminusu2
        cmp sk2[2],48
        jl neskaicius2
        cmp sk2[2],57
        jle skaicius2
Neskaicius2:                            ;         ar skaicius?
        mov ah,09h                  ;
        lea dx,klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
skaicius2:                            ;
        mov ax,0
        sub sk2[2],30h
        mov al,sk2[2]
        cmp sk2[1],1
        je far ptr iseinam2
        neig2:
        mov ch,0
        mov cl,sk2[1]
        sub cl,1
        mov si,3
zz2: mul ten
        cmp sk2[si],48         ;
        jl Nerskaiciaus2                    ;
        cmp sk2[si],57         ;
        jle zyme                   ;
Nerskaiciaus2:                            ;         ar skaicius?
        mov ah,09h                  ;
        lea dx, klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
enteris2:
        mov ah, 09h
        lea dx, spenter
        int 21h
        jmp far ptr pradzia
suminusu2:
        cmp sk2[1],1
        je tikminus2
        xor cx,cx
        mov cl,sk2[3]
        sub cl,30h
        cmp cl,0
        je neignulis2
        mov ax,0
        jmp neig2                ;
tikminus2:
	mov ah,09h 
	lea dx, klaida                ;
        int 21h                     ;
        jmp far ptr pradzia          ;
neignulis2:
        mov ah, 09h
        lea dx, klaida1
        int 21h
        jmp far ptr pradzia           
       zyme:                            ;
        sub sk2[si],30h
        add al,sk2[si]
        inc si
        loop zz2 
iseinam2:   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov y,Ax
      	;skaiciavimai:
	 mov ah,00
	;Dvieju skaiciu suma
	cmp sk1[2],'-'
	je pirmasneig
	cmp sk2[2],'-'
	je far ptr pirmteigantrneig
	jmp abuteig
	pirmasneig:
	cmp sk2[2],'-'
	je abuneig
	jmp pirmneigantrteig
;-----------------------------kai abu teigiami--------------------------
	abuteig:
	xor dx,dx
	mov ax,x
	;mov cx,y
        add ax,y
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis1
	jmp lyginis1
	nelyginis1:
	;Atsakymo spauzdinimas
	MOV AH,09h
	LEA DX,Pran5
	INT 21h
	mov ax,rez
	call isvedimas 
	jmp baig
	lyginis1:
        MOV AH,09h
	LEA DX,Pran5
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
;-----------------------------kai abu neigiami--------------------------
	abuneig:
	mov ax,x
        add ax,y
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis2
	jmp lyginis2
	nelyginis2:
	;Atsakymo spauzdinimas
	MOV AH,09h
	LEA DX,Pran51
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedimas 
	jmp baig
	lyginis2:
        MOV AH,09h
	LEA DX,Pran51
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
;-----------------------------pirmas teigiamas antras neigiamas--------------------------
pirmteigantrneig:
        mov ax,x
        mov bx,y
	cmp ax,bx
	jge pirmdid1
	jl pirmmaz1
	pirmdid1:
	xor dx,dx
	mov ax,x
        sub ax,y
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis31
	jmp lyginis31
	nelyginis31:
	;Atsakymo spauzdinimas
	MOV AH,09h
	LEA DX,Pran5
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedimas 
	jmp baig
	lyginis31:
        MOV AH,09h
	LEA DX,Pran5
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
	pirmmaz1:
	mov ax,y
        sub ax,x
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis32
	jmp lyginis32
	nelyginis32:
	;Atsakymo spauzdinimas
	MOV AH,09h
	LEA DX,Pran51
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedimas 
	jmp baig
	lyginis32:
        MOV AH,09h
	LEA DX,Pran51  
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
;-----------------------------pirmas neigiamas antras teigiamas--------------------------
pirmneigantrteig:
        mov ax,x
        mov bx,y
	cmp ax,bx
	jg pirmdid2
	jle pirmmaz2
	pirmdid2:
	xor dx,dx
	mov ax,x
        sub ax,y
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis41
	jmp lyginis41
	nelyginis41:
	;Atsakymo spauzdinimas
	MOV AH,09h
	LEA DX,Pran51
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedimas 
	jmp baig
	lyginis41:
        MOV AH,09h
	LEA DX,Pran51
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
	pirmmaz2:
        xor dx,dx
	mov ax,y
        sub ax,x
        div du
	mov rez,ax
	cmp dx,1
	je nelyginis42
	jmp lyginis42
	nelyginis42:
	;Atsakymo spauzdinimas
 	MOV AH,09h
 	LEA DX,Pran5
 	INT 21h
 	mov AH,0
 	mov ax,rez
 	call isvedimas 
	jmp baig
	lyginis42:
        MOV AH,09h
	LEA DX,Pran5
	INT 21h
	mov AH,0
	mov ax,rez
	call isvedi2
	jmp baig
;------------------------pabaiga---------------------------------------
	baig:
	MOV AH,09h
        LEA DX,Pran6
        INT 21h
	;pristabdymas
	MOV AH,07H
	INT 21H
;--------------------gryzimas i DOS-------------------------------------
	MOV AH,4ch
	int 21h
	jmp pabaiga
isvedimas proc
        mov k,0
        mov dx,0
        pusinam1:   div ten
        push dx
        inc k
        mov dx,0
        cmp ax,0
        jne pusinam1
        mov cx,k
        popinam1:  pop dx
        mov a,dl
        add a,30h
        mov ah,09h
        lea dx,a
        int 21h 
        loop popinam1
        mov ah,09h
        lea dx,kablys
        int 21h
        ret
        endp isvedimas
isvedi2 proc
        mov k,0
        mov dx,0
        pusinam2:   div ten
        push dx
        inc k
        mov dx,0
        cmp ax,0
        jne pusinam2
        mov cx,k
        popinam2:  pop dx
        mov a,dl
        add a,30h
        mov ah,09h
        lea dx,a
        int 21h 
        loop popinam2
        ret
        endp isvedi2
pabaiga:
Programa Ends
END START