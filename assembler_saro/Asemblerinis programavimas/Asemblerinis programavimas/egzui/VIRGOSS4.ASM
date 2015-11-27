;---formule X=a^2+2ab+b^2 rez spausdinamas i ekrana
stekas segment stack
       db 256 dup (0)
 ends  stekas
                
duomenys segment
         a db 11
         b db 14
         desimt db 10    
         du db 2         
         rez db 5 dup (0),'$'
duomenys ends   
                 
programa segment
         assume ds:duomenys, ss:stekas, cs:programa
  start: mov ax,duomenys
         mov ds,ax 
         mov ax,0  
         mov bx,0  
         mov al,a  
         mul a     
         mov bx,ax
         mov ax,0 
         mov al,a
         mul b     
         mul du   
         add bx,ax 
         mov ax,0 
         mov al,b 
         mul b    
         add ax,bx  
         
         ;ciklas rezultato isvedimui            
         mov cx,5
         mov bx,0               
         lea bx,rez+4 
    L:   div desimt 
         add ah,30h 
         mov [bx],ah
         mov ah,0  
         dec bx 
         loop L
         
         ;rezultato spausdinimas 
         lea dx,rez
         mov ah,09h
         int 21h 
          
         mov ah,4ch         
         int 21h     
programa ends 
  end start         
                
       