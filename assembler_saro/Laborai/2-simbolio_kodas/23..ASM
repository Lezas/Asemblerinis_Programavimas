 Stekas SEGMENT STACK        
db 256 dup (?)              
ENDS Stekas                  
                            
DATA SEGMENT                 
        a db '065'
        des db 10            
        rez db  1 dup(0),'$'
pran db 'Ketvirtas laboratorinis darbas', 10,13, '$'
rezultatas db'Simbolio kodas: ','$'
ENDS DATA                    
                             
COM SEGMENT                                   
ASSUME ss:Stekas, ds:DATA, cs:COM 
                             
START:                       
        mov ax, DATA         
        mov ds, ax                
                            
        mov ax, 0002h    ;isvalome ekrana          
        int 10h             
                                         
       mov ah,09h      ;pranesimo rodymas                             
       lea dx,pran                              
       int 21h
                                   
       sub a[0], 30h        
       sub a[1], 30h        
       sub a[2], 30h        
                            
       mov al, a[0]         
       mul des              
       add al, a[1]         
       mul des              
       add al, a[2]         
       mov rez, al          
                            
       mov ah,09h       ;pranesimo rodymas                           
       lea dx,rezultatas                              
       int 21h                    
                                          
       mov ah, 09h      ;isvedimas:   
       lea dx, rez
       int 21h                                    
                 
       mov ah,07h       ;laukiamas klaviso paspaudimas
       int 21h   

       mov ax,4C00h
       int 21h   
                 
ENDS COM         
END START               
         