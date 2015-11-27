;---formule X=(a+b+c)-GrNr rez spausdinamas i ekrana
stekas segment stack
       db 256 dup (0)
 ends  stekas
                
duomenys segment
         a db 31  
         b db 1  
         c db 83    
         GrNr db 5
         desimt db 10    
         rez db 3 dup (0),'$'
         pran db 13,10,'(a+b+c)-GrNr = ','$'
duomenys ends                           
                                        
programa segment                        
         assume ds:duomenys, ss:stekas, cs:programa
  start: mov ax,duomenys                
         mov ds,ax                      
         mov ax,0                       
         mov al,a                       
         add al,b                       
         add al,c                       
         sub al,GrNr                    
                                        
         ;ciklas rezultato isvedimui            
         mov cx,3
         mov bx,0                       
         lea bx,rez+2
    L:   div desimt  
         add ah,30h
         mov [bx],ah                    
         mov ah,0                       
         dec bx                         
         loop L                         
                                        
         ; ekrano valymas               
         mov ax,0002h
         int 10h                        
                                        
         lea dx,pran
         mov ah,09h
         int 21h
         
         ; rezultato spausdinimas       
         lea dx,rez
         mov ah,09h                     
         int 21h                        
                                        
         mov ah,4ch                     
         int 21h                        
programa ends        
  end start          
                     
       