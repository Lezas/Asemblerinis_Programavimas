;Uzdavinys su matrica
                                  
stekas segment stack              
        db 256 dup(?)             
stekas ends                       
                                  
cr equ 13                         
lf equ 10                         
                                  
;Duomenu segmentas                
duomenys segment                  
                     
 pran_1 db ' -> musu suma',cr,lf,'$'
 pran_2 db 'Elementas ','$'
matrica db 16 dup (0)     
   suma dw 0                      
    des dw 10                     
tarpinis db 0,'$'                 
 perkelt db cr,lf,'$'                                 
  tarpas db ' ','$'
     tmp db ' ',' ',' ','$'
    elem db 3, ?, 3 dup (0)
  NauEil db cr,lf,'$'                
       x dw 0,'$'
                       
duomenys ends                     
                                  
programa segment                  
         assume cs:programa, ds:duomenys, ss:stekas
           
skaitmuo proc                                         
        mov dl, [bx]                                  
        sub dl, 30h                                   
        mov ax, x                                     
        mov dh, 0                                     
        mov x, dx                                     
        ret                                           
skaitmuo endp                                         
                                                      
skaicius proc                                         
        push cx                   
        push bx
    ;    mov ah, 0ah                                   
     ;   lea dx, elem             
      ;  int 21h                                       
        add dx, 2                                     
        mov bx, dx                                    
        mov ch, 0                                     
        mov cl,elem+1     ;irasom kiek ivesta skaitmenu
        dec cl                                        
        call skaitmuo                                 
        cmp cx, 0       ;kad norm. vykdytu cikla
        je endas                               
        mov ax, 0000h      
        ciklas3:
                inc bx                         
                call skaitmuo                  
                mul des
                add x, ax                      
                mov ax, x                      
        loop ciklas3
        endas: 
        pop bx                                
        pop cx
        ret   
skaicius endp  
                 
narys proc    
        mov cx, 4
        mov bx, 0 
                    
Ieilute:            
        push cx  
        mov cx, 4          
        mov si, 0          
                           
Istulpeli:                 
        mov ah, 09h        
        lea dx, pran_2     
        int 21h            
        mov tmp, bl        
        add tmp, 30h       
        mov ax, si         
        add al, 30h        
        mov tmp+2, al      
        mov ah, 09h        
        lea dx, tmp        
        int 21h            
        mov ah, 09h        
        lea dx, NauEil     
        int 21h            
        mov ah, 0ah        
        lea dx, elem       
        int 21h            
        call skaicius      
                           
;Elemento adreso skaiciavimas
        push bx  
        mov ax, 4
        mul bx                
        mov bx, ax
        mov ax, x             
        mov matrica[bx][si], al
        inc si                     
        pop bx
        loop Istulpeli             
        pop cx                     
        inc bx                     
        mov ah,09h                 
        lea dx, NauEil             
        int 21h                    
        loop Ieilute               
        ret                        
                                   
narys endp                         
                                   
                                   
                                   
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
                                   
;Matricos ivedimas
        call narys
        mov ax, 0002h
        int 10h

;Matricos isvedimas                
        mov cx, 16                 
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
        cmp si, 4                  
        je perkela                 
        cmp si, 8                  
        je perkela                 
        cmp si, 12                 
        je perkela                 
        cmp si, 16                 
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
                                   
                                   
        mov cx, 4; suksime cikla 4 kartus
        mov bx, 0                  
        mov si, 0                  
                                   
ciklas:                            
        mov ah, 0                  
        mov al, matrica[bx][si]    
        add suma, ax               
        add bx, 4                  
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
                 
