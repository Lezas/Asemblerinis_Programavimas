stekas segment stack                 
db 256 dup(0)                        
stekas ends                          
cr equ 13                    
lf equ 10                 
duomenys segment                     
     pranesimas db 'Programa kopijuoja nurodyto failo turini i nauja faila '
                db 'ir kiekviena vartotojo ',cr,lf
                db 'nurodyta zodi keicia kitu vartotojo'            
                db ' nurodytu zodziu (daro raplace operacija).',cr,lf       
                db 'Sukure ii-23 grupes studentas Vaidas Zdanys ',cr,lf,lf,'$'
         zodis1 db 30,?,30 dup(?)                               
         zodis2 db 30,?,30 dup(?)                               
         fname1 db 50,?,50 dup(?)                               
         fname2 db 'c:\write.txt',0                             
            mas db 30 dup('?')                                  
         ilgis2 dw ?                                            
         ilgis1 dw ?                                            
         string db ?                                            
       file dw 0                                                
      file2 dw 0   
           er db 'klaida!','$'                                  
              ax1 dw ?                                          
              cx1 dw ?                                          
              pran1 db 'Iveskite pirmaji zodi: ','$'            
              pran2 db 'Iveskite antraji zodi: ','$'            
              pran3 db 'Nurodykite pilna kelia iki failo ir failo varda: ','$'
              pran4 db 'Rezultas irasytas i faila write.txt','$'                         
                 ke db cr,lf,'$'                                                        
              pran5 db 'Jusu ivesto pirmojo zodzio nurodytame faile nera!','$'          
           uzklausa db 'Jei norite kartoti programa,spauskite bet kuri klavisa',cr,lf   
                    db 'Iseiti - ESC'                                                   
                    db cr,lf,'$'                                                        
             prank1 db 'Klaida! Failas nebuvo atidarytas',cr,lf,'$'                     
             prank2 db 'Klaida! Failas duomenu irasymui nebuvo sukurtas'
                    db cr,lf,'$'                
             prank3 db 'Klaida duomenu irashyme!',cr,lf,'$'
             prank4 db 'Klaida duomenu skaityme is failo!',cr,lf,'$'
duomenys ends                                                                           
                                                                                        
programa segment                                                                        
        assume cs:programa, ds:duomenys, ss:stekas                                      
        start:                                                                          
                     mov ax, duomenys
                     mov ds, ax                                                     
     mov ah,09h     
     lea dx,pranesimas
     int 21h        
 new:                                                              
      mov ah,09h         ;1failo vardo ivedimas                                                     
      lea dx,pran3                                                            
      int 21h                                                                 
      mov ah,0Ah                                                              
      lea dx,fname1                                                           
      int 21h                                                                 
                                                                              
      mov bl,fname1[1]                                                        
      add bl,2                                                                
      mov bh,0                                                                
      mov si,bx                                                               
      mov fname1[si],0                                                        
; open file                                       
        mov ax,3d02h                                                          
        lea dx,fname1[2]                                                      
        int 21h                                                               
        jnc ok1                                                               
        call klaida1                                                           
   ok1: mov file,ax    
; create file                                                                 
        mov ah,3ch                                                            
        mov cx,00000000b                                                      
        lea dx,fname2                                                         
        int 21h                                                               
        jnc ok2                                                               
        call file2     
   ok2: mov file2,ax   
;1 zodzio ivedimas                                                                              
      call next                                                               
      mov ah,09h                                                              
      lea dx,pran1                                                            
      int 21h                                                                 
      mov ah,0Ah                                                              
      lea dx,zodis1                                                           
      int 21h                                                                 
      mov bl,zodis1[1]                                                        
      mov bh,0                                                                
      mov ilgis1,bx                                                           
