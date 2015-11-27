;Giedrius Uzkuras egzamino bilieto nr. 25
stekas    segment stack                  
          db 256 dup(0)                  
stekas    ends                           
                                         
;----duomenu  segmentas                  
duomenys  segment                        
                                         
pran1        db 'atliko II-1/5 grup. stud. Giedrius Uzkuras','$'
                                         
pran3        db 'Apskaiciuoti reiskini ((a + b)*100)/b','$'
pran_a       db 'Iveskite a (ne didesni kaip 255):','$'          
pran_b       db 'Iveskite b (ne didesni kaip 255):','$'                
pran4        db 'Rezultatas: S = ','$'        
klaida       db 'Ivyko klaida','$'           
a       db  0, '$',10,13                     
b       db  0, '$',10,13                     
simt    db  100, '$'                         
tmp     db  0, '$'                           
temp    dw  0, '$'                           
s       db  10, '$'                          
liek    dw  0, '$'                           
zenklas db ' ','$'                           
kablys  db ',', '$'                          
duomenys  ends                               
                                             
;----------programos segmentas--------       
programa  segment                            
          assume cs:programa, ds:duomenys, ss:stekas
                                             
start:    mov ax,duomenys                    
          mov ds,ax                          
;ekrano valymas                              
        mov ax,0002h                         
        int 10h                              
                                             
;pranesimu isvedimas                         
        mov ah, 02                           
        mov bh, 00                           
        mov dh, 3                            
        mov dl, 5                            
        int 10h                              
        lea dx, pran1                        
        mov ah, 09                           
        int 21h                              
                                             
                                             
        mov ah, 02                           
        mov dh, 5                            
        mov dl, 5                            
        int 10h                              
        lea dx, pran3                        
        mov ah, 09                           
        int 21h                              
                                             
        mov ah, 02                           
        mov dh, 8                            
        mov dl, 5                            
        int 10h                              
        lea dx, pran_a                       
        mov ah, 09                           
        int 21h                              
                                             
        call ivedimas                        
        mov a, bl                            
                                             
        mov ah, 02                           
        mov bh, 00                           
        mov dh, 9                            
        mov dl, 5                            
        int 10h                              
                                             
        lea dx, pran_b                       
        mov ah, 09                           
        int 21h                              
                                             
        call ivedimas                        
        mov b, bl                            
                                             
       jmp persokt                           
;paprogrames                                 
ivedimas proc                                
        xor ax, ax                           
        xor bx, bx                           
        xor dx, dx                           
        mov tmp, 0                           
        kartot:                              
        mov ah, 08h                          
        int 21h                              
        cmp al, 13                           
        je rrr                               
        cmp al, '-'                          
        jne nnn                              
        inc tmp                              
        mov dl,al                                        
        mov ah,02h                                       
        int 21h                                          
        jmp kartot                           
        nnn:                                 
        cmp al, '0'                          
        jl kartot                            
        cmp al, '9'                          
        jg kartot                            
        mov dl,al                                        
        mov ah,02h                                       
        int 21h                                          
        sub al,30h                                       
        mov cl,al                                        
        mov ax,bx                                        
        mul s                                            
        jc kld                                                              
        mov bx,ax                                        
        mov ax,cx                                        
        add bx,ax                                        
        jc kld                                         
        jmp kartot                                          
kld:                                                   
        mov ah,09h                                        
        lea dx,klaida                                     
        int 21h                              
        jmp dos                                         
rrr:                                         
        cmp tmp, 1                           
        jne rr                               
        neg bl                               
        rr:                                  
        ret                                  
ivedimas endp                                
                                             
                                             
skaic proc                                   
        cmp al, 0                            
        jge teigiamas                        
        neg al                               
        mov ah, 0                            
        sub temp, ax                         
                                             
        jmp testi                            
        teigiamas:                           
        mul simt                             
        add temp, ax                         
        testi:                               
        ret                                  
skaic endp                                   
                                             
dalinti proc                                 
        xor ax, ax                           
        mov al, b                            
        cmp temp, ax                         
        jl mazesnis                          
        je lygus                             
        mov bx, ax                           
        mov ax, temp                         
        xor dx, dx                           
        div bx                               
        mov temp, ax                         
        mov ax, 1000                         
        mul dx                               
        xor bh, bh                           
        mov bl, b                            
        idiv bx                              
        mov liek, ax                         
        jmp pab                              
        mazesnis:                            
        mov bx, temp                         
        mov ax, 1000                         
        mul bx                               
        xor bh, bh                           
        mov bl, b                            
        xor dx, dx                           
        div bx                               
        mov liek, ax                         
        mov temp, 0                          
        jmp pab                              
        lygus:                               
        mov temp, 1                          
        pab:                                 
        ret                                  
dalinti endp                                 
        persokt:                             
        mov temp, 0                          
        mov tmp, 0                           
                                             
        mov ah, 02                           
        mov bh, 00                           
        mov dh, 12                           
        mov dl, 5                            
        int 10h                              
        mov ah, 09h                          
        lea dx, pran4                        
        int 21h                              
;sudedame a, b ir dauginame is 100            
        xor ax, ax                           
        mov al, a                            
        call skaic                           
        mov al, b                            
        call skaic                           
                                             
                                             
        mov ah, 02                           
        mov bh, 00                           
        mov dh, 14                           
        mov dl, 5                            
        int 10h                              
                                             
        cmp temp, 0                          
        jge teig                             
        neg temp                             
        mov zenklas, '-'                     
                                             
        teig:                                
                                             
xxx:                                         
        mov ah, 02                           
        mov bh, 00                           
        mov dh, 12                           
        mov dl, 20                           
        int 10h                              
        mov ah, 09h                          
        lea dx, zenklas                      
        int 21h                              
                                             
        call dalinti                         
isvedimas:                                   
        mov bx, temp                         
        mov s, bl                            
                                             
        cmp bx, 100                          
        jb desimtys                          
        mov ax, 0                            
        mov ax, bx                           
        mov bx, 100                          
        div bl                               
        mov bh, 0                            
        mov s, ah                            
        add al, 30h                          
        mov tmp, al                          
                                             
        lea dx, tmp                          
        mov ah,09h                           
        int 21h                              
        mov tmp, 0Ah                         
desimtys:                                    
        cmp tmp, 0Ah                         
        je netikrint                         
        cmp s, 10                            
        jb vienetai                          
 netikrint:                                  
        mov bx, 10                           
        mov al, s                            
        mov ah, 0                            
        div bl                               
        mov bh, 0                            
        mov s, ah                            
        mov tmp, al                          
        add tmp, 30h                         
                                             
        mov ah,09h                           
        lea dx, tmp                          
        int 21h                              
vienetai:                                    
        add s, 30h                           
        mov ah,09h                           
        lea dx, s                            
        int 21h                              
                                             
        cmp liek, 0                          
        je dos                               
        mov ah, 09h                          
        lea dx, kablys                       
        int 21h                              
                                             
        mov ax, liek                         
        mov temp, ax                         
        mov liek, 0                          
        jmp isvedimas                        
                                             
dos:                                         
;laukia klaviso paspaudimo                   
          mov ah, 07h                         
          int 21h                            
                                             
;programos pabaiga                           
          mov ah,4ch                         
          int 21h                            
programa  ends                               
          end start                          
