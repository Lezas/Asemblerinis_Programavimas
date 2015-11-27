stekas segment stack
       db 256 dup()
       ends stekas
                  
duomenys segment   
         x db 1,2,1,2
           db 3,4,2,9                                                 
           db 5,7,3,5
           db 8,8,1,0
         sk db 0  
         c db 0
         pran db 13,10,'Skaicius eiluciu, kuriu I-asis elementas pasikartoja',13,10,'$'
 duomenys ends                                        
                                                      
programa segment                                      
         assume ds:duomenys,ss:stekas,cs:programa     
start: mov ax,duomenys                                
       mov ds,ax                                      
                                                      
       mov ax,0002h ;ekrano valymas                   
       int 10h                                        
                                                      
       mov ax,0
       mov bx,0
       mov dx,0
       mov cx,0
       mov cl,4
       mov c,cl
       ; pereina i kita eilute                        
    D: mov al,x+[bx]
       mov si,0     
       mov cx,0                                  
       mov cl,4                                       
       ; eina eiluteje per stulpelius
    M: inc si                                         
       mov dl,x+[si]+[bx]    
       cmp ax,dx
       je S
       loop M
    G: add bl,4
       mov cl,c
       dec c
       loop D                                         
       jmp P   ;soka i prieki
                                                      
       ; padidina skaitliuka                          
    S: add sk,1
       jmp G
               
    P: mov dx,0
       mov ah,09h                                     
       lea dx,pran                                    
       int 21h
       
       mov dx,0
       mov dl,sk 
       add dl,30h
       mov ah,02h
       int 21h
                             
       mov ah,4ch            
       int 21h               
programa ends                
end start                    
                             
                             
       