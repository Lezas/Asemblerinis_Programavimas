masm
model small
stack 256
.data
        eilute1 db ?,'Gr Nr - II-2/1','$'
        message db ?,'Iveskite varda ir pavarde:','$'
	ivsr db 15,(?),16 dup(' '),'$'     
	skaicius db 2 
	skaicius1 dw 15                                                       
.code                     
       
main:  
       mov ax,@data
       mov ds,ax

 	mov ax,0002h ;ekrano isvalymas            
	int 10h   

        mov ah,09h
        lea dx, message       
        int 21h  

	mov ah,0ah
	lea dx,ivsr
	int 21h	                                       
 	
	mov ax,0002h ;ekrano isvalymas            
	int 10h   
		
	mov ah,02
	mov bh,00
	mov dh,00
	mov DL,33
	int 10h

	mov ah,09h
	lea dx,eilute1        
        int 21h  
        
        mov ax,80
	sub ax,skaicius1
	div skaicius
	mov dl,al
		
	mov ah,02
	mov bh,00	
	mov dh,05 
	int 10h	 
                 
	mov ah,09h
	lea dx,ivsr+2       
        int 21h  
         
	mov ah, 07h ;laukimas
        int 21h
        
        MOV ah,4Ch
        INT 21h                     
                                        
end main