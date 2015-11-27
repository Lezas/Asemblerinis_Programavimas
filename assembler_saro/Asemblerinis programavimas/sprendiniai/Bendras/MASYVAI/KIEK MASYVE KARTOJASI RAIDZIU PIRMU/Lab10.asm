;Lab10 -> skaiciuoja kiek yra eiluciu masyve kuriu pirmas elementas
;pasikartoja bent viena karta
stekas segment stack                                               
db 256 dup (?)                                                     
stekas ends                                                        
duomenys segment                                                   
        vardas db 10,13,'Atliko Edvinas Veretinskas II 1/3'
               db 10,13,'Laboratorinis darbas 10 $'        
	pran1  db 10,13,'Eiluciu kuriose kartojasi pirmas sibolis: $'
	dvides db 20                                               
	kiekis db 0, '$'    
	koks   db 0                                                  
       	        
mas db 'abbbbbbbbbbbbbbbbbbb'
    db 'bccccccccccccccccccc'
    db 'cddddddddddddddddddd'
    db 'deeeeeeeeeeeeeeeeeee'
    db 'efffffffffffffffffff'
    db 'fggggggggggggggggggg'
    db 'ghhhhhhhhhhhhhhhhhhh'
    db 'hjjjjjjjjjjjjjjjjjjj'
    db 'jkkkkkkkkkkkkkkkkkkj'
                            
duomenys ends                                                      
programa segment                                                   
        assume cs:programa, ds:duomenys, ss:stekas                 
start:                                                             
    mov ax,duomenys                                                
    mov ds,ax                                                      
    mov ax, 0002h                                                  
    int 10h                                                        
    mov ah,09h                                                     
    lea dx,vardas                                                  
    int 21h                                                        
                                                                   
          ;di=stulpelio nr [1,2,3...]                              
          ;si=eilutes elementas[1,2,3,..]                          
          ;bx=di*20  
                      
          mov di, 0      
                                
NewLine:  mov ax, di  
          mul dvides            
          mov bx, ax     
          mov dl,mas[bx] 
          mov koks, dl   
          mov si,0       
                         
                tikrinu: 
                inc bx
                mov cl, mas[bx]
                cmp koks,cl
                je suma   
                inc si    
                cmp si, 19
                ja next   
                jmp tikrinu
                     
           next:     
           cmp di, 8 
           je pabaiga
           inc di    
           jmp NewLine                                                         
                                                                   
pabaiga:                                                   
    mov ah,09h                                                     
    lea dx,pran1     
    int 21h          
                                                    
    add kiekis, 30h  
    mov ah, 09h      
    lea dx, kiekis   
    int 21h          
                                                                    
    mov ah, 07h                                                    
    int 21h                                                        
    mov ah,4ch                                                     
    int 21h                                                        
                      
suma:                 
inc kiekis            
jmp next             
                         
programa ends                                                
end start  