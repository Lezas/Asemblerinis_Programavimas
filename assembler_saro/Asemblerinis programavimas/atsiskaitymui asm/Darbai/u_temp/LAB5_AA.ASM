;============================
;Laboratorinis darbas Nr.5
;Vitalij Glova, II-03
;============================
stekas segment stack
      	db 256 dup(?)     
stekas ends
                        
duom segment               ;duomenu segmentas
        pran    db 'a=2, b=15, c=10, d=4. Reiskinio a^2*d+b-c reiksme lygi ','$'
   	a 	db 2
   	b 	db 15
   	c 	db 10
   	d 	db 4
   	ats 	db 3 dup(0), '$'
duom ends                          

progr segment               ;programos segmentas       
	assume	 cs:progr, ds:duom, ss:stekas
start: 	                   
	mov ax, duom        
	mov ds, ax
	
	mov ax, 0900h       ;pranesimo isvedimas i ekrana
	lea dx,pran
	int 21h
	         
        mov al, a           ;al<-a    (= a)
	mul a               ;al<-al*a (=a*a) 
	mul d               ;al<-al*d (=a*a*d)
	add al, b           ;al<-al+b (=a*a*d+b)
	sub al, c           ;al<-al-c (=a*a*d+b-c)
	
        mov si,2            ;si<-2 
zyme_1:
	div c   
	add ah, 30h         ;ah<-30h (30h=48)
	mov ats[si], ah     ;ats[2]<-30h
	dec si              ;si<-si-1
	xor ah, ah          ;ah<-0000 0000
	cmp al, 0           ;ar al=0 ? 
	je zyme_2           ;jeigu taip - einame i zyme_2
	jmp zyme_1          ;kitaip - griztame i zyme_1
zyme_2:
	mov ah, 09h         ;atsakymo isvedimas
	mov dx, offset ats
	int 21h
	mov ax, 4c00h       ;programos pabaiga
	int 21h
 progr ends
end start                   
