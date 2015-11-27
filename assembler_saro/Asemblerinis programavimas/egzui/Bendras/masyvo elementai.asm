stekas segment stack
	db 256 dup (?)
stekas ends

duomenys segment
	note1 db 'Uzd.4. Domante Olekaite, FMu-2', 13, 10, '$'
        note2 db 'Masyvo elementu suma: 1+2+1+10+1+2 = ', '$'
	masyvas db 6 dup (1,2,1,10,1,2), '$'  
	desimt db 10, '$'			
	result db 4 dup (0) ,'$'
duomenys ends

programa segment
  assume CS: programa, DS: duomenys, SS: stekas
  start:
	mov ax,0002h			; isvalo ekrana
	int 10h

	mov ax, duomenys
	mov ds, ax

        mov si, 0                                
        mov cx, 5
        mov al, masyvas[si]	  	
                          
ciklas:                   
        inc si
      	add al, masyvas[si]
      	loop ciklas
                                       
        mov si, 3
        mov ah, 0               ; !!

resultas:                 
        div desimt        
        add ah, 30h	  
	mov result[si], ah
	dec si		  	
	mov ah,0		
;check
	cmp al,0
	je isvedimas		
	jmp resultas		

isvedimas:	
	mov ah, 09h
	lea dx, note1
	int 21h	

	mov ah, 09h
	lea dx, note2
	int 21h	
                                 
        mov ah, 09h   
	lea dx, result
	int 21h	

        mov ah, 07h
        int 21h                              
                      
        mov ah, 4ch
        int 21h      

programa ends
end start