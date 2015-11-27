stekas segment stack                             
   db 256 dup(?)                                 
stekas ends                                      
                                                 
data segment                                     
   text1 db 'Lukas Subacius II-02', 10, 13, '$'
   text3 db 'Ivesk a: ','$'                
   text4 db 'Ivesk b: ','$'                
   error db 'Ivestas skaicius didesnis uz 255',10,13,'$'
   text2 db 'Atsakymas: ',10,13,'$'        
   sveika_dalis db 'Sveika dalis: ',10,13,'$'
   liekana_liekana db 'Liekana: ',10,13,'$'
   entr db 10,13,'$'                       
   blogai db 'Klaida!!! Ivestas skaicius didesnis uz 255',10,13,'$'
   a_ir_b dw 2 dup(0) ;masyvas is 2 elementu, 1-a, 2-b
   du db 2                                           
   desimt dw 10                                      
   ats_sv db 5 dup(?),10,13,'$'                      
   ats_liekana db 5 dup(?),10,13,'$'                 
   daliklis dw 3                                     
data ends                                            
                                                                    
code segment                                                        
  assume cs:code, ds:data, ss:stekas                                
  start:                                                            
   mov ax, data                                                     
   mov ds, ax                                                       
   mov di,4                                                         
   mov ah, 09h                                       
   lea dx, text1                                                    
   int 21h                                                          
   lea dx, text3                                                    
   int 21h                                                          
                                                                    
ivedimas:                                                           
        mov ah,08h                                                  
        int 21h                                                     
        cmp al,13       ;tikrinu ar yra ivesta                 
        je kitas                                     
        cmp al,'0'                                                  
        jb ivedimas                                                 
        cmp al,'9'                                                  
        jnbe ivedimas                                               
                                                                    
        mov dl,al                                                   
        mov ah, 02h ;skaiciaus isvedimas
        int 21h                                                     
                                                                    
                                                                    
        xor ah,ah                                                   
        sub al,30h                                                  
        mov bx,ax                                                   
        mov ax,a_ir_b[si]                            
        mul desimt                                                  
        add ax,bx                                                   
        cmp ax,255                                                  
        jg klaida                                                   
                                                                    
        mov a_ir_b[si],ax                            
        jmp ivedimas                                                
                                                                    
kitas:                                               
        add si,2                                     
        cmp si,2                                     
        jg galas                                     
                                                     
        mov ah, 09h                                  
        lea dx, entr                                 
        int 21h                                      
        mov ah, 09h                                  
        lea dx, text4                                
        int 21h                                      
                                                     
        jmp ivedimas                                 
                                                     
                                                     
klaida:                                              
   mov ah, 09h                                
   lea dx, entr                               
   int 21h                                    
   lea dx, error                              
   int 21h                                    
   mov ah, 4ch                                
   int 21h                                               
   ret                                        
                                              
galas:                                        
   xor dx,dx                                  
   mov ax,a_ir_b[2]                           
   mul du                                     
   add ax,a_ir_b[0]                           
   xor dx,dx                                  
   div daliklis                               
   push dx                                    
                                              
dalyba:                                       
   xor dx,dx                                  
   div desimt                                 
   add dl,30h                                 
   mov ats_sv[di],dl
   cmp ax,0                                   
   je liekana                                 
   dec di                                     
   jmp dalyba                                 
                                              
liekana:                                      
   pop ax                                     
   xor di,di                                  
   dalyba2:                                   
        xor dx,dx                             
        div desimt                            
        add dl,30h                            
        mov ats_liekana[di],dl                
        cmp ax,0                              
        je isvedimas                          
        inc di                                
        jmp dalyba2                           
                                              
isvedimas:                                    
   mov ah, 09h                                
   lea dx, entr                               
   int 21h                                    
   mov ah, 09h                                
   lea dx, text2                              
   int 21h                                    
   lea dx, sveika_dalis                       
   int 21h                                    
   mov ah, 09h                                
   lea dx, ats_sv                             
   int 21h                                    
   lea dx, liekana_liekana                    
   int 21h                                    
   mov ah, 09h                                
   lea dx, ats_liekana                        
   int 21h                                    
                                              
;programos pabaiga                            
   mov ah, 4ch                                
   int 21h                                               
   ret                                        
                                              
   code ends                                         
end start