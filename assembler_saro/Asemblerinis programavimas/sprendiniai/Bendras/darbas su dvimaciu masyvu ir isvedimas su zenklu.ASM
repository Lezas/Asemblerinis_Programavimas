     
stekas segment stack                
       db 256 dup (0)                                                         
ends stekas                                                                                                                                     
                                                                     
duomenys segment 
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'                                                             
mas db 0,1,2,3,1,1,'$'
sign db '-','$' 
suma db 3 dup (0),'$'
ats db 0 ,'$'
ends duomenys                     
                                  
programa segment                  
         assume ds:duomenys, cs:programa, ss:stekas 
  start: mov ax,duomenys          
         mov ds,ax
         mov ax,02h
         int 10h
         
   mov ah,09h
   lea dx,pran
   int 21h
         lea si,mas
          mov  si,0
          mov bx,0           
 mov cx,3 ;3 kartus suksime ciklas
   ciklas1:  
   push cx
   mov cx,2
   mov al,0
   ciklas2:   
   add al,mas[si]
   inc si
   mov suma[bx],al   
   loop ciklas2
   pop cx
   inc bx  
   loop ciklas1 ; 3 kartus
   mov bx,0
   mov cx,2
   mov al,suma[0]
   atimt:
   inc bx    
   sub al,suma[bx]
   mov ats,al
   loop atimt
   cmp ats,0
   jge pabaiga 
   mov ah,09h
   lea dx,sign
   int 21h
   pabaiga:
   neg ats
   add ats,30h
   mov ah,09h
   lea dx,ats
   int 21h
   mov ah,07h
   int 21h 
                                                
 mov ah,4ch     
 int 21h        
programa ends                                                   
 end start                                                      
     