;2 zodzio ivedimas                                
      call next                                                               
      mov ah,09h                                                              
      lea dx,pran2                                                            
      int 21h                                                                 
      mov ah,0Ah                                                              
      lea dx,zodis2                                                           
      int 21h                                                                 
      mov bl,zodis2[1]                                                        
      mov bh,0                                                                
      mov ilgis2,bx                                                           
  ;======programa======
             mov di,0                                                         
    pradzia: mov si,1                                                         
      zyme1: call skaityk                                                     
             mov ax1,ax                                                       
             mov cx1,cx                                                       
                                                                              
             mov bl,string[0]                                                 
             cmp bl,zodis1[si+1]                                              
             jne zyme2                                                        
                                                                              
             cmp si,ilgis1  
             jne zyme4                                                        
                 mov ah,40h   ; write string to file                          
                 mov bx,file2
                 mov cx,ilgis2                                                
                 lea dx,zodis2[2]                                             
                 int 21h                                                      
                 jnc ok3                          
                 call klaida3                      
            ok3: mov di,1                         
             jmp pradzia                                                      
                                                                              
      zyme4:  mov mas[si-1],bl                                                
              inc si                                                          
              jmp zyme1                                                       
                                                                              
      zyme2:  cmp si,1                                                        
              je zyme66                                                       
                  sub si,1 ;                                                    
                  mov ah,40h   ; write string to file                         
                  mov bx,file2
                  mov cx,si                                                   
                  lea dx,mas                                                  
                  int 21h                                                     
                  jnc ok5    
                  call klaida3
              ok5:                                                                
              mov ax,ax1                                                      
              mov cx,cx1                                                      
              cmp ax,cx     ; ar ne eof                                       
              jne pabaiga   ;                                                 
         call rasyk                                                           
        jmp pradzia                                                           
                                                                              
     zyme66:   mov ax,ax1                                                     
              mov cx,cx1                                                      
              cmp ax,cx     ; ar ne eof                                       
              jne pabaiga   ;                                                 
                                                                              
             call rasyk                                                       
             jmp zyme1                                                        
   pabaiga:                                                                   
        cmp di,0            ;                     
        jne yraZ                                                
        call next            ;    ar yra 1 zodis                              
        mov ah,09h                                             
        lea dx,pran5                                           
        int 21h             ;                                   
 yraZ:                                                         
;close file                                                                  
        mov ah,3eh
        mov bx,file
        int 21h
        mov ah,3eh
        mov bx,file2
        int 21h
                  call next
                  mov ah,09h
                  lea dx,pran4                             
                  int 21h                                  
  arkartoti:   call next
               call next                         
               mov ah,09h                  ;     
               lea dx,uzklausa                              
               int 21h                                    
               mov ah,08h                                 
               int 21h                  ;uzklausa                  
               cmp al,1Bh                                 
               je exit        
               mov ax,0002h                               
               int 10h                                    
               jmp far ptr new         ;
exit:                         
        mov ax,0002h                                                          
        int 10h                                                               
        mov ax,4c00h                                                          
        int 21h                                                               
      klaida proc                                                             
 error: mov ax,0002h                                                          
        int 10h                                                               
        mov ah,09h                                                            
        lea dx,er                                                             
        int 21h                                                               
        mov ah,07h                                                            
        int 21h                                                               
        mov ax,0002h                                                          
        int 10h                                                               
        mov ax,4c00h                                                          
        int 21h                                                               
        ret                                                                   
      endp klaida                                                             
      klaida1 proc            
        call next             
        mov ah,09h            
        lea dx,prank1         
        int 21h               
        jmp arkartoti         
      ret                     
      endp klaida1            
      klaida2 proc            
        call next             
        mov ah,09h            
        lea dx,prank2         
        int 21h               
        jmp arkartoti         
      ret                     
      endp klaida2            
      klaida3 proc           
        call next             
        mov ah,09h            
        lea dx,prank3        
        int 21h               
        jmp arkartoti         
      ret                     
      endp klaida3           
      klaida4 proc     
        call next             
        mov ah,09h            
        lea dx,prank4  
        int 21h               
        jmp arkartoti         
      ret                     
      endp klaida4     
                              
      skaityk proc                                                            
; read from file                                                              
       mov ah,3fh                                                             
       mov bx,file     
       mov cx,1                                                               
       lea dx,string                                                          
       int 21h                                                                
       jnc ok7
       call klaida4    
  ok7: ret             
     endp skaityk                                                             
     rasyk proc                                                               
; write string to file                                                        
        mov ah,40h                                                            
        mov bx,file2   
        mov cx,1             
        lea dx,string        
        int 21h              
        jnc ok6        
        call klaida3   
   ok6: ret            
     endp rasyk              
     next proc         
        mov ah,09h     
        lea dx,ke           
        int 21h             
        ret            
     endp next                   
                             
             programa ends                                                         
             end start       
                 