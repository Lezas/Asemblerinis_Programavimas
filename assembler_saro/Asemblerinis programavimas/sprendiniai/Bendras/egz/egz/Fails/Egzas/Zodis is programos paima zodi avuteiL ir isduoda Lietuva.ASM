stekas segment stack    
      db 256 dup (?)    
ends stekas             
         
duomenys segment        
         text3 db 'Zodelis atvirksciai:','$'  
         zodis db 8 dup ('*'),'$'
         text db 'avuteiL',10,13,'$'
         text2 db 'Tai perskaicius is kito galo gaunasi patriotinis zodis:',10,13,'$'
                                                                  
ends duomenys           
                        
programa segment        
         assume ds:duomenys, ss:stekas, cs: programa
 start:  mov ax,duomenys
         mov ds,ax      
                       
         ;ekrano valymas               
         mov ax,0002h           
         int 10h
             
         ;spausdina raidziu kratini
         mov ah,09h    
         lea dx,text3   
         int 21h 
         
         mov ah,09h    
         lea dx,text   
         int 21h        
                        
         mov ah, 09h    
         lea dx,text2   
         int 21h        
                            
         lea bx,text    
         lea si,zodis+7
                        
                        
        cikling:        
         mov al,[bx]    
         mov [si],al    
         inc bx         
         dec si         
         loop cikling   
        ;spausdina rezultatus
       
         mov ah,09h     
         lea dx,zodis     
         int 21h        
         mov ah,07h     
         int 21h        
         mov ah,4ch     
         int 21h
         
                  
                                             
                          
ends programa                               
 end start 