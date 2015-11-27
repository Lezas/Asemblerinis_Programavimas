stekas segment stack                                               
db 256 dup (?)                                                     
stekas ends                                                        
duomenys segment                                                           
	pran   db 'Eiluciu kuriose kartojasi 1-as masyvo elementas:$'
	ten    db 10,'$'                                               
	kiek   db 0, '$' 
	at     db 4 dup(0),'$'  
	koks   db 0                                                  
       	        
mas db 0,1,1,1,1,1,1,1,1,0   ;kartojasi
    db 1,2,2,2,2,2,2,2,2,2
    db 2,3,3,3,3,3,3,3,3,3
    db 3,4,4,4,4,4,4,4,4,4
    db 4,5,5,4,5,5,5,5,5,5   ;kartojasi
    db 5,6,6,6,6,6,6,6,6,6
    db 6,7,7,7,7,7,7,7,7,7
    db 7,8,8,8,8,8,8,8,8,8 
    db 8,9,9,9,9,9,9,9,9,9
    db 9,0,0,0,0,0,0,9,0,0   ;kartojasi       
duomenys ends                                                      
programa segment                                                   
        assume cs:programa, ds:duomenys, ss:stekas                 
start:                                                             
    mov ax,duomenys                                                
    mov ds,ax                                                      
    mov ax, 0002h                                                  
    int 10h                                                                                                              
                                                                   
          ;di=eilutes nr [1,2,3...]                              
          ;si=eilutes elementas[1,2,3,..]                          
          ;bx=di*10  
                      
          mov di, 0      
                                
KitaEil:  mov ax, di  
          mul ten           
          mov bx, ax     
          mov dl,mas[bx] 
          mov koks, dl   
          mov si,0       
                         
                tikrinu: 
                inc bx
                mov cl, mas[bx]
                cmp koks,cl
                je radau   
                inc si    
                cmp si, 9
                je next             
                jmp tikrinu
                     
           next:     
           cmp di, 9 
           je pabaiga
           inc di    
           jmp KitaEil
                      
  radau:                 
  inc kiek            
  jmp next             
                                                                                                                                    
pabaiga:                                                                                                                  
xor ax,ax  
mov si,3
mov al, kiek
cycle:	div ten                                
	add ah, 30h    ;ah<-ah+30h   (30h=48)                        
	mov at[si],ah  ;at[si]<-ah                          
	dec si         ;si<-si-1                        
	mov ah, 0     ;ah=0                        
	cmp si, 0     
	je  break 
	cmp al, 0                        
	je  break                           
	jmp cycle                                
break:  mov     ah,09h                                                     
        lea     dx,pran     
        int     21h 
	mov	ah,09h      
	lea	dx,at   
        int	21h
;endas                                                                   
    mov ah, 07h                                                    
    int 21h                                                        
    mov ah,4ch                                                     
    int 21h                                                        
programa ends                                                
end start  