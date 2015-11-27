stekas segment stack   
        db 256 dup(?)
stekas ends            
                       
;duomenu segmentas  
duomenys segment       
        intro db 'Oleg Bystrov',13,10,'II-0/4',13,10,10,'$'
        t1  db 'Hi, AWoArlAd!*',13,10,'$'
        t2  db 'Hi, WoBrlBd!B*',13,10,'$'
        prant1 db 'Masyve t1 yra ','$'
        prant2 db 'Masyve t2 yra ','$'
        prant12 db ' raidziu A',13,10,'$'
        prant22 db ' raidziu B',13,10,'$'   
                             
        ten dw 10            
        skaitm db 5 dup(?),'$'                  
                             
duomenys ends                  
                    
; programos segmentas                   
programa segment       
 assume cs:programa,ds:duomenys,ss:stekas
 start:                
        mov ax,duomenys
        mov ds,ax      
; isveda intro      
        mov ax,0900h
        lea dx,intro
        int 21h        
; isveda pradini texta
        mov ax,0900h  
        lea dx,t1   
        int 21h     
        mov ax,0900h  
        lea dx,t2   
        int 21h     

; isveda pradzia pirmo sakinio                    
        mov ax,0900h    
        lea dx,prant1
        int 21h     
                    
; skaiciuojam       
        xor ax,ax   
        xor si,si   
a:      cmp t1[si],'*'
        je isved1   
        cmp t1[si],'A'
        jne noa     
        inc ax      
noa:    inc si      
        jmp a       
                    
isved1:                
        call isvedimas        
                    
        mov ax,0900h  
        lea dx,prant12
        int 21h       

; isveda pradzia antro sakinio
        mov ax,0900h
        lea dx,prant2
        int 21h      
                     
; skaiciuojam        
        xor ax,ax    
        xor si,si    
b:      cmp t2[si],'*'
        je isved2    
        cmp t2[si],'B'
        jne nob      
        inc ax       
nob:    inc si       
        jmp b        
                     
isved2:                
        call isvedimas        
                     
        mov ax,0900h  
        lea dx,prant22
        int 21h       
                                
                                
; darbo pabaiga (Exit Code 0)                           
          mov ax,4C00h     
          int 21h     
                      
; isvedam ax i ekrana kaip skaiciu (ax,cx,dx;skaitm,ten)
isvedimas  proc      
skai:     xor dx,dx        
          mov cx,5                                 
next:     div ten          
          mov si,cx             
          add dl,'0'       
          mov skaitm[si-1],dl
          xor dx,dx        
          cmp ax,0000h     
          loopne next                  
nuliai:   mov si,cx        
          mov skaitm[si-1],'0'
     loop nuliai           
                           
          lea dx,skaitm      
          mov ah,09h                   
          int 21h
          ret
isvedimas endp        
                      
 programa ends           
    end start