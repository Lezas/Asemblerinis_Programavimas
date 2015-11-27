stekas segment stack                                             
        db 256 dup (?)                                           
stekas ends                                            
                                                                 
duomenys segment  
        vardas db 'Atliko Jaroslav Jakubovskij II-2/2' , 13,10,'$'                                     
        ivsr db 10,?,10 dup (?)
        a db ?
        b db ?
        c db ?
        rez db ? 
        ats db 0,0,0,0
        iv1 db ' Iveskite a: $'
        iv2 db 13,10, 'Iveskite b: $' 
        iv3 db 13,10, 'Iveskite c: $'                       
        iv4 db 13,10, 'Atsakymas: $'
        des db 10                                      
        du db 2               
duomenys ends                                          
                                                       
programa segment                                            
assume cs:programa,ds:duomenys,ss:stekas
                              
start:                        
                              
mov ax,duomenys                     
mov ds,ax                     
                              
;mov ah,07h                          
;int 10h                      
;mov ax,0                     
mov ax,0002h ;isvalo ekrana   
int 10h 
lea dx,vardas                          
mov ah,09h                         
lea dx,iv1                          
mov ah,09h                          
int 21h            
call ivd  
mov a,al  
;nuskaitom b 
lea dx,iv2                          
mov ah,09h                          
int 21h         
call ivd
mov b,al     
                            
;nuskaitom c                        
lea dx,iv3  ;isvedam pranesima                        
mov ah,09h                          
int 21h            
call ivd           
mov c,al           
                           
;skaiciavems a*b+c 
call skait
mov rez,al
                             
;isvedimas 
         
lea dx,iv4 ; pranesimas apie atsakyma                         
mov ah,09h            
int 21h             
                    
                   
;vertimas i desimtaini koda       
mov ax,0              
mov al,rez                      
div des             
add ah,30h          
mov ats+2,ah        
mov ah,0              
div des               
add ah,30h          
mov ats+1,ah          
add al,30h          
mov ats,al          
mov ats+3,24h                   
lea dx,ats    ;isvedam ats        
mov ah,09h                          
int 21h                             
mov ah,4ch                          
int 21h            
                   
ivd proc           
mov ax,0           
mov ah,0Ah         
lea dx,ivsr        
int 21h            
;nuskaitom skaicius
mov ax,0                            
lea dx,ivsr+2                       
mov bx,0                            
mov cx,0                            
mov cl,ivsr+1                       
mov si,dx                           
ciklas:                             
     mov bl,[si]                    
     sub bl,30h                     
     add al,bl                      
     mul des                        
     add si,1                       
loop ciklas        
div des            
RET                
ivd endp
         
  skait proc
mov ax,0                            
mov al,a           
imul b              
add al,c                              

RET       
skait endp         
         
          
programa ends                       
end start