STEKAS SEGMENT STACK
	db 256 dup(?)	      
STEKAS ENDS
duom SEGMENT	;duomenu segmentas
a db 9
b db 8			      
c db 11 		      
dal db 10		      
rez db 4 dup(0),'$'	      
			      
prn db 10,13		      
			      
db 'Trecias laboratorinis darbas',10,13,'$'
prn2 db 10,13		      
db 'Skaiciuojame lygti x=(a^2+b)-c',10,13,'$'
			      
duom ends		      
			      
progr SEGMENT	;programos segmentas
			      
assume cs:progr, ds:duom, ss:stekas
start:			      
			      
mov ax,duom	 ;irasome duomenu segmento adreso pradzia i ds
mov ds,ax			 
				 
mov ax, 0002h	 ;isvalom ekrana 
int 10h 			 
				 
mov ah, 09h	 ;spausdinami pranesimai
lea dx,prn			 
int 21h 			 
				 
lea dx,prn2			 
int 21h 							
				 
				 
   mov al,a	 ;al=a                              
   mul a	 ;al=a*a         
   add al, b	 ;al=a*a+b       
   sub al, c	 ;al=(a*a+b)-c         
				 
				 
mov si, 3			  
atsakymas:			 
div dal 			 
add ah, 30h			 
mov rez[si], ah  ;masyvo skaitliukas
dec si		 ;sumazinam skaitliuka vienetu                  
mov ah, 0	 ;isvalom ah             
cmp al, 0			 
je isvedimas			 
jmp atsakymas		      
			      
isvedimas:		      
mov ah, 09h		      
lea dx, rez		      
int 21h 		      
			      
mov ah, 07h		      
int 21h 	 
		 
mov ah, 4ch	 
int 21h 	 
		 
progr ends	 
	end start