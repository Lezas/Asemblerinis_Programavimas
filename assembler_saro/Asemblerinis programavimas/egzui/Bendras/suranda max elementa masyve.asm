;Is masyvo, kuriame yra 30 elementu, isrenkamas didziausias elementas
stekas segment stack                
    db 256 dup (0)
ends stekas                                                                   
cr equ 10
lf equ 13                                                                      
duomenys segment                                                              
         a db 112,1,1,1,1,1
           db 1,4,8,115,1,1
           db 1,2,1,6,79,74   
           db 1,118,1,120,1   
           db 1,1,1,1,1,17                                  
         pran1 db 'Didziausias elementas is 5*6 masyvo',lf,cr,'$'
         sk db 4 dup (?),'$'                                 
         desimt db 10                                        
ends duomenys                                                
                                                             
programa segment                                             
         assume ds:duomenys, cs:programa, ss:stekas          
  start: mov ax,duomenys                                     
         mov ds,ax                                           
                                                             
         ;ekrano valymas                                     
         mov ax,0002h                                        
         int 10h                                             
                                                             
    mov ax,0                                                 
    mov cx,30  ;30 kartus suksime cikla                      
    mov bx,0                                                 
                                                             
    mov al,a[bx] ;issaugomas pirmos eilutes pirmas elementas 
  ciklas:                                                    
       cmp a[bx],al                                          
       jb L    ;jeigu mazesnis
       mov al,a[bx]                                          
      L:                                                     
       inc bx ;prideda po viena                              
       loop ciklas                                           
       mov sk,al                                             
                                                             
       ;rez vertimas i kodus                                 
       mov cx,3                                              
       lea bx,sk+2
   ats:
        mov ah,0                                             
        div desimt                                           
        add ah,30h                                           
        mov [bx],ah                                          
        dec bx                                               
        loop ats                                             
                                                             
        ;pranesimo spausdinimas                              
        mov ah,09h                                           
        lea dx,pran1                                         
        int 21h                                              
                                                             
        ;spausdiname ats                                     
        mov ah,09h                                           
        lea dx,sk                                            
        int 21h                                              
                                                             
        ;laukiame klaviso paspaudimo                         
        mov ah,07h
       int 21h
                                                             
         mov ah,4ch                                          
         int 21h                                             
programa ends                                                   
 end start                                                      
     