;priklausomai nuo rezultato isveda pranesimus
; formule: X=2ab
stekas segment stack
       db 256 dup (0)
       ends stekas  
                    
duomenys segment    
         a db ?
         b db ?  
         x dw ?
         du db 2
         pran1 db 13,10, 'Atsakymas teigiamas','$'
         pran2 db 13,10, 'Atsakymas neigiamas','$'   
         pran3 db 13,10, 'Atsakymas lygus 0','$'     
duomenys ends                         
                                      
programa segment                      
         assume ds: duomenys, ss: stekas, cs:programa
  start: mov ax,duomenys              
         mov ds,ax
          
         mov ax,0002h ;ekrano valymas                      
         int 10h
                            
         mov dx,0
         mov ax,0                     
         mov al,a  
         imul b
         imul du
         mov x,ax
         cmp ax,0
         jg z1
         jl z2
         lea dx,pran3 ;rezultatas lygus 0
         mov ah,09h   ;pran3 isveda i ekrana
         int 21h
         mov ah,4ch
         int 21h
          
     z1: lea dx,pran1 ;rezultatas teigiamas
         mov ah,09h                     
         int 21h                        
         mov ah,4ch                         
         int 21h                            
                                            
     z2: lea dx,pran2 ; rezultatas neigiamas                   
         mov ah,09h                     
         int 21h                        
         mov ah,4ch                     
         int 21h                        
programa ends                           
         end start