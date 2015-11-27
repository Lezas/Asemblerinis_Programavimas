stekas segment stack
   db 256 dup (?)
stekas ends

duomenys segment

mas db 'A','B','A','B','A','A','A','C','A','B'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    db 'A','B','B','A','A','A','B','A','A','A'
    
    p db 0       
i db 10      
j db 10      
sk db 0      
r db  0      
adr db 0       
             
  pran1 db 'Iveskite pavarde(ne daugiau 20 simboliu)',10,13,'$'
  pavarde db 20                                   
        db ?                                    
        db 20 dup(0)                            
    rezultatas db 20 dup(0),'$'                     
    des db 10                                
                                             
        db '$'                               
duomenys ends                                       
                                                
programa segment                                    
  assume ss:stekas,ds:duomenys,cs:programa       
start:



  mov ax,duomenys                                   
  mov ds,ax                                     
                                     
  mov ax,0002h
  int 10h
                                 
  mov ah,09h                                 
  lea dx,pran1     
  int 21h                                    
                                                    
  mov ah,0Ah                                    
  lea dx,pavarde
  int 21h                   
                
  mov cx,0                                
mov bx,30                        
ivedimas:                          
mov ah,0                           
mov ah, 08h                        
int 21h                            
mov mas[bx],al                     
                                   
mov ah,02h                         
mov dl,al  ; spausdina tai kas dl'e   
int 21h                            
                                   
dec bx                             
cmp al,13                          
je next                            
inc cx          ;skaitliukas     
jmp ivedimas                      
next:                            
                                 
mov sk, cx                   
                                   
mov ah,02
mov bh,00       ;irenginys-ekranas
mov dh,08       ;eilutes numeris
mov dl,26       ;stulpelio numeris
int 10h
mov ah, 09h                      
lea dx, atv                      
int 21h                          
                ;ISVEDIMAS                                         
mov bx, 30                       
sub bx, kiekis                   
mov eil, 25
isvedimas:                 
mov ah,02
mov bh,00
mov dh,10
mov dl,eil
int 10h
                          
mov ah, 02h               
mov dl, mas[bx]           
int 21h                   
                          
inc bx                    
inc eil                   
cmp bx,30                 
ja pabaiga                
jmp isvedimas             
                          
pabaiga:          
mov ah,07h
  int 21h                                    
                                             
  mov ah,4ch                                 
  int 21h   
  
programa ends
end start