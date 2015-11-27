stekas segment stack    
      db 256 dup (?)    
ends stekas             
                        
t equ 13                
d equ 10                
                        
duomenys segment        
         sk db 28   
         zodis db 28 dup ('*'),'$'
         pran db t,d,'samaduailetsupokaiksikisap','$'
         pran1 db t,d,'Tai perskaicius is kito galo gaunas:',t,d,'$'
                        
ends duomenys           
                        
programa segment        
         assume ds:duomenys, ss:stekas, cs: programa
 start:  mov ax,duomenys
         mov ds,ax      
                        
         mov ax,0002h ;ekrano valymas                      
         int 10h                     
                                    
         mov ah,09h   ;ismeta raidziu kratini
         lea dx,pran                         
         int 21h        
                        
         mov ah, 09h    
         lea dx,pran1   
         int 21h        
                            
         lea bx,pran    
         lea si,zodis+27
         mov cx,0       
         mov cl,sk    
                        
     L:  mov al,[bx]    
         mov [si],al    
         inc bx         
         dec si         
         loop L         
                            
         mov ah,09h ; isveda zodi
         lea dx,zodis 
         int 21h                            
                                            
         mov ah,4ch                          
         int 21h                             
ends programa                               
 end start 