
stekas  segment stack         
        db 256 dup(?)         
stekas  ends                  
                              
duom    segment               

a db 5
b db 2
c db 6 dup (?),10,13,'$'         
des db 10,'$'


author db 'Konstantin Pakalenko II-3/6',10,13,'$'
intro db 'Programa sudaugina du vieno baito ilgio skaicius A ir B esancius OA '
      db 'ir rezultata patalpina lasteleje C ir atspausdina ekrane',13,10,'$'
rez db 'Rezultatas: ','$'


duom    ends                                                            
                                                                        
program segment               
        assume  ss:stekas, ds:duom, cs:program                          
                                                                        
START:                        
         mov ax,duom          
         mov ds,ax                                                      
       
	;PROGRAMA                                                        
        ;isvalo ekrana                                                   
        mov ax,02h        
        int 10h           
	
	mov ah,09h
	lea dx,author
	int 21h
	
	mov ah,09h
	lea dx,intro
	int 21h	
	
	mov al,a
	mov bl,b
	mul bl 	
	
	mov cx,5
	mov si,4

atsakymas:     
             
	mov ah,0
	div des
	add ah,30h
	mov c[si],ah	
	
	cmp al,0
	je viskas

	dec si
	loop atsakymas
	
		
viskas:
	mov ah,09h
	lea dx,rez
	int 21h
		
	mov ah,09h
	lea dx,c
	int 21h
	
	                        
        mov ah, 07h     
        int 21h                              
                      
        mov ah,4Ch
        int 21h      
                     
program ends         
end start            
                     
        