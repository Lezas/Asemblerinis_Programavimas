stek segment stack                    
        db 256 dup (0)                           
stek ends                                      
                                             
data segment                                 
pran1 db '                 iveskite a(gimimo diena): ','$'
pran2 db '                iveskite b(gimimo mienuo): ','$'
pran22 db 'iveskite c(gim metu paskutiniai 2 skait): ','$'                  
pran3 db '                   iveskite grupes numeri: ','$'  
pran4 db 'Lygtis x=(a+b+c)-grNr ','$'
pran5 db ' rezultatas: x = ','$'                          
                                      
msg11     db '        PABAIGA','$'    
msg1     db 'KURSINIS DARBAS','$'     
msg2     db ' 3uzd: formules (a+b+c)-grNr skaiciavimas ','$'
msg4     db '    Atliko:','$'                                 
msg5     db '             Jurga Griganaviciute II-1/2','$'    
msg6     db 'Paspauskit enter mygtuka','$'                    
msg41    db '++','$'                                          
msg3      db '*','$'                                          
                                                              
i db 0                                                        
                                                              
a dw 0
b dw 0
c dw 0
grNr dw 0
tmp1 db ?
tmp2 dw ?
x dw 0                                                     
skait db ?
skaitm db 5 dup (0)
ten dw 10                                                             
data ends                                                     
                                                              
program segment                                               
   start:                                                     
   assume cs:program, ds:data, ss:stek                        
                                                              
        mov ax,data                                           
        mov ds,ax                                             
                                                              
        ;isvalom ekrana                                       
       mov ax,0002h                                           
       int 10h                                                
                                                              
        mov ax,0600h                                          
        ;spalva                                               
        mov bh,10                                             
        mov cx,0                                              
        mov dx,184fh                                          
        int 10h                                               
                                                              
               call remelis                                   
               call maz_remelis                               
;+++++++++++++++++++++++++++++++++++                                                                                                                                                       
        ;pran1                                                                     
        mov ah,09h                                                                 
        lea dx,msg1                                                                
        int 21h                                                                    
        ;-------------------------------------                                              
        ;koord                                                                     
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,12                                                                  
        mov dl,15                                                                  
        int 10h                                                                    
                                                                                   
        ;pran2                                                                     
        mov ah,09h                                                                 
        lea dx,msg2                                                                
        int 21h                                                                    
        ;-------------------------------------                                              
        ;koord                                                                     
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,14                                                                  
        mov dl,26                                                                  
        int 10h                                                                    
                                                                                   
        ;pran                                                                    
        mov ah,09h                                                                 
        lea dx,msg4                                                                
        int 21h                                                                    
                                                                                   
        ;-------------------------------------                                              
        ;koord                                                                     
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,15                                                                  
        mov dl,26                                                                  
        int 10h                                                                    
                                                                                   
        ;pran2                                                                     
        mov ah,09h                                                                 
        lea dx,msg5                                                                
        int 21h                                                                    
                                                                                   
        ;koord ,kursoriaus padetis                                                 
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,23                                                                  
        mov dl, 26                                                                 
        int 10h                                                                    
                                                                                   
        ;pran2                                                                     
        mov ah,09h                                                                 
        lea dx,msg6                                                                
        int 21h                                                                    
        ;----------------------------------                                        
                                                                                   
        ;laukti                                                                    
        mov ah,07h                                                                 
       int 21h                                                
                                                              
                                                              
  ;*******************************************************    
 ; valymas                                                    
 mov ax,0002h                                                 
 int 10h                                                      
                                                              
 ;----------------                                            
     mov ax,0600h                                             
        ;spalva                                               
        mov bh,03                                             
        mov cx,0                                              
        mov dx,184fh                                          
        int 10h                                               
                                                              
               call remelis                                   
                                                              
