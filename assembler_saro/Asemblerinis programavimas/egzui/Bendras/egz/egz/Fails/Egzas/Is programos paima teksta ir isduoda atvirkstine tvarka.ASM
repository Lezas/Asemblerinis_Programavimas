stekas segment stack
        db 256 dup (?)
stekas ends    
               
duomenys segment
text db 'Love you my Love',10,13, '$';mes teksta is galo
rez db 11 dup (?),10,13,'$'    
pran db 'atvirksciai:) ','$' 
               
duomenys ends       
                    
programa segment    
assume cs:programa, ds:duomenys, ss:stekas 
 start:                              
                        
        mov ax, duomenys
        mov ds, ax      
                        
        mov ax, 02h          
        int 10h         
                        
        lea bx,text     
        lea si, rez ; segmentini registras adresams saugoti    
        add si, 10  ;dadeda 10 lasteliu    
        mov cx, 10      
                        
        cikl:           
        mov ah, [bx] ; i ah atkele adresa kuris yra nurodytas bx   
        mov [si], ah ;ah jjau yra textas, ir ji atkele i adresa kuris yra si lasteleje    
        inc bx  ;mazina vienetu        
        dec si                 ;dina viwentu
        loop cikl       
          ;isvedimass i ekrana
         mov ah,02h
         mov bx,0
         mov dh, 12
         mov dl, 35
         int 10h
         
         mov ah,09h           
         lea dx,text          
         int 21h     
        ;kursoriaus padetis  
        mov ah,02h ;komandos kodas irasomas i ah
         mov bx,0 ;lapo nr
         mov dh, 13 ;eilutes
         mov dl, 34;stulpeliai
         int 10h ; [pertraukimas
         
         mov ah, 09h
         lea dx, pran
         int 21h
         
          mov ah,02h
         mov bx,0
         mov dh, 14
         mov dl, 34
         int 10h
                 
         mov  ah, 09h         
         lea dx, rez          
         int 21h               
                              
                              
                              
 ;**************************************   
     ;pabaiga             
                                     
        mov ah, 07h           
        int 21h               
                              
        mov ah, 4ch
        int 21h  
         
programa ends     
end start