;Uzdavinys su matrica
                                  
stekas segment stack              
        db 256 dup(?)             
stekas ends                       
                                  
cr equ 13                         
lf equ 10                         
                                  
;Duomenu segmentas                
duomenys segment                  
 pran_1 db '-> musu suma',cr,lf,'$'
matrica db 100,2,3,4,1              
        db 5,60,7,8,1               
        db 4,3,250,1,1              
        db 8,7,6,5,1
        db 1,1,1,1,1,'$'
   suma dw 0                      
    des dw 10                     
tarpinis db 0,'$'                 
 perkelt db cr,lf,'$'                                 
  tarpas db ' ','$'
                   
duomenys ends                     
                                  
programa segment                  
         assume cs:programa, ds:duomenys, ss:stekas
                                  
rezultatas proc                      
        mov cx, 0                    
push_sk:                             
        mov dx, 0                    
        div des                      
        add dx, 30h                  
        push dx                      
        inc cx                       
        cmp ax, 0                    
        jne push_sk                  
pop_sk:                              
        mov ah, 09h                  
        pop dx                       
        mov tarpinis, dl                 
        lea dx, tarpinis                 
        int 21h                      
        loop pop_sk                  
        ret                          
rezultatas endp                   
                                  
start:                            
        mov ax, duomenys          
        mov ds, ax                
                                  
   mov ax, 0002h                  
   int 10h                        
                     
;Matricos isvedimas  
                       
        mov cx, 25   
        mov si, 0    
ciklas2:             
        push cx      
        mov cx, 0  
        mov ax, 0                 
        lea bx, matrica[si]
        mov al, [bx]
                   
    ;    call rezultatas
matr:              
        mov dx, 0              
        div des    
        push dx    
        inc cx     
        cmp ax, 0  
        jne matr   
isv:               
        pop ax     
        mov tarpinis, al
        add tarpinis, 30h
                   
        mov ah, 09h
        lea dx, tarpinis
        int 21h    
        loop isv   
                   
        pop cx                    
        inc si     
        cmp si, 5  
        je perkela 
        cmp si, 10 
        je perkela 
        cmp si, 15 
        je perkela 
        cmp si, 20 
        je perkela 
                   
        jmp pradzion 
perkela:            
        mov ah, 09h 
        lea dx, perkelt
        int 21h     
                    
pradzion:
        mov ah, 09h
        lea dx, tarpas
        int 21h                    
        loop ciklas2
                   
                                  
        mov cx, 5; suksime cikla 4 kartus
        mov bx, 0    
        mov si, 0    
                                  
ciklas:                           
        mov ah, 0                 
        mov al, matrica[bx][si]
        add suma, ax              
        add bx, 5  
        inc si   
        loop ciklas                
                                  
        mov ax, suma                   

                                  
;Atsakymo isvedimas               
        call rezultatas
        lea dx, pran_1 
                 
        mov ah, 09h               
        int 21h  
                 
        mov ah, 07h
        int 21h  
                 
        mov ah, 4ch
        int 21h  
programa ends    
         end start               
        