;pranesimai                                                   
       mov ah,02                                              
        mov bh,00                                             
        mov dh,07                                             
        mov dl,25                                             
        int 10h                                               
                                                              
        mov ah,09h                                            
        lea dx,pran4                                          
        int 21h                                               
                                                              
                                                              
        mov ah,02                                             
        mov bh,00                                             
        mov dh,09                                             
        mov dl,10                                             
        int 10h                                               
                                                              
        mov ah,09h                                            
        lea dx,pran1                                          
        int 21h                                               
                                                              
       ; mov ah,3fh                                            
       ; mov bx,0                                              
       ; mov cx,15                                             
       ; lea dx,a                     
       ; int 21h                                                              
         call input_1                 
        mov a,ax                               
                                      
        mov ah,02                                             
        mov bh,00                                             
        mov dh,10                                             
        mov dl,10                                             
        int 10h                                               
                                                              
        mov ah,09h                                            
        lea dx,pran2                                          
        int 21h                                               
                                                              
                              
       call input_1                             
        mov b,ax                                
                                                
        mov ah,02                                             
        mov bh,00                                             
        mov dh,11                                             
        mov dl,11                                             
        int 10h                                               
                                                              
        mov ah,09h                                            
        lea dx,pran22                                          
        int 21h                                               
                                                              
                                                
       call input_1                             
        mov c,ax                                
                                                        
      ;pakartot                                               
      ;  kartojimas:                                                                                                                                   
        mov ah,02                                             
        mov bh,00                                             
        mov dh,12                                             
        mov dl,10                                           
        int 10h                                                     
                                                              
        mov ah,09h                                            
        lea dx,pran3                                          
        int 21h                                              
                                                                                                                                                                       
       call input_1                             
        mov grNr,ax                             
        ;--------                               
      ;  cmp grNr,36h                           
       ; jg kartojimas                          
        ;-----                                    
        mov ah,02                               
        mov bh,00                               
        mov dh,12                                                       
        mov dl,06                              
        int 10h                                
;------------------------------------------------------------
;--------------   skaiciavimai    ------------------------------------
                           
        mov ax,a           
        add ax,b           
        add ax,c           
        sub ax,grNr                                             
        mov x,ax           
                                                               
                                                                
 ;----------------------------------------------------------------
        mov ah,02                                              
        mov bh,00                                              
        mov dh,16                                              
        mov dl,30                                              
        int 10h                                                                                                                    
         ;OUT                                                     
        mov ah,09h                                               
        lea dx,pran5                                            
        int 21h                                                  
                                                                 
        ;DATA OUTPUT                                             
                                                                 
        mov cx,0000h                           
        mov cx,03                                                
        mov skait,48                                           
        mov ax,x                                                 
        mov tmp2,ax                                              
                                                                 
        cikl:                                                    
        ;dalyba                                                  
                                               
        xor dx,dx
        mov ax,tmp2                                                                                         
        div ten                                                   
                                                                 
        ;liekanos spausdinimas                                   
        mov tmp1,dl  ;  liekana                                                                          
   ;     mov ah,00h                                            
        mov tmp2,ax    ;sveikoji dalis al                      
                                                               
                                                                 
        mov ah,02                                                
        mov bh,00                                                
        mov dh,16                                                
        mov dl,skait                                             
        int 10h                                                  
                                                                 
        add tmp1,30h                                             
        dec skait                                                
                                                               
        xor dx,dx                                                         
        mov dl,tmp1 ;ikeliau                                             
        mov ah,02h                                                
        int 21h                                                  
                                                               
        ;ciklo pabaiga - sveikoji dalis lygi 0                 
        cmp tmp2,0                                             
        je end_cikl                                            
                                                               
        loop cikl                                              
        end_cikl:                                              
                                                               
       ;koord ,kursoriaus padetis                              
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,23                                                                  
        mov dl, 26                                                                 
        int 10h                                                                    
                                                                                   
        ;pran2                                                                     
        mov ah,09h                                                                 
        lea dx,msg6                                                                
        int 21h                                                                    
        ;----------------------------------                                 
        ;wait                                                  
        mov ah,07h                                             
        int 21h                                                
      ;***************************                             
                                                               
;**************************************************************************                                                                                                                                                                                 
        mov ax,0600h                                                               
        ;spalva                                                                    
        mov bh,12                                                                  
        mov cx,0                                                                   
        mov dx,184fh                                                               
        int 10h                                                                    
                                                                                   
