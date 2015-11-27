;Parasyti programa kuri suskaiciuotu ir pateiktu rezultata 
;pagal formule (a+b+c)/ GrNr, kur a,b,c bet kokie skaiciai 
;su zenklu, aprasyti duomenu segmente. Priklausomai nuo 
;rezultato isvesti pranesimà ekrane “Rezultatas teigiamas” 
;arba “Rezultatas neigiamas
;Justas Gruodis

STK segment stack
db 256 dup(?)
STK ends

data segment
	a dw 10	,'$'
	b dw -30 ,'$'
	c dw -16,'$'
	two dw 2,'$'
	mone dw -1,'$'
	ten db 10,'$' 
	as db 0,'$' 
	ats db 3 dup  (?),10,13,'$'
	temp dw (?),'$'
	txt1 db  '(10-30-16)/2',13,10,'$'
        txt2 db  'Atsakymas neigiamas',13,10,'$' 
        txt3 db  'Atsakymas teigiamas',13,10,'$'    
 data ends             
                      
main segment          
	assume CS:main, DS:DATA, ss:stk
	start:   
	         
	  ; duomenu nuskaitymas       
	   mov ax, data
	   mov ds, ax
                 
          ; ekrano isvalymas        
	   mov ax,0002h    
	   int 10h 

	mov ah, 09h
	lea dx,txt1
	int 21h 
	       	 
	  ; skaiciavimas
           mov ax,0000h 
           mov dx,0000h            
	   mov ax , a           
	   add ax , b           
	   add ax, c            
	   idiv two             
	                        
	                        
          mov SI, 3            
          cmp al,0              
                jg positive     
                jl negative     
                                
 negative:       
	mov temp,ax                      
	mov ah, 09h
	lea dx, txt2
	int 21h                      
	mov ah, 02h 	; minusas
	mov dx, 2Dh              
	int 21h	                         
       	mov bx, -1
       	inc as 
	mov ax,temp             
	imul bx                 
	 mov dx,ax 
	 mov ax,0
	 mov al,dl
positive:  
     
      cmp al,10    
	jg skaic 
	jle gal  
skaic:              
	   div ten              
	   add ah, 30h		
	   mov ats[SI],ah       
	   dec SI
	   mov ah,0             	 	
	   cmp al,10	    	
  	   	jg positive 
  	   	je  gal
gal:	add al,30h          
	mov ats[si],al
cmp as,0
jne spaus
                      
mov ah, 09h
lea dx,txt3
int 21h  	
	  
	   
spaus:	   mov ah, 09h	
	   lea dx,ats
	   int 21h

	 ; ekrano sustabdymas
	   mov ah,07h
	   int 21h

	 ; grizimas i DOS   
	   mov ah, 4ch
	   int 21h
           
main ends   
end start