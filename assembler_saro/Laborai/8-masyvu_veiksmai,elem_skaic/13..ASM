stekas segment stack
db 256 dup(0)   
stekas ends     
          
duomenys segment
	mas db 1,5,2,20,18,19,1,17,20,5,9,13,12,8,2,11,7,5,84,13,5,2,8,4,12,'$'
	a db '$$$$'                     
	s dw '$$'     
          
pran    db 'Levaldas sukovas II-2/3',13,10
        db 'Programa skaiciuoja masyvo visu elementu suma, vidurki,',13,10
        db 'dvieju elementu sandauga ir skirtuma',13,10,13,10, '$'       
                        
pran2   db 'Suma: $'	
pran3	db ,13,10,'$'   
pranv	db 'Vidurkis: ', '$'
kabl    db ',', '$'     
prandg  db 'Sesto ir devinto elementu sandauga: $'
pransk  db 'Septinto ir dvidesimt trecio elementu skirtumas: $'
taskas	db '.','$'      
ats     db 'Atsakymas: ','$'
                        
neig    db ' Skaicius yra neigiamas $'   
                        
duomenys ends           
programa segment        
assume cs:programa, ds: duomenys, ss:stekas
start:                  
;inicializavimas        
	mov ax, duomenys
	mov ds,ax       
                        
	mov ax, 0002h   
	int 10h         
                        
; pranesimo isvedimas:  
	mov ah, 09h     
	lea dx, pran    
	int 21h         
                        
; skaiciavimai          
         mov cx,25         
	mov bl,0     	
	mov dx,0000h    
	mov ax,0000h    
        call suma       
	mov s, dx      
	     
                        
	mov bl,100      
	mov ax,dx       
	div bl          
	mov ch,ah         
       	add al,30h      
	mov a, al 
	                   
        mov ah,09h
        lea dx,pran2
        int 21h 
; isvedam pirma skaiciu 
	mov ah, 09h     
	lea dx, a       
	int 21h         
; antras ir trecias skaiciai
	                
        mov ax,0000h    
	mov al,ch       
	mov bl,10       
	div bl          
	mov ch,ah       
                        
                        
	add al,30h      
	mov a, al       
	mov ah, 09h     
	lea dx, a       
	int 21h         
                        
	add ch,30h      
	mov a, ch       
	mov ah, 09h     
	lea dx, a       
	int 21h         
                        
	mov ah, 09h     
	lea dx, pran3   
	int 21h         
                        
; skaiciuojam vidurki   
	mov ax,s        
	mov bl,25       
	div bl          
                        
; vidurkio isvedimas    
	mov cx,ax	
	        
	mov ah, 09h
	lea dx, pranv
	int 21h 
                
                
	mov ax,0000h
	mov al,cl
	mov bl,10
	div bl  
	mov cl,ah
	add al,30h
                
	mov a, al
	mov ah, 09h
	lea dx, a
	int 21h 
	        
	add cl,30h
	mov a, cl
	mov ah, 09h
	lea dx, a
	int 21h 
                
	mov ah, 09h
	lea dx, kabl
	int 21h 
                
	mov ax,0000h
	mov al,ch
	mov bl,10
	div bl  
	mov cl,ah
	add al,30h
                
	mov a, al
	mov ah, 09h
	lea dx, a
	int 21h 
	        
	add cl,30h
	mov a, cl
	mov ah, 09h
	lea dx, a
	int 21h 
                
	mov ah, 09h
	lea dx, pran3
	int 21h 
                
	mov ah, 09h
	lea dx, prandg
	int 21h 
                
; sesto ir devinto elementu sandauga
	mov al, mas[5]
	mul mas[8]
; ju isvedimas 	
	mov bl,100
	div bl 
	mov ch,ah ; issaugom
	       
	add al,30h
	mov a,al
	mov ah, 09h
	lea dx, a
	int 21h
	       
	mov ax,0000h
	mov al,ch
	mov bl,10 
	div bl 
	mov ch,ah
               
	add al,30h
	mov a,al
	mov ah, 09h
	lea dx, a
	int 21h
               
	add ch,30h
	mov a,ch
	mov ah, 09h
	lea dx, a
	int 21h
               
	mov ah, 09h
	lea dx, pran3
	int 21h
               
	       
	mov ah, 09h	
	lea dx, pransk
	int 21h
               
               
; 7 ir 23 elementu skirtumas
	mov bl,mas[6]       
	sub bl,mas[22]
	js neigiamas

	mov ax, 0000h
	mov al,bl
	mov bh,10
	div bh 
               
	mov ch,ah
               
               
               
; spausdinimas 
               
	       
               
	add al,30h
	mov a,al
	mov ah, 09h
	lea dx, a
	int 21h
               
	add ch,30h
	mov a,ch
	mov ah, 09h
	lea dx, a
	int 21h
               
neigiamas: 
        mov ah,09h
        lea dx,neig
        int 21h             
               
; programos pabaiga
	mov ah, 09h
	lea dx, pran3
	int 21h
	mov ah, 07h
	int 21h
	mov ah,4ch
     	int 21h
     	     
suma proc     
      cikl:                   
	mov al,mas[bx]  
	add dx,ax       
	inc bl          
	loop cikl
	RET         
suma endp	       
	       
programa ends 
end start
        
