stekas segment stack            
db 256 dup (?)
stekas ends
      
duom segment
txt1 db ' Laba diena,',13,10,13,10
     db ' Cia programa, kuria padare Raimondas Rimkevicius',13,10
     db 'ir Saulius Margelevicius ish labai shaunios grupes II-2/3',13,10,'$'
txt2 db 'Iveskite savo varda: ','$'
txt3 db 'Iveskite savo pavarde: ','$'
txt4 db 'Iveskite savo grupe: ','$'
txt5 db 'Rezultatai: ','$'
tarpas db ' ','$'
nl db 10,13,'$'                 
pavarde db 21 dup (' '),13,'$'
vardas db 15 dup (' '),13,'$'
grupe db 10 dup (' '),13,'$' 
praide db ?                      
pabaiga db ?,'$'                 
info db 15,15 dup (?),'$'        
kiek db 0                        
duom ends                        
                                 
program segment                  
assume cs:program, ds:duom, ss:stekas
start:                           
        ;ikelia duomenys         
        mov ax, duom             
        mov ds, ax                       
        ;ishvalo ekrana          
        mov ax,0002h             
        int 10h                  
        ;ishveda startini praneshima
        mov ah,09h                                
        lea dx,txt1              
        int 21h                  
        ;ishveda praneshima prashanti ivesti varda
        mov ah,09h                                
        lea dx,txt2              
        int 21h                  
        ;vardo ivedimas          
        mov bx, 0  	      	 
        mov ah, 3fh    
        mov cx,21
        lea dx,vardas
        int 21h 
        ;ishveda praneshima prashanti ivesti pavarde
        mov ah,09h                                
        lea dx,txt3
        int 21h 
        ;pavardes ivedimas
        mov bx, 0  	      	
        mov ah, 3fh
        mov cx,16
        lea dx,pavarde
        int 21h 
        ;ishveda praneshima iveskite grupe
        mov ah,09h                                
        lea dx,txt4
        int 21h 
        ;grupes ivedimas        
        mov bx, 0      	      	
        mov ah, 3fh             
        mov cx,10
        lea dx,grupe            
        int 21h                 
        ;pakeicia 2 pirmas vietas vietomis
        mov ch, vardas[0]
        mov cl, vardas[1]
        mov vardas[0], cl
        mov vardas[1], ch       
        ;ishveda ivesta informacija
        mov ah,09h
        lea dx,nl
        int 21h
        mov ah,09h              
        lea dx,txt5             
        int 21h
        mov ah,09h
        lea dx,nl
        int 21h
        mov ah,09h              
        lea dx, vardas          
        int 21h                                                       
        mov ah,09h              
        lea dx, pavarde         
        int 21h                                           
        mov ah,09h                                
        lea dx, grupe                             
        int 21h                 
                                
        ;pabaiga                
        mov ah,07h              
        int 21h                 
        mov ah,4ch              
        int 21h                 
 program ends                                     
 end start