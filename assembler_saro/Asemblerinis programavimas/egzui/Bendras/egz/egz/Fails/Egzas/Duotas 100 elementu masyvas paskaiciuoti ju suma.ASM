;Kursinis darbas                  
;Uzduties Nr. 3.1
;Duotas 100 elementu masyvas paskaiciuoti ju suma                                        
;Atliko:Gintaras Vaikutis II 0/3
stek segment stack              
        db 256 dup (0)          
stek ends                       
duom segment                    
        vp db 10,13,'Gintaras Vaikutis II 0/3',10,13,'$'
        masv db 20 dup (255,255,255,255,255)
        uzd db '100 elementu masyvo elementu suma ',10,13,'$'                            
        uzdx db 'Masyvas is 20 skirtingu elementu: ',10,13,'$'
        klaida db 10,13,'Ivyko perpildymas!!!','$'
        ats db 'Atsakymas:        ','$'            
        d dw 10                                    
duom ends                                          
kurs4 segment                                      
assume cs:kurs4,ds:duom                            
start:                                             
        mov ax,duom                                
        mov ds,ax                                  
;Ekrano valymas                                          
        mov ax,0002h                                     
        int 10h                                   
                                          
	mov ah,09h                                 
	lea dx,vp                         
	int 21h                           
	lea dx, uzd                       
	int 21h                           
	lea dx,uzdx                       
	int 21h                           
        mov cx,100                        
        xor ax,ax                         
        xor bx,bx                         
        xor dx,dx                         
        mov si,0                          
xx:                                       
        mov al,masv[si]                   
     ;   cbw      ;konvertuojam baita i zodi
        add bx,ax                         
        jc error                          
        inc si                            
        loop xx                                   
        mov ax,bx  ;i ax perkeliam visu el. suma
        cmp ax,0   ;jei daugiau uz nuli                             
       ; jge cikl                         
     ;   neg ax     ;padarome skaiciu teigiamu   
      ;  mov ats[11],'-'  ;i atsakyma irasome minusa                    
cikl:                                              
        mov si,15          
des:                               
        idiv d       ;sveikoji dalis ax, liekana dx
        add dx,30h   ;nes dirbame su zodziu                              
        mov ats[si],dl                             
        xor dx,dx                                  
        dec si                                     
        cmp ax,0                                   
        jne des                                    
                                                   
        mov ah,09h                                 
        lea dx,ats                                 
        int 21h                                    
        jmp pab                                    
error:                                             
        mov ah,09h   
        lea dx,klaida
        int 21h                                            
pab:                                               
        mov ah,07h                                 
        int 21h                                    
        mov ah,4ch                                 
        int 21h                                    
kurs4 ends                                         
end start   