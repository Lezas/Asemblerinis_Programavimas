.model small        
.stack 100h         
.data                          
        uzklaus1 db 13, 10, 10, 'Laba diena.',13,10,'Iveskite savo, varda, pavarde ir grupe:',13,10,'$'
        fnstr db 13, 10, '(a*2+b*c)/(d-3)=', '$'                                   
        str1 db 13, 10, 10, 'Darba atliko: ','$'
        newline db 13, 10, 10, '$'
        ate db 13, 10, 'Viso gero! :)', '$'
                                                                       
        a db 5
        b db 3                          
        c db 2                                  
        d db 2
                               
        trys db 3              
        du db 2                
                               
        dalm dw ?              
        deshimt dw 10          
        rez dw ?               
                               
        inp db 40, ? , 39 dup (?)
                                      
.code                                 
main proc                             
        mov ax, @data                 
        mov ds, ax                                  
                                                    
        call clrscreen
                                                    
        call inpname  
                      
        call clrscreen
                                                            
        mov dx, offset fnstr                        
        call pran                                   
                                                    
        call fn                                     
        mov ax, rez            
        call prnnum            
                               
                        
        mov dx, offset str1                         
        call pran                                   
        call outpav   
                      
        mov dx, offset ate
        call pran
                 
        mov dx, offset newline                  
        call pran
                                                    
        mov ax, 4c00h                               
        int 21h                                     
                                                    
fn proc near                                        
       push ax                                      
       push bx                                      
       push cx                                      
       push dx                                      
                                                    
       xor ax, ax                                   
       mov al, d                                    
       sub al, trys   
       push ax    
             
       xor ax, ax
       mov al, a
       imul du        
                      
       push ax        
         
       xor ax, ax
       mov al, b
       imul c     
             
       pop dx    
       add ax, dx       
       push ax
             
       pop ax         
       pop dx    
       idiv dl   
       mov rez, ax
       pop ax    
       pop bx    
       pop cx    
       pop dx    
       ret       
fn endp             
                                      
outpav proc near               
        xor bx, bx    
        xor cx, cx       
        xor dx, dx       
        mov cl, inp+1
        mov inp+38, '$'
        inc cx          
        lea bx, inp+2  

        mov ax,0200h
        outloop:    
          mov dx, [bx]
          inc bx    
          int 21h                
        loop outloop
        ret                           
outpav endp                           
                                      
                                      
pran proc near                        
        push ax
        mov ah, 09h
        int 21h
        pop ax                       
        ret                           
pran endp                             
                        
inpname proc near           
        push ax             
        push bx             
                               
        mov ah, 09h         
        mov dx, offset uzklaus1
        int 21h          
                         
        mov ax, 0A00h          
        mov bx, 0                                     
        lea dx, inp            
        int 21h                
                            
        pop ax              
        pop bx              
        ret                    
inpname endp             

clrscreen proc near
        mov ax, 0600h   
        mov bh, 07    
        mov cx, 0000h 
        mov dx, 184Fh 
        int 10h
        
        mov ah, 02h
        mov bh, 00h
        mov dx, 0000h
        int 10h
        ret           
clrscreen endp           

prni:                 
    push ax           
    push ax           
    and ax,8000h      
    cmp ax,0          
    pop ax       
    jz nene      
    push ax      
    push dx      
    mov ah,02h   
    mov dl,'-'   
    int 21h      
    pop dx       
    pop ax         
    neg ax       
nene:            
    call prnnum
    pop ax           
ret                  
                     
prnnum:
    push ax                  
    push cx                  
    push dx        
    mov cx,0       

    prn_i:
        mov dx,0   
        div deshimt
        add dx,30h 
        push dx    
        inc cx     
        cmp ax,0   
        jnz prn_i  
    mov ah,02h     

    prn2:        
        pop dx           
        int 21h    
    loop prn2    

    pop dx         
    pop cx         
    pop ax         
ret     
         
main endp           
end main