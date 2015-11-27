;sudeda du dvizenklius skaicius 
stekas segment stack                                        
db 256 dup(?)                                               
stekas ends                                                 
                                                            
        duomenys segment                                    
        pranesimas db 'sudesime 2 skaicius',10,13,'$'
        rez db 'rezultatas',10,13,'$'
        a db 200                     
        b db 11  
        ats db ?, '$'  
        Suma dd ?,10,13,'$'
  SUMA1 db 8 dup(?),10,13,'$'
k db 10                  
        duomenys ends                                       
                                                            
        programa segment                                    
        ASSUME cs: programa, ds: duomenys, ss: stekas       
                                                            
                                                            
                                                            
        start:                                              
                                                            
                 mov ax,duomenys                            
                 mov ds,ax                                  
                                                            
                 mov ax,0002h ;ekrano isvalymas             
                 int 10h                                    
                                                            
                 mov ah,02h           ;kursoriaus nustatymas
                 mov dh,1             ;eilutes nr
                 mov dl,20            ; stulpelio nr
                 int 10h             
                                     
                 mov ah, 09h         
                 lea dx,pranesimas   
                 int 21h             
                                     
               xor ax,ax                      
               mov al,a              
               ;add bh,b  
             
        add al,b      ; prie al  pridedam mas[si]  si-taji elementa
        ;inc Si             
        ;loop CIKLAS4        ; sukam cikla, taip gaudami mas suma al'e 
                           
;====================SUMA ISVEDAM I EKRANA========================================     
        mov di,3           
        mov byte ptr Suma,al
ciklas6:                   
        div k                  
        add AH,30h          ; gaunam liekana ir prie jos pridedam 30h     
        mov SUMA1[di],ah    ; pradedam atsakyma irasinet nuo galo    
        xor ah,ah           ; apnulinam ah    
        cmp al,0            ; lyginam al su 0              
        je baigt            ; jei al=0 tai baikt    
        dec di              ; kitu atveju    
        jmp ciklas6     


            baigt:
            
                    mov ah,09h
               lea dx,SUMA1+1         ; isvedam masyvo vidurki  
                    int 21h
                                 
                                     
                                     
                 mov ah, 07h         
                 int 21h
                        
                 mov ah, 4ch
                 int 21h
                 
        programa ends
        end start 