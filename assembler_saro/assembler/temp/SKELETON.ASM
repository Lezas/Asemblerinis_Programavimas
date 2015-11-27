
                
;Outputs msg in two rows to the screen
;Msg defined in data segment 
                               
stck segment stack             
        db 256 dup(0)          
stck ends                      
                               
                               
dat segment                    
        msg1 db "Good morning", 0dh, 0ah, '$'
        msg2  db "It is a beautiful day", 0dh, 0ah,'$'
dat ends                       
                               
                                                                                                                              
prog segment                                 
        assume cs:prog, ds:dat, ss:stck      
start:                                                                                                                                           
        mov ax,dat                                                                                                                          
        mov ds,ax              
                                                                                                                                     
;clear screen                                                                                                                                    
        mov ah, 06h            
        xor al, al      ;lines to scroll up
        mov bh, 07h     ;atribute for blank lines
        xor cx, cx      ;cx -> upper left corner coordinates             
        mov dl, 79      ;dx -> lower right corner coordinates                              
        mov dh, 24                                                                                                                                
        int 10h                
                               
;Put cursors position          
        mov ah, 02h            
        xor bh, bh      ;page number
        mov dh, 0       ;row   
        mov dl, 0       ;column    
        int 10h        
                                                 
                                                                                                                                                 
;print message                                                                                                                                   
        mov ah,09h                                                                                                                               
        lea dx,msg1                                                                                                                        
        int 21h                                  
                                                 
        mov ah,09h                                                                                                                               
        lea dx,msg2                                                                                                                        
        int 21h                                  
                                                                                                                                                                                              
;press any key                                   
        mov ah,07h      ;direct character input without echo                              
        int 21h                                                                                                                                  
                                                             
;exit                                                 
        mov ah,4ch                               
        int 21h                                  
prog ends                                        
end start                                        
           