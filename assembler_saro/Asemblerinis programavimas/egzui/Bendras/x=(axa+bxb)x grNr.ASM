stekas segment stack 
    db 256 dup (?)   
stekas ends          
                            
duomenys segment            
    a db 100  
    b db 100  
    aa dw ?   
    bb dw ?   
              
    grNr dw 6      
    mas db 10 dup (?)
                                             
    pran_1 db "Viktorija Briskmanaite, II-04/4",'$'
    pran_2 db "Programa skaiciuoja (a*a+b*b)*grNr",'$'
    pran_3 db "a ir b aprasyti duomenu segmente. GrNr = 6",'$'
    pran_4 db "Iveskite b :",'$'                
    pran_5 db "Ats. : (a*a+b*b)*6=",'$'
                        
    deshimt db 10    
    simtas db 100    
    tukst dw 1000    
    dtukst dd 10000  
    stukst dd 100000 
    mil dd 1000000   
    dmil dd 10000000          
    smil dd 100000000         
    tmil dd 1000000000        
                                  
    newline db 13,10,'$'                                   
duomenys ends                     
program segment      
.486                 
start:                            
    assume cs:program, ds:duomenys, ss:stekas
    mov ax, duomenys              
    mov ds, ax                    
                                  
              call isvalyti_ekrana   
              call nauja_eilute      
              lea dx, pran_1         
              call fraze             
              call nauja_eilute      
              call nauja_eilute      
              lea dx, pran_2         
              call fraze      
                                               
              call nauja_eilute      
              lea dx, pran_3  
              call fraze      
              call nauja_eilute
              call nauja_eilute
                              
              call nauja_eilute      
              lea dx, pran_5  
              call fraze      
                              
                               
              ;skaiciavimas    
                               
              mov al,a                
              mul a            
              mov aa,ax       
                              
              mov al,b        
              mul b            
              mov bb,ax       
                              
              add ax,aa       
              mul grNr        
                              
              shl edx,16      
              add eax,edx     
              mov edx,0       
              call isved_sk64 
                              
     mov ah, 4ch          
    int 21h              
                         
;--== Proceduros ==--                   
isvalyti_ekrana proc            
    push ax                     
    push bx                     
    push cx                     
    push dx                           
    mov ax,0002h    ;video rezimas 02h
    int 10h                           
    pop dx                                          
    pop cx                      
    pop bx                                     
    pop ax                      
    ret                         
isvalyti_ekrana endp  
                   
nauja_eilute proc                              
    push ax                     
    push dx                     
    mov ah,09h          
    lea dx,newline    ; i dx paduodamas naujos eilutes simbolis
    int 21h                                                    
    pop dx                                                     
    pop ax                                                     
    ret                                                        
nauja_eilute endp 
                  
;isveda pranesima, pries tai i dx turi buti paduotas pranesimo adresas                                                               
fraze proc                                                     
    push ax                                                    
    mov ah,09h    
    int 21h                                                    
    pop ax                                                     
    ret                                                        
fraze endp                                                     
                           
isved_sk64 proc                                        
        mov si,0                                       
        div tmil                                       
        mov mas[si],al                                 
        inc si          
        mov eax,edx     
        mov edx,0       
        div smil        
        mov mas[si],al  
        inc si          
        mov eax,edx     
        mov edx,0        
        div dmil        
        mov mas[si],al  
        inc si          
        mov eax,edx     
        mov edx,0        
        div mil  
        mov mas[si],al
        inc si   
        mov eax,edx
        mov edx,0        
        div stukst
        mov mas[si],al
        inc si    
        mov eax,edx
        mov edx,0        
        div dtukst
        mov mas[si],al   
        inc si           
        mov ax,dx        
        mov dx,0         
        div tukst        
        mov mas[si],al   
        inc si           
        mov ax,dx        
        div simtas 
        mov mas[si],al
        inc si   
        mov al,ah
        mov ah,0   
        div deshimt
        mov mas[si],al
        inc si   
        mov mas[si],ah
        inc si  
        mov mas[si],'$'
        mov si,0
        mov cx,10
show64:                
        mov ah,02h  
        mov dl,mas[si]
        add dl,30h  
        int 21h       
        inc si      
        loop show64
        
        mov ah, 07h
        int 21h
        mov ah,4ch
        int 21h
        ret        
isved_sk64 endp
                                          
program ends                              
end start                           
