stekas segment stack   
        db 256 dup(?)
stekas ends  

;duomenu segmentas
duomenys segment       
pran db 'Darba atliko:',13,10
     db 'Joana Maldziute, II-2/5 gr.',13,10
     db ' ',13,10
     db 'Kursinio darbo uzduotis Nr.1:',13,10
     db 'Programa papraso vartotoja ivesti skaiciu bei viena simboli',13,10
     db 'ir is ivesto simbolio ekrane suformuoja kvadrata, kurio',13,10
     db 'krastines ilgis lygus ivestam skaiciui.',13,10
     db ' ',13,10
     db 'Iveskite simboli is klaviaturos',13,10
     db ' ',13,10,'$'
pran2 db 'Iveskite skaiciu nuo 1 iki 20',13,10
      db ' ',13,10,'$'
pran5 db 'Jus ivedete netinkama skaiciu. Iveskite skaiciu nuo 1 iki 20'
      db ' ',13,10,'$'
des db 10
skaicius db 3,?,2 dup(0)
skaic db 3,?,2 dup(0)
simbolis db 'Simbolis: '
simb db ?,13,10
     db ' ',13,10,'$'
pranSkaic db 'Skaicius: ','$'
pran3 db ' ',13,10
      db 'Spauskite bet koki klavisa...',13,10,'$'
pran4 db 'Gautas rezultatas:',13,10,'$'
duomenys ends  

; programos segmentas                   
programa segment       
 assume cs:programa,ds:duomenys,ss:stekas
 start: mov ax,duomenys
        mov ds,ax   
        ;ekrano isvalymas       
        mov ax,0002h
        int 10h
        ;pranesimo isvedimas
        mov ah,09h
        lea dx,pran
        int 21h
        ;simbolio ivedimas
        mov ah,08h
        int 21h
        mov simb,al
        mov ah,09h
        lea dx,simbolis
        int 21h
        ;isvedame pranesima
        mov ah,09h
        lea dx,pran2
        int 21h 
        ;skaiciaus ivedimas
        ;pranesimo isvedimas
        mov ah,09h
        lea dx,pran2
        int 21h
        jmp ived
        zyme: mov ah,09h
              lea dx,pran5
              int 21h
        ;bandymas daryti kokia nors nesamone
        ived: mov ah,0ah
        lea dx,skaicius
        int 21h
        mov cx,2
        lea si,skaicius+2
        mov dx,0
        mov dl,skaicius+1
        ;ar ivestas skaicius                
        ciklas: mov ax,0
                mov al,[si]
                cmp ax,'0'
                jb zyme
                cmp ax,'9'
                ja zyme
                cmp ax,13 ;ar enter
                je toliau
                inc si
                cmp dx,1
                je toliau
                loop ciklas          
        ;ar skaicius yra 1<=a<=20
        toliau: ;patalpinam rezultata '?','?' i viena baita
lea si,skaicius+2
mov bx,0
mov bl,skaicius+1
mov di,bx
mov ax,0
ciklas1: mov al,[si]
    	sub al,30h
	dec di    
	cmp di,0  
	je zyme1  
	mul des   
	mov skaic,al
	inc si    
	jmp ciklas1
zyme1:   mov bx,0 
        mov bl,skaic
	add al,bl 
	mov skaic,al  	
;patikrinam ar ivesta teisinga reiksme
mov ax,0
mov al,skaic
cmp ax,1
jb ived ;atgal i skaiciu ivedima
cmp ax,20
ja ived ;atgal i skaiciu ivedima
;isvedame ivesta skaiciu
mov bx,0
mov bl,'$'
mov ax,0
mov al,skaicius+1
cmp ax,2
je toliau2
mov skaicius+3,bl
jmp toliau1
toliau2: mov skaicius+4,bl
toliau1: mov ah,09h
	 lea dx,pranSkaic
	 int 21h
	 mov ah,09h
	 lea dx,skaicius+2
	 int 21h
        
        
        ;isvedimas - laukia...
        mov ah,09h
        lea dx,pran3
        int 21h       
        ;laukia klaviso paspaudimo
        mov ah,07h
        int 21h
        ;ekrano isvalymas
        mov ax, 0600h                                  
        mov bh, 07                                     
        mov cx, 0000h                                  
        mov dx, 184Fh                                  
        int 10h
        ;kursoriaus nustatymas
        mov ah,02
        mov bh,00
        mov dh,01
        mov dl,31
        int 10h
        ;pranesimo spausdinimas
        mov ah,09h
        lea dx,pran4
        int 21h
        ;isvedimas - laukia...
        mov ah,09h
        lea dx,pran3
        int 21h         
                 
        mov ah,07h
        int 21h
                              
        ;darbo pabaiga (Exit Code 0)
        mov ax,4C00h
        int 21h
 programa ends           
    end start