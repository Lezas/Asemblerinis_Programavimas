stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
  tekstas  db "Rasa Simonaviciute II-3/3", 10,13
           db "Dvizenkliu skaiciu ivedimas is klaviaturos",10,13
           db "Formules skaiciavimas: X=(A+B)C",10,13
	t1 db 'iveskite skaiciu A: ','$'
	t2 db 10,13,'iveskite skaiciu B: ','$'
	t3 db 10,13,'iveskite skaiciu C: ','$'
	t4 db 10,13,'     X=','$'
	 a db 3,?,2 dup(?),'$'
	 b db 3,?,2 dup(?),'$'
	 c db 3,?,2 dup(?),'$'
	 x db 0
     saule db 10
	aa dw 0
	bb dw 0
	cc dw 0
	xx dw 0
	 h dw 0,'$'
	 e dw 0,'$'
	 g dw 0,'$'
	 f dw 0,'$'
duomenys ends
         
programa segment
assume cs: programa, ds:duomenys, ss:stekas


start:   
mov ax,duomenys
mov ds,ax


;isvakyti ekrana
mov ax,02h
int 10h

;rodomas tekstas
  mov ah,09h                                       
  lea dx,tekstas  
  int 21h     

;skaiciaus a aprasymas
mov ah, 09h
lea dx,t1
int 21h 

mov ah,0ah
lea dx, a
int 21h

;skaiciaus b aprasymas
mov ah, 09h
lea dx,t2
int 21h 

mov ah,0ah
lea dx, b
int 21h

;skaiciaus c aprasymas
mov ah, 09h
lea dx,t3
int 21h 

mov ah,0ah
lea dx, c
int 21h

xor cx,cx
xor dx,dx
mov cl, a+1
mov ax, 0
inc si

ciklasa:
        sub cl, 1
      	inc si
	mov al, a+[si]
	sub al, 30h	
        mov x,cl
        cmp cl,0 
        je baia
 	      	desa:
		     	mul saule
			sub cl, 1
			cmp cl, 0
			jne desa
			baia:  
                               
mov cl,x                       
add dx, ax                     
cmp cl,0                       
jne ciklasa                    
mov aa, dx                     
                               
xor cx,cx                      
xor dx,dx                      
xor si,si                      
mov cl, b+1                    
mov ax, 0                      
inc si                         
                               
ciklasb:                      
        sub cl, 1              
      	inc si
	mov al, b+[si]
	sub al, 30h	
        mov x,cl
        cmp cl,0 
        je baib
 	      	desb:
		     	mul saule
			sub cl, 1
			cmp cl, 0
			jne desb
			baib:  
                               
mov cl,x                       
add dx, ax                     
cmp cl,0                    
jne ciklasb                 
mov bb, dx                  
                            
xor cx,cx                   
xor dx,dx                   
xor si,si                   
mov cl, c+1                 
mov ax, 0                
inc si                   
                         
ciklasc:                
        sub cl, 1        
	inc si
	mov al, c+[si]
	sub al, 30h	
        mov x,cl
        cmp cl,0 
        je baic
 		desc:
			mul saule
			sub cl, 1
			cmp cl, 0
			jne desc
			baic:

mov cl,x
add dx, ax
cmp cl,0
jne ciklasc
mov cc, dx 

xor ax,ax
mov ax,aa
add ax,bb
mul cc
mov xx, ax


lyginimas:
cmp ax, 9
jle lyginimas11
sub ax, 10
inc bx
jmp lyginimas

lyginimas11:
add ax, 30h
mov f, ax
xor ax,ax

lyginimas1:
cmp bx, 9
jle lyginimas22
sub bx, 10
inc ax
jmp lyginimas1

lyginimas22:
add bx, 30h
mov e, bx
xor bx,bx

lyginimas2:
cmp ax, 9
jle spausdinimas
sub ax, 10
inc bx
jmp lyginimas2

spausdinimas:
add ax, 30h
mov g, ax
xor ax,ax

add bx, 30h
mov h, bx
xor bx,bx

mov ah, 09h
lea dx,t4
int 21h 

mov ah, 09h
lea dx, h
int 21h 

mov ah, 09h
lea dx, g
int 21h 

mov ah, 09h
lea dx, e
int 21h 

mov ah, 09h
lea dx, f
int 21h 

pabaiga:
         
;laukia klav paspaudimo
mov ah, 07h
int 21h  
         
;programos pabaiga
mov ah,4ch
int 21h  
         
programa ends
end start






