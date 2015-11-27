;Kursinis darbas
;Uzduties Nr. 3.2
;Masyve t1 suskaiciuoti kiek yra raides A, o masyve t2 raides B
;masyvo pabaigos simbolis "*"
;Atliko: Gintaras Vaikutis II 0/3
stek segment stack         
        db 256 dup (0)     
stek ends                  
duom segment               
    	desimt db 10       
       	rez db '     ','$' 
       	mt1 db 'Masyvo T1 elementai: ','$'
       	mt2 db 10,13,'Masyvo T2 elementai: ','$'       	
        vp db 10,13,'Atliko: Gintaras Vaikutis II 0/3',10,13,'$'
       t1 db 'P','U','G','A','A','B','A','Q','*'
       t2 db 'Z','B','M','N','B','B','A','B','*'
       rez1 db '     ','$'
       ats1 db 10,13,'Masyve T1 raidziu "A" skaicius yra: ','$'
       ats2 db 10,13,'Masyve T2 raidziu "B" skaicius yra: ','$'
duom ends                                 
kurs5 segment                             
assume cs:kurs5, ds:duom                  
start:                                    
     mov ax,duom                          
     mov ds, ax                           
;Ekrano valymas                                          
        mov ax,0002h                                     
        int 10h     
; isvedimas   	              
        mov ah,09h
        lea dx,vp                    
        int 21h    
        mov si,0
        mov ah,09h
        lea dx,mt1
        int 21h   
        xor dx,dx  
        mov dl,t1[si]
spmast1:                
        cmp dl,'*' 
        je sp2    
        mov ah,02h 
        int 21h    
        inc si     
        mov dl,t1[si]
        jmp spmast1 
sp2:                
        mov ah,09h
        lea dx,mt2            
        int 21h             
        mov si,0   
        xor dx,dx  
        mov dl,t2[si]
spmast2:          
        cmp dl,'*' 
        je pradzia
        mov ah,02h 
        int 21h    
        inc si     
        mov dl,t2[si]
        jmp spmast2
 ; skaiciavimas                 
pradzia:              
     mov si,0
     xor ax,ax    
     xor bx,bx    
mas1:               
     mov dl,t1[si]
     cmp dl,'*'               
     je ant                   
     cmp dl,'A'               
     je sk   ;jei lygu                             
     inc si                   
     jmp mas1                 
sk:                           
     inc al                   
     inc si                   
     jmp mas1                 
ant:                          
     mov si,0                 
antras:                       
     mov dl,t2[si]            
     cmp dl,'*'               
     je des                   
     cmp dl,'B'               
     je sk2                   
     inc si                   
     jmp antras               
sk2:                          
     inc bl                   
     inc si                   
     jmp antras                           
des:                                      
     mov si,3
                                          
desim:                                    
                                          
       div desimt                                
       add ah,30h                         
       mov rez[si],ah                     
       dec si                             
       xor ah,ah                          
       cmp al,0                                    
       jne desim              
         
       mov ah,09h             
       lea dx,ats1  
       int 21h                
                    
       lea dx,rez                         
       int 21h                            
       	                                  
        mov al,bl                         
        xor ah,ah                         
        mov si,3
                                          
desi:                                     
                                          
       div desimt                                
       add ah,30h                         
       mov rez1[si],ah                    
       dec si                             
       xor ah,ah                          
       cmp al,0                                    
       jne desi                           
                
       mov ah,09h
       lea dx,ats2
       int 21h  
                
       lea dx,rez1                        
       int 21h                            
       	                                  
fin:                                      
     mov ah,07h                           
     int 21h                              
     mov ah,4ch                           
     int 21h                              
kurs5 ends                                
end start