call remelis                                                                       
                                                               
                                                                                   
        ;koordinates                                                               
        mov ah,02                                                                  
        mov bh,00                                                                  
        mov dh,10                                                                  
        mov dl,27                                                                  
        int 10h                                                                    
                                                                                   
                                                                                   
        ;pran1                                                                     
        mov ah,09h                                                                 
        lea dx,msg11                                                               
        int 21h                                                                    
                                                                                   
        ;laukti                                                                    
        mov ah,07h                                                                 
        int 21h                                                                    
                                                                                   
;**************************************************************************        
        mov ah,4ch                                                                 
        int 21h                                                                    
    remelis:                                                                       
        mov i,0                                                                    
        ;virsus ir apacia                                                          
        mov cx,40                                                                  
        cycl:                                                                      
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,0                                                              
             mov dl,i                                          
             int 10h                                                               
                                                                                   
             mov ah,09h                                                            
             lea dx,msg3                                                           
             int 21h                                                               
                                                                                   
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,24                                                             
             mov dl,i                                                              
             int 10h                                                               
                                                                                   
             inc i                                                                 
             inc i                                                                 
                                                                                   
             mov ah,09h                                                            
             lea dx,msg3                                                           
             int 21h                                                               
        loop cycl                                                                  
       ;++++++++++++++++++++++++++++++++++++                                       
        ;sonai                                                                     
                                                                                   
        mov cx,23                                                                  
             cycle2:                                                               
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,cl                                                             
             mov dl,0                                                              
             int 10h                                                               
                                                                                   
             mov ah,09h                                                            
             lea dx,msg3                                                           
             int 21h                                                               
                                                                                   
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,cl                                                             
             mov dl,78                                                             
             int 10h                                                               
                                                                                   
             mov ah,09h                                                            
             lea dx,msg3                                                           
             int 21h                                                               
        loop cycle2                                                                
   ret                                                                             
         maz_remelis:                                                              
                                                                                   
 ;------------------------                                                         
 ;maziukas kvadratikas                                                             
  ;kaire                                                                           
        mov cx,22                                                                                                      
             cycle3:                                                               
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,cl                                                                          
             mov dl,4                                                              
             int 10h                                                               
                                                                                   
             mov ah,09h                                                            
             lea dx,msg41                                                          
             int 21h                                                               
            ;desine                                                                
             mov ah,02                                                             
             mov bh,00                                                             
             mov dh,cl                                                             
             mov dl,74                                                             
             int 10h                                                               
                                                                                   
             mov ah,09h                                                            
             lea dx,msg41                                                          
             int 21h                                                               
             cmp cl,2                                                              
             je out_                                                               
        loop cycle3                                            
            out_:                                                            
        ;-------------------------------------                 
        ;koordinates                                           
        mov ah,02                                              
        mov bh,00                                              
        mov dh,10                                              
        mov dl,27                                              
        int 10h                                                                                      
         ret                                                   
                                                               
  input_1:                                                     
                                                               
        mov cx,3                                                                                                                                                                             
        mov si,1                                               
        mov skaitm[si],00h                                     
ivedimas:                                                      
                                                               
        mov ah,08h                                             
        int 21h                                                
                                                               
        cmp al,13        ;ar ne Enter                          
        je skaic                                               
        cmp al,'0'       ;jei ne skaicius                      
        jb ivedimas      ;pakartot ivedima                     
        cmp al,'9'                                             
        ja ivedimas                                            
                                                               
        mov dl,al                                              
        mov ah,02h                                             
        int 21h                                                
                                                               
        sub al,'0'                                             
        mov skaitm[si],al                                      
        inc si                                                 
        loop ivedimas                                          
skaic:                                                         
        mov al, skaitm[0]     ;ax - pirmas skaitmuo            
        xor ah,ah                                              
                                                               
        mov cx,si                                              
        sub cx,1                                               
        mov si,1                                               
 skaic1:                                                       
        ;mov al,10         ;ax - nipilnas skaicius             
        ;mov ah,00h                                            
        mul ten                                                
        mov dl,skaitm[si]                                      
        xor dh,dh                                              
        add ax,dx          ;prie ax prirasem skaitmeni         
        ;mov bx,ax                                             
        inc si                                                 
   loop skaic1                                                 
                                                               
                                                               
ret                                                            
                                                               
                                                                               
program ends                                                                       
end start                                                                          
             