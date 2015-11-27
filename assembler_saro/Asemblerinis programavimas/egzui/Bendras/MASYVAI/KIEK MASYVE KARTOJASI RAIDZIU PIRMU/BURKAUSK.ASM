stekas segment stack
  db 256 dup (?)  
stekas ends       
                  
duom segment
mas   db 'A','D','A','M','G','G','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
      db 'A','D','A','A','D','A','A','D','A','A'
             
p db 0       
i db 10      
j db 10      
sk db 0      
r db  0      
adr db 0       
             
pran1   db 'Iveskite pavarde(iki 20 simboliu)',10,13,'$'
  zodis db 20                                   
        db ?                                    
        db 20 dup(0)                            
    rez db 20 dup(0),'$'                     
    des db 10                                
                                             
        db '$'                               
duom ends                                       
                                                
prog segment                                    
  assume ss:stekas,ds:duom,cs:prog              
  del proc                                                       
        mov ax,0002h                                           
        int 10h                                                
        ret                                                    
del endp                                        
start:                                          
  mov ax,duom                                   
  mov ds,ax                                     
  call del                                   
                                             
  mov ah,09h                                 
  lea dx,pran1 ; pranesimas           
  int 21h                                    
                                                    
  mov ah,0Ah                                    
  lea dx,zodis ; pavardes ivedimas              
  int 21h                                    
                                      
  mov cx,0                           
  lea cx,zodis+2  ; pasiimame pirmos raide adres pvz 102
  mov adr,cx     ; issisaugome "G" raides adresa 
                                      
                                      
   mov ax,0                           
   mov al,zodis+2   ; "G" raides reiksme                    
   mov r,al                              
                                         
   lea bx,mas       ; bx paiimame adr 200                         ;
   mov adr,bx       ; issisaugome
                                      
  mov bx,0                            
  mov cx,100                          
                                  
 masyvas: 
          
   add adr,cx                                  
   cmp al, mas[adr]     ; cmp al,mas[cx] 
   je yra 
          
  loop masyvas 
               
  yra:
  add sk,1
  jmp masyvas             
         
  mov ah,09h
  lea  dx,sk
  int 21h          
                                             
  mov ah,07h                                 
  int 21h                                    
                                             
  mov ah,4ch                                 
  int 21h                                    
                                             
                                             
prog ends                                    
end start                                    
