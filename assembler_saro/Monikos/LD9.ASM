stekas segment stack
db 256 dup(?)
stekas ends

duomenys segment

ivsr db 4,?,4 dup(0)
prana db 'iveskite a: ','$'
pranb db 10,13, 'iveskite b: ','$'
a db 0
b db 0
rezultatas db 10,13
rez db 3 dup(0), '$' ;nes dirbame su trizenkliais skaiciais
des db 10
trisd db 30h

duomenys ends

programa segment
assume cs:programa,ds:duomenys,ss:stekas
start: 
        mov ax,duomenys
        mov ds,ax
        
		;isvedame pranesima "iveskite a: "
		mov ah,09h
		lea dx,prana
		int 21h
		
        mov ah,0ah
        lea dx,ivsr
        int 21h
        
		;ivedimas pirmo skaicius
        mov cl,ivsr+1
        mov ch,0
        lea si,ivsr+2
        
ciklas1:
        mov al,a           
        mul des
        mov a,al  
        mov bl,[si] 
        sub bl,trisd
        add a,bl   
        inc si     
        loop ciklas1
        
		;isvedame pranesima "iveskite b: "
		mov ah,09h
		lea dx,pranb
		int 21h	

		;ivedimas antro skaicius
		mov ah,0ah
        lea dx,ivsr
        int 21h
        
        mov cl,ivsr+1
        mov ch,0
        lea si,ivsr+2
ciklas2:
        mov al,b
        mul des ;daugina ax is 10
        mov b,al
        mov bl,[si]
        sub bl,trisd
        add b,bl
        inc si
        loop ciklas2
        
		mov al,a
		add al,b
		
		mov ah,0
		div des  ;dalina ax is 10
		add ah,trisd
		mov rez+2,ah
		
		mov ah,0
		div des
		add ah,trisd
		mov rez+1,ah
		
		mov ah,0
		div des
		add ah,trisd
		mov rez, ah
		
		;isvedimas
		mov ah,09h
		lea dx,rezultatas
		int 21h
		
        mov ah,4ch
        int 21h

programa ends
end start