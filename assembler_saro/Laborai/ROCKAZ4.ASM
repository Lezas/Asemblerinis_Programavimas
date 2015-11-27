SSEG SEGMENT STACK
db 256 dup (?)              
ENDS SSEG                   
              
DSEG SEGMENT        
nm db 'p' 
rez db '   $'
d10 db 10         
ind dw 2          
ENDS DSEG         
                  
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG
                  
START:            
        mov ax, DSEG
        mov ds, ax
                  
        mov ax, 0002h 
        int 10h   
              
        mov ah, 0
        mov al, nm
        mov bh, 0
        mov bl, 10
                   
rasom:    
        div bl
        add ah, 30h
        mov si, ind
        mov rez[si], ah
        xor ah, ah
        dec ind
        cmp al, 0
        jne rasom
              
        mov ah, 09h
        lea dx, rez            
        int 21h
                               
        mov ah, 4Ch            
        int 21h                
ENDS CSEG                      
END START                      
