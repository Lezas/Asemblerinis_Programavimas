SSEG SEGMENT STACK
db 256 dup (?)              
ENDS SSEG                   
                           
DSEG SEGMENT               
a db 1
b db 3
c db 7
sveik db 0          
liek db 0  
tiksl db 0
rez1 db 'Sveika dalis:   , liekana:   ',13,10,'$'
rez2 db '   .                                  $'
ind dw 15                                 
_10 db 10           
done1 db 0          
ENDS DSEG                  
                           
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG
                                
START:                          
        mov ax, DSEG                     
        mov ds, ax                       
                                
        mov ax, 0002h           
        int 10h                          
                                
        ; skaiciuosim a*b/c     
                                                 
        mov ah, 0                 
        mov al, a                    
        mov bh, 0                             
        mov bl, b                             
        mov bh, 0                         
        mov cl, c                         
        ; AX:=AX*BX                       
        mul bx   
        ; AX:=AX/CX                       
        div cl   
        ; AX-Sveika dalis, BX-Liekana, DX:=AX
        mov bl, ah                   
        mov ah, 0                            
        mov bh, 0                    
        mov sveik, al                
        mov liek, bl
        mov cx, 0                    
                                     
rasom:                               
        div _10                      
        add ah, 30h               
        mov si, ind               
        mov rez1[si], ah             
        mov ah, 0                             
        dec ind                   
        cmp al, 0                 
        jne rasom                 
        inc cx   
        mov ax, bx
        mov ind, 28                       
        cmp cx, 1                         
        je rasom                          
                                          
        ; Skaiciuojam su kableliu         
        mov ah, 0                                         
        mov al, sveik
        mov ind, 2                        
                                          
rasom2:              
        div _10                      
        add ah, 30h                  
        mov si, ind                  
        mov rez2[si], ah             
        mov ah, 0                             
        dec ind                      
        cmp al, 0                    
        jne rasom2
                  
        mov ah, 0 
        mov al, liek
        mov si, 4
        mov tiksl, 0
                    
rasom3:             
        mul _10     
        div c       
        add al, 30h 
        mov rez2[si], al
        mov al, ah  
        mov ah, 0   
        inc si      
        inc tiksl
        cmp tiksl, 25
        je baigta
        cmp ax, 0        
        jne rasom3  
baigta:                    
        mov ah, 09h                       
        lea dx, rez1                      
        int 21h     
        mov ah, 09h 
        lea dx, rez2
        int 21h
                                          
        mov ah, 4Ch                       
        int 21h                           
ENDS CSEG                                 
END START                                 
