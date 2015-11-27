segment sseg stack 
	DB 256 dup(?)
ends sseg
segment dseg
	vardas db 20,?,21 dup('$')
	pavarde db 20,?,21 dup('$')
	metai db 5,?,5 dup(0)

	txt1 db 'Vardas:','$'
	txt2 db 10,13,'Pavarde:','$'
	txt3 db 10,13,'Gimimo metai:','$'
	txt4 db 10,13,'!Klaida dirbant su failu','$'

	buf db 10 dup(0); isvedimo buferis
	bufe db '$' ; buferio pabaiga
                                     
	amzius dw 2005               
	desimt dw 10                 
	EL2 db ' ','$'	;paprastas tarpelis
	EL db 10,13,'$'              

	failas	DB 'rez.txt', 0
	handle	DW 0

ends dseg
segment cseg
main proc far 
assume	cs:cseg, ds:dseg, es:dseg, ss:sseg
	mov ax, dseg
	mov ds, ax
;-------------------------------------------------------------------------------------------------
;--Svarus ekranas---------------------------------------------------------------------------------
	mov ax, 02h
	int 10h
;--Vardas----------------------------------------------------------------
	mov ah, 09h
	lea dx, txt1;
	int 21h
	mov ah, 0Ah
	lea dx, vardas 
	int 21h
;--Pavarde--------------------------------------------------------------- 
	mov ah, 09h
	lea dx, txt2
	int 21h 
	mov ah, 0Ah
	lea dx, pavarde
	int 21h
;--Metai-----------------------------------------------------------------
	mov ah, 09h
	lea dx, txt3
	int 21h
	mov ah, 0Ah
	lea dx, metai
	int 21h
	mov ah, 09h
	lea dx, EL
	int 21h
;--Skaiciavimas----------------------------------------------------------
	lea si, metai
;ekrano valdymas 1--------
 
	xor bx,bx
	mov ah, 02h
	mov dh,10
	mov dl,20 
	int 10h

 
;mano vardas-------
	mov ah,09h
;lea dx, EL
;int 21h

	lea dx,vardas+2
	int 21h


;lea dx,EL
;int 21h	

;ekrano valdymas 2------
	xor bx,bx
	mov ah,02h
	mov dh,10
	mov dl,21
	add dl,vardas+1
	int 10h

;mano pavarde------------ 
	mov ah,09h
	lea dx,pavarde+2
	int 21h 
 
 ; lea dx,EL
 ; int 21h
	xor ax,ax 
;---End of mano pavard------------- 
	
	call numin
	sub amzius, ax ;2005-1985
;--Isvedimas---------------------------------------------------------------------------------------
;ekrano valdymas 3----------------- 
	xor bx,bx 
	mov ah, 02h
	mov dh, 10
	mov dl, 22
	add dl,pavarde+1  
	add dl,vardas+1   
	int 10h           
;----ekrano vald END----  
	mov ax, amzius ;20
	call numout       
;--failai------------------------------------------------------------
	push dx ;numetam metu adresa i steka
;--create                 
	mov	ah, 3Ch   
	mov	cx, 0     
	lea	dx, failas
	int 21h           
	jc	klaida  ;tikrina ar cf==1, jei taip tai jmp klaida 
	mov	handle, ax ;persiunchia i handle failo adresa
                          
;--write                  
                          
	lea si, vardas    
	mov cl, [si+1] ;i cl numetem baitu skaiciu (kiek ivedem raidziu)
	mov ch, 00h                                                   
	inc si            
	inc si            
	mov dx, si        
	call writeln      
                          
	lea si, pavarde   
	mov cl, [si+1]    
	mov ch, 00h       
	inc si            
	inc si            
	mov dx, si        
	call writeln      
                          
	pop dx        ;isimam metu adresa is steko
	lea cx, bufe      
	sub cx, dx   ; adresas $ - adresas metai = baitu skaicius
	call writeln      
;--close                  
	mov ah, 3Eh       
	mov bx, handle    
	int 21h           
;--programos pabaiga-------------------------------------------------------------------------------
exit:                     
;--Pause--                
	mov ah, 07h       
	int 21h           
;--Exit                   
	mov ah, 4Ch       
	int 21h           
klaida:                   
	mov ah, 3Eh    ;ivykus klaidai uzhdarom 
	mov bx, handle    
	int 21h           
	mov ah, 09h       
	lea dx, txt4;     
	int 21h           
	jmp exit
 endp main     
               
;--procedura string=>hex---------------------------------------------------------------------------
;parametrai: SI tekstas
;return: AX rezultatas
numin PROC     
	xor cx, cx
	xor bx, bx
	xor ax, ax
	inc si       ;si+1 
	mov cl, [si] ;kiek ivesta simboliu
	inc si       ;si+1                      
ciklas:                          
	mov bl, [si]   
	sub bl, 30h              
	add ax, bx               
	cmp cx, 01h              
	jle skip ;metai i skip kai cx<=1     
	mul desimt   
skip:               
	inc si                                       
	loop ciklas ;kai cx==0 loopas neshoka i label
               
	ret    
ENDP numin     
               
numout proc near
	lea si,bufe ;adresas ampersendo
dar:           
	xor dx,dx     
	div desimt ;ax dalinam ish 10    
	add dl,30h ;dl=liekana                  
	dec si                      
	mov [si],dl                 
	cmp ax,0                    
	jg dar  ;jei ax vis dar ne 0 jmp dar      
                                  
	mov dx,si                 
	mov ah,09h                
	int 21h                   
	ret                       
endp numout                       
                                  
writeln proc near                 
	mov    	ah, 40h           
	mov    	bx, handle        
	int	21h               
	jc	klaida            
	mov	ah, 40h           
	mov	bx, handle            
	lea dx, EL2           ;tarpelis     
	mov cx, 1     ;kiek baitu       
	int	21h    
	jc	klaida 
	ret            
endp writeln           
ends cseg              
end main