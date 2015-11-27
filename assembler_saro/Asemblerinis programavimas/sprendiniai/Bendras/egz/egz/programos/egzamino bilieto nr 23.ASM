stekas segment stack             
 db 256 dup(?)                   
stekas ends                      
                                 
duomenys segment                                     
   egzam   db 10,13,'Egzamino bilieto numeris 23 $'
   ived    db 10,13,'Iveskite savo pavarde $',10,13     
   viso    db 10,13,'Duomenu kuriose kartojasi pirmas sibolis: $'
   demesio db 10,13,'Demesio! Pirmas simbolis nesikartoja! $'
   suma  dw (?),'$'                              
   koks    db 0
   pav db 20
   dvides db 10                                  
   doleris db 10,13,'$'                           
   mas     db 'A','B','A','B','A','A','A','C','A','B'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
           db 'A','B','B','A','A','A','B','A','A','A'
duomenys ends
                                                  
programa segment                                      
assume cs:programa, ds:duomenys, ss:stekas            
start:                                                
mov ax, duomenys                                      
mov ds,ax                                             
mov ax, 0002h                          
int 10h                                                   
                                                      
mov ah, 09h                            
lea dx, egzam                          
int 21h                                           
mov ah,09h
lea dx,ived
int 21h                                                  
mov ah,0Ah                                    
lea dx,pav ; pavardes ivedimas              
int 21h
                                                                                       
;mov ax, 0                
mov bx, 0
mov dx, 0
mov suma, cx
mov dl, mas[bx]
mov koks, dl
                         
          mov di, 0      
                                
neil:  mov ax, di  
          mul dvides            
          mov bx, ax     
          mov dl,mas[bx] 
          mov koks, dl   
          mov si,0       
                         
tikrinu:
                inc bx
                mov cl, mas[bx]
                cmp koks,cl
                je sm
                inc si    
                cmp si, 9
                ja next   
                jmp tikrinu
                     
next:
           cmp di, 10 
           je pabaiga
           inc di    
           jmp Neil
                         
next2:      
     cmp ax, 0
     je nera
nera:                    
    mov ah,09h           
    lea dx,demesio      
    int 21h                   
    jmp pabaiga             
                         
incr:                    
    inc ax               
    jmp tikrinu               
                                      
sm:
inc suma            
jmp next

pabaiga:
mov ah,09h
lea dx,suma
int 21h                                 
mov ah,07h                                              
int 21h                                                 
mov ah, 4ch                                             
int 21h                                                 
programa ends                                           
end start                                               
                             
                             
                             
                      