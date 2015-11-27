; Programa padalina du skaicius,
; isveda sveikaja dali ir liekana
; bei rezultata kaip skaiciu su kableliu  
                                        
stekas segment stack                                             
        db 256 dup (?)                  
stekas ends                             
             
tiksl equ 3
                  
duomenys segment   
        a db 100
        b db 3    
        kabl db ".$"
        ten db 10           
        isved db 3 dup ('0'),'$'
duomenys ends                   
                                
programa segment                
	 assume cs:programa,ds:duomenys,ss:stekas   
   start:
        mov ah,0002h
        int 10h
                                
         mov ax,duomenys                      
         mov ds,ax                            
                                                         
         mov al,a                                        
         xor ah,ah                                       
         div b       ;ah - liekana
                     ;al - sv.sk.   
         mov dh,ah
         xor ah,ah
         call isvedimas
                  
         mov cx,tiksl
trup:    mov al,dh
         mul ten   
         div b     
         mov dx,ax   ;dh - liekanos liekana
         add dl,'0'  ;dl - sekantis simbolis      
         mov ah,02h
         int 21h  
    loop trup     
                  
         mov ax,4c00h
       	 int 21h                                         
                                                    
isvedimas proc  ;ax isveda i ekrana (ax,cx,dx,si)
; isved masyvo isvalymas                                              
          push ax 
          push cx 
          push dx 
          push si 
                  
          mov cx,3
          mov si,0    
isval:    mov isved[si],'0'
          inc si    
     loop isval           
                        
; isvedimas                        
          mov cx,3
next:     div ten                                  
          mov si,cx                           
          ;add ah,'0'                         
          ;mov isved[si-1],ah                 
          add isved[si-1],ah                  
          xor ah,ah                            
          cmp al, 00h                         
   loopne next    
                                              
          lea dx,isved                        
          mov ah,09h                          
          int 21h                             
                 
          lea dx,kabl
          mov ah,09h                           
          int 21h    
                
          pop si
          pop dx
          pop cx
          pop ax
          ret
isvedimas endp                                         
                                                       
programa ends                                           
                                                       
end start                                              
       	      	   		                       
       