;steko segmentas
stekas SEGMENT STACK
DB 256 DUP (?)
stekas ENDS
          
duomenys SEGMENT 

dn db 29
kd db 40
skaiciai db 0
raides db 0          
ivsr db 255,?,255 dup(' ')
pran db 'iveskite teksta: ','$'
filename db 'C:\Tasm\Temp\filename.txt',00h
filehandler dw ? ; fail deskriptorius
          
duomenys ENDS
          
programa SEGMENT
ASSUME CS:programa, DS:duomenys, SS:stekas
          
;paruosiame duomenu segmento registra
          
START:    
mov AX, DUOMENYS
mov DS,AX 
          
	;isvedame pranesima
	mov ah,09h
	lea dx,pran
	int 21h
          
    mov ah,0ah
    lea dx,ivsr
    int 21h
          
	;sukuriame faila
	mov ah,3ch ;paprastyti sukurti faila
	mov cx,00 ;nenaudojame atributu
	lea dx,filename ;kelio iki failo eilutes adresas
	int 21h ;pertraukimas operacijai ivykdyti
	jc klaida; jei ivyko klaida. Aprasomi veiksmai ka daryti jei operacija nesekminga
	mov filehandler, ax ; isiminti failo deskriptoriu
	  
	;rasymas i faila
	mov ah,40h ;paprasyti uzrasyti duomenis i faila
	mov bx,filehandler ;irasyti failo deskriptoriu
	mov cx,0 ;patalpinti irasomo fragmento ilgi
	;patalpinti isvedimo srities adresa
	mov cl,ivsr+1 
	lea dx,ivsr+2
	int 21h ;pertraukimas
	jc klaida ;
	cmp ax,14h ; ar visi baitai irasyti
	jne klaida1 ;Jei ne visi baitai irasyti, eiti i klaidos apdorojima
	  
	  
	;failo uzdarymas
	mov ah,3eh ;paprasome uzdaryti faila
	mov bx, filehandler ; uzrasome failo deskriptoriu
	int 21; nutraukimas
	jc klaida
	  
	;------------- ANTRA UZDUOTIS --------
          
	;atidaryti faila
	mov ah,3dh ; prasymas atidaryti faila
	mov al,00
	lea dx,filename
	int 21h
	jc klaida
	mov filehandler,ax
	  
	;skaityti faila
	mov ah,3fh ;paprasyti paskaityti faila
	mov bx,filehandler ;patalpinti deskriptoriu
	mov cx,100h ;patalpinti skaitomu baitu kieki
	lea dx,ivsr ; patalpinti ivedimo srities adresa
	jc klaida
	cmp ax,00 ; ar visi baitai nuskaityti
	je close
	        
	close:  
	;uzdaryti faila
	mov ah,3eh ;paprasome uzdaryti faila
	mov bx, filehandler ; uzrasome failo deskriptoriu
	int 21; nutraukimas
	jc klaida
	jmp theEnd
	
	skaiciuojam:
	mov cl, ivsr+1                  
	mov ch, 0
	lea si, ivsr+2
	ciklas:
	mov ah, [si]
	CMP ah, dn
	JG daugiau_uz_29
	JMP raide
	daugiau_uz_29:
	CMP ah, kd  
	JL skaicius 
	JMP raide         
	skaicius:    
	INC skaiciai     
	JMP end_of_cycle           
	raide:
	INC raides          
	JMP end_of_cycle           
	end_of_cycle:           
	loop ciklas
	
	
	        
	        
	klaida: 
	mov ah,11h
	
	klaida1:
	mov ah,12h
	
	theEnd:

	mov ah,4ch
        int 21h

programa ends
end start



