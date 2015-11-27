stekas segment stack    
      db 256 dup (?)    
ends stekas             
 
duomenys segment     
         des db 10             
         zodis db 26,?,25 dup (0),'$'
         rezul db 25 dup (0),'$'     
         text db 'iveskite zodi iki 25 simboliu','$'
         text2 db  'ivesta simboliu:','$'
         bufer dw 0, '$'
                                                                  
ends duomenys           
                        
programa segment        
         assume ds:duomenys, ss:stekas, cs: programa
 start:  mov ax,duomenys
         mov ds,ax      
                       
         ;ekrano valymas               
         mov ax,0002h           
         int 10h                
                       
         ;zodzio ivedimas 
         mov ah,09h       
         lea dx,text      
         int 21h          
         
         mov ah,02h
         mov dh,2
         mov dl,00
         int 21h
         
         mov ah,0Ah       
         lea dx,zodis     
         int 21h         
                  
         ;valom ekrana              
         mov ax,0002h
         int 10h     
                  
         mov ch,0    
         mov cl,zodis
         dec cx   
         lea di,zodis+26
         lea si,rezul
         ciklinam:
         mov al,[di]
         mov [si],al
         inc si   
         dec di   
         loop ciklinam
         ;skaitliukas
         mov ax,0      
         mov al,zodis+1
         div des       
         add ah,30h    
         add al,30h    
         mov bufer,ax  
        ;rezultatai    
                         
         mov ah,02h
         mov dh,10
         mov dl,35
         int 10h  
                  
         mov ah,09h
         lea dx,rezul
         int 21h     
                  
         mov ah,02h
         mov dh,11
         mov dl,35
         int 10h  
                  
         mov ah,09h
         lea dx,text2
         int 21h  
                  
         mov ah,02h
         mov dh,11
         mov dl,52
         int 10h         
                  
         mov ah,09h
         lea dx,bufer
         int 21h  
                  
         mov ah,07h
         int 21h  
         mov ah,4ch
         int 21h  
                  
 ends programa                               
 end start 