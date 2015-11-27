stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment                        
  pran  db "Darius Jurkenas II-3/1", 10,13
           db "Dvizenkliu skaiciu ivedimas is klaviaturos",10,13
           db "Formules skaiciavimas: X=(A+B)C",10,13
     	text1 db 'iveskite skaiciu A: ','$'
	text2 db 10,13,'iveskite skaiciu B: ','$'
	text3 db 10,13,'iveskite skaiciu C: ','$'
	ats db 10,13,'     X=','$'
	 a db 3,?,2 dup(?),'$'          
	 b db 3,?,2 dup(?),'$'
 	 c db 3,?,2 dup(?),'$'
	 x db 0
     dsmt db 10
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
         
         
;isvalome ekrana
mov ax,02h      
int 10h         
                
;isvedamas pran - programos salyga
  mov ah,09h                                       
  lea dx,pran
  int 21h     
                                 
;isveda prasyma ivesti skaiciu A
mov ah, 09h
lea dx,text1
int 21h  
         
;nuskaito skaiciu A 
mov ah,0ah
lea dx, a                    
int 21h                      
         
;isveda prasyma ivesti skaiciu B
mov ah, 09h
lea dx,text2
int 21h  
;nuskaito skaiciu B 
mov ah,0ah
lea dx, b
int 21h  
         
;isveda prasyma ivesti skaiciu B 
mov ah, 09h
lea dx,text3
int 21h  
;nuskaito skaiciu B
mov ah,0ah
lea dx, c
int 21h  
                             
xor cx,cx                    
xor dx,dx
mov cl, a+1
mov ax, 0
inc si

ciklas1:
        sub cl, 1
       	inc si
	mov al, a+[si]
	sub al, 30h	
        mov x,cl                 
        cmp cl,0   
        je bai1
 	       	des1:
	      	     	mul dsmt
			sub cl, 1
			cmp cl, 0
			jne des1
			bai1:   
                                
mov cl,x                        
add dx, ax                      
cmp cl,0                        
jne ciklas1                     
mov aa, dx                      
                                
xor cx,cx                       
xor dx,dx                       
xor si,si                       
mov cl, b+1                     
mov ax, 0                        
inc si                          
                                
ciklas2:                        
        sub cl, 1               
       	inc si                  
	mov al, b+[si]          
	sub al, 30h	        
        mov x,cl                
        cmp cl,0                
        je bai2                 
 	       	des2:           
	      	     	mul dsmt
		    	sub cl, 1
			cmp cl, 0
			jne des2
			bai2:   
                                
mov cl,x                        
add dx, ax                      
cmp cl,0                         
jne ciklas2                     
mov bb, dx                      
                                
xor cx,cx                       
xor dx,dx                       
xor si,si                       
mov cl, c+1                     
mov ax, 0                       
inc si                          
                                
ciklas3:                        
        sub cl, 1               
       	inc si                  
	mov al, c+[si]          
	sub al, 30h	        
        mov x,cl                
        cmp cl,0                
        je bai3              
 	      	des3:        
	  	     	mul dsmt
		    	sub cl, 1
			cmp cl, 0
			jne des3
	       		bai3:
                                 
mov cl,x                         
add dx, ax                       
cmp cl,0                         
jne ciklas3                      
mov cc, dx                       
                                
xor ax,ax                       
mov ax,aa                       
add ax,bb                       
mul cc                          
mov xx, ax                      
                                
                                
suba:                      
cmp ax, 9                       
jle sub2                
sub ax, 10                      
inc bx                          
jmp suba                  
                                
sub2:                    
add ax, 30h    
mov f, ax      
xor ax,ax                    
               
sub1:    
cmp bx, 9      
jle sub4
sub bx, 10     
inc ax         
jmp sub1
               
sub4:   
add bx, 30h    
mov e, bx      
xor bx,bx      
               
sub3:    
cmp ax, 9      
jle spausdinimas
sub ax, 10     
inc bx         
jmp sub3 


;isvedame atsakyma po viena skaitmeni                             
spausdinimas:                        
add ax, 30h                          
mov g, ax                            
xor ax,ax                            
                                     
add bx, 30h                          
mov h, bx                            
xor bx,bx                            
                                     
mov ah, 09h                          
lea dx,ats                           
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
                             
mov ah, 07h                  
int 21h                      
                             
mov ah,4ch                   
int 21h                      
                             
programa ends                
end start                    
                             
                             
                             
                             
                             
                             
