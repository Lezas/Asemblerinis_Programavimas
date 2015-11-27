stekas segment stack
        db 512 dup (0)
stekas ends          
                    
duomenys segment    
        pranesimas1 db '                       Alius Dainauskas II-v4', 13, 10, 13, 10
                    db '                           Uzduotis Nr. 2', 13, 10 ,13, 10, '$'
        lygunuliui db '                            Atsakymas = 0',13,10,13,10, '$'
        spausk1 db '           Jei norite testi spauskite bet kuri klavisa',13,10,10,13, '$'
        geras db '                           Atsakymas = ','$'
        neigiamas db '                         Atsakymas = -','$'
        sk db 5
        skb db 5
        mas db 1 dup (0), '$'
                
                            
        duomenys ends
                                                                       
programa segment                                                                     
assume  ss: stekas, ds: duomenys, cs: programa 
                                               
start:                        
        mov ax, duomenys 
        mov ds, ax
             
        mov ax, 0002h ;issivalau ekrana
        int 10h                        
                                       
        mov ah, 09h    ;isvedu 1 pranesima                  
        lea dx, pranesimas1               
        int 21h                           
                                          
        jmp tikrinimas
                      
        tikrinimas:   
        mov ah, sk    
        cmp ah, skb
        jz nulis
        jg daugiau
        jl maziau
        nulis:
        mov ah, 09h
        lea dx, spausk1
        int 21h
        mov ah, 07h
        int 21h
        mov ah, 09h
        lea dx, lygunuliui  
        int 21h
        jmp pabaiga
              
        daugiau:
        mov ah, 09h
        lea dx, spausk1
        int 21h
        mov ah, 07h
        int 21h
       mov ah, 0
       mov al, 0
        mov ah, sk
        mov al, skb
        sub ah, al
        add ah, 30h
        mov mas, ah
        mov ah, 09h
        lea dx, neigiamas
        int 21h    
        mov ah, 09h   
        lea dx, mas
        int 21h
        jmp pabaiga
             
             
             
        maziau:
        mov ah, 09h
        lea dx, spausk1
        int 21h
        mov ah, 07h
        int 21h
       mov ah, 0
       mov al, 0
        mov ah, sk
        mov al, skb
        sub al, ah
        add al, 30h
        mov mas, al
        mov ah, 09h
        lea dx, geras
        int 21h
        mov ah, 09h   
        lea dx, mas
        int 21h
        jmp pabaiga
        
        pabaiga:
        mov ah, 07h
        int 21h 
        mov ah, 4ch
        int 21h
        
       ; skaiciavimas:
       ; mov ah, 0      ;uznulinam ah   
       ; mov al, sk     ;i al ikeliam sk
       ; mov ah, skb    ;i ah ikeliam skb
       ; sub al, ah     ;atliekam atimti rezultata gaunam ah                 
       ; add ah, 30h    ;davedam iki 10-ainio sk                                   
       ; mov mas, ah    ;ikeliam rezultata i masyva                        
       ; mov ah, 0      ;uznulinam ah                           
        
       ; mov ah, 09h    ;isvedu rezultata i ekrana
       ; lea dx, mas                 
       ; int 21h
        
       ; mov ah, 07h
       ; int 21h                                   
       ; mov ah, 4ch                            
       ; int 21h                                                             
                              
programa ends                                  
                              
end start