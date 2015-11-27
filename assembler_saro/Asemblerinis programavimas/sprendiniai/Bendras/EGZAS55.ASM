stekas segment STACK                                       
 	db 256 dup(?)                                     
stekas	ENDS                                                                                
duom segment                                                    
pran    db 'dividing Dvieju ',10,13,'$'	
a       dw 80               
b       dw 40               
 
x       dw ?
rez     dw 2 dup(0),'$'
d       db 10
duom ends                                                       
                                                                
prog segment
     	assume  ss:stekas, ds:duom, cs: prog
start:
        mov ax,duom
        mov ds,ax
        
      mov ax,2h
      int 10h       
      
      
      mov ax,a
      div b 
      mov x,ax
              
        mov DX,0
        div d   
        mov rez+1,ax
        add rez+1,30h
        mov Ax, 0  
        mov DX,0
        div d   
        mov rez,ax
        add rez,30h
              
      mov ah,09h
      lea dx, pran
      int 21h
     lea dx, rez
     int 21h
      lea dx,x
      int 21h
                         
 	;Ekrano uzlaikymas  
 	mov ah,07h
 	int 21h                       
 	                                  
                                                   
        ;Programnos pertraukimas                                                        
	mov ah,4ch
	int 21h
	                                                
                                                                
prog ends      
	end start
                                                                

      
            
        
        