stekas segment stack 
        db 256 dup (?)
stekas ends

duomenys segment

pran1   db 'Ivesk savo metus:',10,13,'$'
        a dw 2006
        b dw 1985
        belekas dw 5,?,5 dup (?)
        sudai dw 0
        ten db 10
        rez db 4 dup (0),'$'
        temp dw 0
        
duomenys ends
program segment
assume ss:stekas, ds:duomenys, cs:program
start:         
        mov ax, duomenys
        mov ds, ax
               
        mov ax, 02h
        int 10h
               
        mov ah, 09h
        lea dx, pran1
        int 21h
               
        mov ax, a
        sub ax, b
        mov temp, ax
               
        mov al, byte ptr temp
        div ten   
        add ah, 30h
        ;
        mov di,3
        mov rez[di],ah
        dec di 
        add al, 30h
        mov rez[di], al
        mov ah, 09h
        lea dx, rez
        int 21h   
        ;
                  
        mov ah, 0ah
        lea dx, belekas
        int 21h   
                  
        mov si, 0 
        mov cx, 4 
        xor ax,ax 
        ck:       
                  
        mov al,byte ptr belekas[si]+2
        sub al, 30h
        add byte ptr sudai, al
;        mov byte ptr sudai, al
;        mul ten               
;        mov byte ptr sudai,al
        inc si                
        cmp si, 4
        jl jeee  
        AI:            
        loop ck
        jmp gals
        jeee:   
        mov ax, sudai
        mul ten      
        mov sudai, ax
        jmp AI                
        gals:                 
                            
        mov rez,0
        mov temp, 0  
        ;            
        mov ah, 02h
        int 10h
                     
        mov ax, a    
        sub ax, sudai
        mov temp, ax 
                     
        mov al, byte ptr temp
        div ten      
        add ah, 30h  
                     
        mov di,3     
        mov rez[di],ah
        dec di       
        add al, 30h  
        mov rez[di], al
        mov ah, 09h  
        lea dx, rez  
        int 21h      
       ;             
        mov ah, 07h  
        int 21h      
        mov ah, 4ch  
        int 21h      
        program ends 
        end start
        