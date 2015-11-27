


Stekas segment stack
        db 256 dup (?)
Stekas ends

DATA segment                                   
        apr db "Bando Marius Kuprys fmu-2",10,13
            db "padauginti zodi is baito.",10,13
	    db "zodi ir baita ivedame kaip skaicius",10,13
            db "Rezultata atspausdinti",10,13   
            db "Skaicius ivesti is klaviaturos",10,13,'$'
      pirm  db 10,13,"iveskite pirma skaiciu",10,13,'$'
      antr  db 10,13,"iveskite antra skaiciu",10,13,'$'
       ats  db 10,13,"atsakymas= ", '$'
	    a db 5, ?, 5 dup (?) ;pirmo skaiciaus ivedimui
	    b db 5, ?, 5 dup (?) ;antro skaiciaus ivedimui
       ten  db 10

DATA ends

Program segment
	ASSUME CS:Program, DS:DATA, SS:Stekas

START:

;------Duomenu nuskaitymas------

	mov ax, DATA
	mov ds, ax

;------Ekrano isvalymas------

	mov ax, 002h
	int 10h

;------Uzduoties isvedimas------

	mov ah, 09h
	lea dx, apr
	int 21h

;------Isveda pirm-----

	mov ah, 09h
	lea dx, pirm
	int 21h

;------Pirmo skaiciaus ivedimas--

	mov ah, 0ah
	LEA dx, a
	int 21h


;------Isveda antr-----

	mov ah, 09h
	lea dx, antr
	int 21h


;------Antro skaiciaus ivedimas--

	mov ah, 0ah
	lea dx, b
	int 21h

;------Skaiciu dauginimas------

	mov al, a
	mul a

	mov al, b
	mul b
k:	              
	   div ten       
	   add ah, 30h		
	   mov ats[SI], ah	
	   dec SI 
	   mov ah,0		
	   cmp al, 0		
		je l	
		jmp k
l:	                                    
	   mov ah, 09h	       
	   lea dx,ats
	   int 21h


;------Pabaiga------

	mov ah, 07h
	int 21h

;------Grizimas i dos------

	mov ah, 4ch
	int 21h

Program ends
End START


   