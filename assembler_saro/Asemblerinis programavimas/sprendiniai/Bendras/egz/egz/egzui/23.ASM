stekas    segment stack                                   
          db 256 dup(0)                                   
stekas    ends                                            
                                                                                             
duomenys  segment                                         
                                                          
pran1       db 'Gediminas Kerpiskis      II-2/3', '$'
pran2       db '''$'                                       
pran3       db 'Ivesta eilute isvesti atvirkstine tvarka','$'
info        db 'Iveskite eilute:','$'                     
atv         db 'Atvirkstine tvarka: ', '$'                
ilgis       db 'Ilgis: ', '$'                             
eilute           db 250  dup("$"),10,13, '$'              
rez              db ?, '$'                                
skaic            db ?, '$'      
tmp              db 0, '$'               
simb             db  '=','$'          
duomenys  ends                  
                                
;----------progr segme--------  
programa  segment              
                               
          assume cs:programa, ds:duomenys, ss:stekas
                               
start:    mov ax,duomenys      
          mov ds,ax    
;ekrano valymas                               
mov ax,0002h              
int 10h                
                       
       lea dx, simb    
       mov ah, 09      
       int 21h         
                       
       mov cx, 79      
virsus_ir_apacia:      
       mov ah, 02      
       mov bh, 00      
       mov dh, 0       
       mov dl, cl      
       int 10h         
                       
       lea dx, simb    
       mov ah, 09      
       int 21h         
                       
       mov ah, 02                             
       mov bh, 00      
       mov dh, 23      
       mov dl, cl      
       int 10h         
                       
       lea dx, simb    
       mov ah, 09      
       int 21h         
       loop virsus_ir_apacia
                       
       mov cx, 23      
kaire_ir_desine:       
       mov ah, 02      
       mov bh, 00      
       mov dh, cl      
       mov dl, 0       
       int 10h         
                       
       lea dx, simb    
       mov ah, 09      
       int 21h         
                       
       mov bh, 00      
       mov ah, 02        
       mov dh, cl      
       mov dl, 79      
       int 10h         
                       
       lea dx, simb    
       mov ah, 09      
       int 21h         
       loop kaire_ir_desine        
;pranesimo isvedimas   
       mov bh, 00      
       mov ah, 02      
       mov dh, 3       
       mov dl, 5       
       int 10h         
       mov ah,09h      
       lea dx,pran1    
       int 21h         
                       
       mov ah, 02      
       mov dh, 5       
       mov dl, 5       
       int 10h         
       mov ah,09h      
       lea dx, pran2   
       int 21h         
                       
       mov ah, 02      
       mov dh, 6       
       mov dl, 5       
       int 10h         
       mov ah,09h      
       lea dx,pran3    
       int 21h         
                       
       mov ah, 02      
       mov bh, 00      
       mov dh, 8       
       mov dl, 5       
       int 10h         
       mov ah,09h      
       lea dx,info     
       int 21h                            
;eilutes ivedimas       
       mov ah,3fh      
       lea dx,eilute   
       int 21h         
                       
       xor ax,ax       
ciklas:                
       xor bx,bx       
       mov bl, skaic   
       mov al, eilute+bx
       cmp al, 0Dh     
       je  isvesti     
       push ax         
       inc skaic       
       jmp ciklas      
isvesti:               
        cmp skaic, 0   
        jne nenul      
        jmp dos        
        nenul:         
        mov ah, 02     
        mov bh, 00     
        mov dh, 10     
        mov dl, 5      
        int 10h        
        mov ah, 09h    
        lea dx, atv    
        int 21h        
                       
        xor cx, cx      
        mov cl, skaic  
isv_cikl:              
        pop ax         
        mov rez, al    
                       
        mov ah , 09h   
        lea dx, rez    
        int 21h               
loop isv_cikl          
        mov ah, 02     
        mov bh, 00     
        mov dh, 12     
        mov dl, 24     
        int 10h        
                       
        mov ah, 09     
        lea dx, ilgis  
        int 21h        
                       
        xor bx, bx     
        mov bl, skaic  
        xor ax, ax     
                       
        cmp bx, 100    
        jb desimtys    
        mov ax, 0      
        mov ax, bx     
        mov bx, 100    
        div bl         
        mov bh, 0      
        mov skaic, ah        
        add al, 30h    
        mov tmp, al    
                       
        lea dx, tmp        
        mov ah,09h     
        int 21h        
        mov ax, 10     
desimtys:              
        cmp ax, 10     
        je netikr         
        cmp skaic, 10  
        jb vienetai    
        netikr:        
        mov bx, 10     
        mov al, skaic  
        mov ah, 0      
        div bl         
        mov bh, 0      
        mov skaic, ah  
        mov tmp, al      
        add tmp, 30h   
                       
        mov ah,09h     
        lea dx, tmp    
        int 21h        
vienetai:              
        add skaic, 30h 
        mov ah,09h     
        lea dx, skaic  
        int 21h         
dos:                   
        ;laukia klaviso paspaudimo     
         mov ah, 07h   
         int 21h       
mov ah,4ch             
int 21h                
programa  ends                 
end start