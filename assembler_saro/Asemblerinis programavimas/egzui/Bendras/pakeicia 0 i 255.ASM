;Uzduotis 3.3: matricoje kiekvienoje eiluteje, pradedant 3 elementu, visus
; nulinius narius pakeisti i 255
;------------steko segmentas-----------------
stekas segment stack
        db 256 dup (?)
stekas ends

;------------duomenu segmentas---------------
duomenys segment
        i dw 6
        j dw 5
        matrica db 1,2,0,0,5,1
                db 0,2,0,1,4,2
                db 3,0,3,0,3,0
                db 1,2,1,2,1,2
                db 1,0,1,0,1,1
         
         line db 10,13,'$'       
         autore db 13,10,13,10,'Aistes Jasaitytes, FMU-9','$'
         desim dw 10
duomenys ends

;------------programos segmentas-------------
program segment
 assume cs:program, ds:duomenys, ss:stekas
 start:
        mov ax,duomenys
        mov ds,ax
        
;----isvalome ekrana----
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,186fh
        int 10h
;----pakeliame i virsu--
        mov ah,02
        mov bh,00
        mov dx,0000
        int 10h
;-----------------------
         
        call mat_is
        
; dabar keisime 0 i 255:
        mov cx,j
        lea bx,matrica
        ciklas_j_2:
                push cx
                add bx,2
                mov cx,i
                sub cx,2
                ciklas_i_2:
                        mov ah,0
                        mov al,[bx]
                        cmp ax,0
                        jnz ne0
                        mov al,255
                        mov [bx],al
                        ne0:   
                        inc bx
                loop ciklas_i_2
                pop cx
        loop ciklas_j_2
        
        call nline
        
        call mat_is
        
        lea dx,autore    
        call pranesimas   
        
;------Grazina i DOS'a----
        mov ah,4ch
        int 21h 
        
;matricos isvedimas
mat_is:  
        push ax
        push bx
        push cx
        mov cx,j
        lea bx,matrica
        mov ax,0
        is_ciklas_j:
                push cx
                mov cx,i
                is_ciklas_i:
                        mov al,[bx]
                        call skaiciu_sp
                        call tarpelis ;tarpeliai tarp skaiciu
                        inc bx
                loop is_ciklas_i
                call nline
                pop cx
        loop is_ciklas_j
        pop cx
        pop bx
        pop ax
ret      
         
;skaiciu isvedimas 
skaiciu_sp:
        push ax
        push cx
        push dx
        mov cx,0
        skaiciu_sp_1:
                mov dx,0
                div desim
                add dx,30h
                push dx
                inc cx
                cmp ax,0
                jnz skaiciu_sp_1
        mov ah,02h
        skaiciu_sp_2:
                pop dx
                int 21h
        loop skaiciu_sp_2
        pop dx
        pop cx
        pop ax
ret      
         
;tarpeliai:
tarpelis:
        push ax
        push dx
        mov ah,02h
        mov dl,' '
        int 21h
        pop dx
        pop ax
ret      
 
;kita eilute     
nline:              
        push ax    
        push dx    
        mov ah,09h 
        lea dx,line
        int 21h
        pop dx
        pop ax
ret        
;standartas
pranesimas:
        push ax
        mov ah,09h
        int 21h
        pop ax
;pabaiga        
mov ah,07h
int 21h        
mov ah,4ch
int 21h        
        ret      
         
program ends
end start           
 