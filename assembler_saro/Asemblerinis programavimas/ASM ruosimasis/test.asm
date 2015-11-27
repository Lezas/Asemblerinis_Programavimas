stekas segment stack
        db 256 dup(?)
stekas ends

CR EQU 13
LF EQU 10

FALSE EQU 0
TRUE  EQU 1

duomenys segment
	Meniu DB CR, LF, 'Namu darbas: Marskineliu ispardavimas', CR, LF
		  DB CR, LF, 'Darba atliko: Arturas Janulis II-08/1', CR, LF
		 DB CR, LF, 'Jusu turima suma: 35 Lt', CR, LF
		   DB CR, LF, ' Vienu marskineliu kaina: 5 Lt', CR, LF
		  DB CR, LF, 'Pasirinkite norima rinkini:', CR, LF
		  DB CR, LF, '1) Tik Zalia!'
		  DB CR, LF, '2) Melyna, Zalia'
		  DB CR, LF, '3) Raudona, Geltona, Juoda'
		  DB CR, LF, '4) Geltona, Pika, Raudona, Balta'
		  DB CR, LF, '5) Juoda, Zalia, Geltona, Raudona, Geltona'
		  DB CR, LF, '6) Balta, Zalia, Melsva, Violetine , Juoda, Zalsva'
		  DB CR, LF, '7) Pilka, Rusva, Ruda, Salotine, Oranzine, Zydra, Pilka'
		  DB CR, LF, '8) Nepirkti nei vieno', CR, LF
		  DB CR, LF, 'Jusu Pasirinkimas: $'
		  
		  
		  
	Suma  DW 35
	Kaina DW 0
	Dydis DW 10
	
	Klaida   DB CR, LF, 'Klaida!', CR, LF, '$'
	Klaida1	 DB CR, LF, 'Pasirinkite tarp 1 ir 8, iveskite tik skaiciu', CR, LF, '$'
	Klavisas DB CR, LF, 'Paspauskite bet koki klavisa', CR, LF, '$'
	Reikia   DB CR, LF, 'Prekes kaina: $'
	Turima   DB CR, LF, 'Jusu suma: $'
	Nepakako DB CR, LF, 'Pinigu nepakako, truksta: $'
	Pakako   DB CR, LF, 'Sekmingai Nusipirkta!Jusu graza: $'
	Nenori   DB CR, LF, 'Viso geriausio, ateikite veliau! $'
	NaujaEilute DB CR, LF, '$'
	Pasirinkimas DB 0
	Tarpinis DB 0,'$'
	Simbolis DB '$'
	
	Error DB, 0
	
duomenys ends
               
programa segment           
         assume cs:programa, ds:duomenys, ss:stekas

Pradzia:                 
        mov ax, duomenys   
        mov ds, ax

        call RodytiMeniu 

		call iseitiProgram
		
RodytiMeniu proc
		call ClearScreen
		mov ah, 09h
		lea dx, Meniu
		int 21h
		
		call ReadKey
		call CheckNumber
		cmp Error, TRUE
		jne MeniuToliau
		call NewLine
		call ShowError
		mov Error, FALSE
		mov ah, 09h
		lea dx, Klaida1
		int 21h
		mov ah, 09h
		lea dx, Klavisas
		int 21h
		call WaitKey
		call ClearScreen
		Call RodytiMeniu
		jmp MeniuEnd
	MeniuToliau:
		Call NewLine
		mov ah, 09h
		lea dx, Reikia
		int 21h
		Call SumPrice
		mov ax, Kaina
		Call PrintNumber
		
		Call NewLine
		mov ah, 09h
		lea dx, Turima
		int 21h
		mov ax, Suma
		Call PrintNumber
		Call NewLine
		Call CheckPrice
		
		Call WaitKey
	MeniuEnd:
		ret
RodytiMeniu endp

ReadKey proc
		mov ah, 1h
		int 21h
		ret
ReadKey endp

CheckNumber proc
		push cx
		mov cx, ax
		push ax
		cmp cl, 31h
		jl NumberError
		cmp cl, 38h
		jg NumberError
		jmp NumberEnd
	NumberError:
		mov Error, TRUE
	NumberEnd:
		sub cl, 30h
		mov Pasirinkimas, cl
		pop ax
		pop cx
		ret
CheckNumber endp

ShowError proc
		mov ah, 09h
		lea dx, Klaida
		int 21h
		ret
ShowError endp

ClearScreen proc
		mov ax, 02h
		mov bx, 03h
		int 10h
		ret
ClearScreen endp

WaitKey proc
		mov ax, 0100h
    	int 21h
		ret
WaitKey endp

iseitiProgram proc
		mov ax, 4c00h
    	int 21h
		ret
iseitiProgram endp

SumPrice proc
		push ax
		xor ax, ax
		mov ah, 0h
		mov al, Pasirinkimas
		cmp ax, 08h
		jne Testi
		mov Pasirinkimas, 0
	Testi:
		mov ax, 05h
		mul Pasirinkimas
		mov Kaina, ax
		pop ax
		ret
SumPrice endp

PrintNumber proc
		mov cx, 0                    
	push_sk:                             
        mov dx, 0                    
        div Dydis                     
        add dx, 30h                  
        push dx                      
        inc cx                       
        cmp ax, 0                    
        jne push_sk                  
	pop_sk:                              
        mov ah, 09h                  
        pop dx                       
        mov Tarpinis, dl                 
        lea dx, Tarpinis                 
        int 21h                      
        loop pop_sk

		lea dx,Simbolis

        mov ah, 09h
        int 21h
		
        ret            
PrintNumber endp

NewLine proc
		push ax
		push dx
		mov ah, 09h
		lea dx, NaujaEilute
		int 21h
		pop dx
		pop ax
		ret
NewLine endp

CheckPrice proc
		push ax
		push dx
		
		mov ax, Kaina
		cmp ax, 0
		je Neutral
		
		mov ax, Suma
		cmp ax, Kaina
		jge Taip
		jle Ne
	Taip:
		mov ah, 09h
		lea dx, Pakako
		int 21h
		mov ax, Suma
		sub ax, Kaina
		call PrintNumber
		
		jmp PriceEnd
	Ne:
		mov ah, 09h
		lea dx, Nepakako
		int 21h
		
		mov ax, Kaina
		sub ax, Suma
		call PrintNumber
		
		jmp PriceEnd
	Neutral:
		mov ah, 09h
		lea dx, Nenori
		int 21h
	PriceEnd:
		pop dx
		pop ax
		ret
CheckPrice endp

programa ends
         end Pradzia               
        
