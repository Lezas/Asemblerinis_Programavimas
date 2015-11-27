stekas SEGMENT STACK           
        DB 256 dup(?)          
stekas ENDS                    
                               
data SEGMENT                   
   pran	db 'Kursinis darbas - trecioji uzduotis',10,13
        db 'Uzduoties nr.: 4',10,13    
        db 'Uzduotis: programa atspausdina masyvo eilutes atbuline tvarka.',10,13
        db 'Atliko: Karolis Kairaitis, II-2/2',10,13,13,13,10,'$'         
    mas db 'tralialia',13,10
        db 'mumu',13,10
        db 'popa',13,10
        db 'kuku',13,10,'$'
    n   db 2 dup(0),'$'                   
    nt   db 2 dup(0),'$'   
    s   db 1 dup(0),'$'
    ats db 13,10,'Atvirksciai: ',13,10,10,'$'
    neil db 80 dup(' '),13,'$'
                                                                         
data ENDS                                                                
                                                                         
programa SEGMENT                                                         
        ASSUME DS: data, CS: programa, SS: stekas                        
START:                                                     
                                                 
        MOV AX,DATA                                                                                                                             
        MOV DS,AX                                                                                                                               
                                                                                                                                                
        MOV AX,0002H                                                                                                                            
        INT 10H                                                                                                                                 
                                                                                                                                                
        ;Pranesimu spausdinimas                                                                                                                 
        MOV AH,09H                                                                                                                              
        LEA DX,pran                                                                                                                             
        INT 21H                
                               
        LEA DX,mas             
        int 21h                
                               
        LEA DX,ats             
        INT 21h                
                       
        ; Nusistatome pradinio masyvo gala
        lea si,mas             
        dar:      
                          
        ;Naujos(laikinosios) eilutes isvalymas
        lea di,neil         
        mov cl,80 
        clr:                
        mov bh,' '          
        mov [di],bh            
        inc di              
        loop clr            
                            
        add s,1                
        mov nt,0            
         
        ;Ieskom eilutes pabaigos
        mov ah,13              
        plius:                       
        inc si                       
        add n,1                
        add nt,1                      
        cmp [si],ah                  
        JNE plius                    
                               
        ;Naujos, apverstos eilutes formavimas
        dec si                 
        mov cx,0               
        lea di,neil            
        mov cl,nt                     
        cik:                         
        mov bh,[si]            
        mov [di],bh            
        dec si                       
        inc di                       
        loop cik               
                               
        ;Apverstos eilutes spausdinimas
        mov ah,09h             
        lea dx,neil            
        int 21h                
                               
        ;Nusikeliam SI i atspausdintu elem. gala
        mov cx,0               
        lea si,mas             
        mov cl,n               
        did:                   
        inc si                 
        loop did               
                               
        cmp s,4
        JNE dar             
                            
pabaiga:                                            
        MOV AH,07H                                  
        INT 21H                     
        MOV AH,4CH                  
        INT 21H   
                 
programa ENDS
END START