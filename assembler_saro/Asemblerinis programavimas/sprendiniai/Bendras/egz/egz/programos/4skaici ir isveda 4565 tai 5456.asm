STEK segment stack
db 256 dup(?)
STEK ends

data segment
	a db 5
	  db ?
	  db 5 dup(?)
	temp db ?
	ten db 10
	ats db 4 dup(?),'$'

	note db 'Kursinio darbo uzduotis Nr.1','$'
	not2 db 'atliko Marija Bachvalova, FMu-2 gr.', 13,10,'$' 
	not3 db 13,10,13,10,'Klaida!!!', 13,10,'$'
	note2 db 13,10,'Iveskite keturzenkli skaiciu: ','$'
	note3 db 13,10,13,10,'Naujas skaicius: ','$'	
data ends             
                      
prog segment          
	assume CS:PROG, DS:DATA, ss:stek
	start: 
	
	  ; duomenu nuskaitymas       
	   mov ax, data
	   mov ds, ax

          ; ekrano isvalymas        
	   mov ax,0002h    
	   int 10h 
	   
	   mov dh, 02
 	   mov dl, 20

	call kurs

	  ; pranesimu isvedimas                      
	   mov ah, 09h	
	   lea dx, note
	   int 21h

	mov dh, 03
	mov dl, 17

	call kurs
        
        mov ah, 09h	
	lea dx, not2
	int 21h
	jmp m
               
j:	mov ah, 09h	
	lea dx, not3
	int 21h
	       
m:        mov ah, 09h	
	lea dx, note2
	int 21h                               

	mov ah, 0Ah
 	lea dx, a
	int 21h

	xor ax, ax
	mov al, a+1
	mov temp, al
	cmp temp, 4
       	    jne j
        

	mov SI, 5
	mov BX, 1
	xor ax, ax
k:	mov al, a[SI]
        mov ats[BX], al
	dec SI
	dec BX
	cmp SI, 3
	    jne k

	mov BX, 3
l:	mov al, a[SI]
        mov ats[BX], al
	dec SI
	dec BX
	cmp SI, 1
	    jne l

	mov ah, 09h	
	lea dx, note3
	int 21h
	
	mov ah, 09h	
	lea dx, ats
	int 21h 	  

	 ; ekrano sustabdymas
	   mov ah,07h
	   int 21h

	 ; grizimas i DOS   
	   mov ah, 4ch
	   int 21h

;---PROCEDUROS---
kurs proc

	   mov ah, 02h
	   mov bh, 00h
	   int 10h

ret
kurs endp
           
prog ends   
end start