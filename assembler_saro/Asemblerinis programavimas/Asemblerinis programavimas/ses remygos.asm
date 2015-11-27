;----------steko segmentas-------------------------
stekas segment stack                               
        db 256 dup (?)                             
stekas ends                                        
;---------duomenu segmentas------------------------                                                   
duomenys segment                                   
  nam_1 db \'Iveskite varda ir pavarde:\',\'$\'        
  nam_2 db \'Darba atliko:\',\'$\'
  vardas_1 db 20 dup (\'*\'),\'$\'
  a db 2   
  b db 3   
  dal db 10
  ats db 3 dup (0), \'$\'
                       
                       
                       
duomenys ends                                      
;-------programos segmentas-------------------------
programa segment                                   
 assume cs:programa, ds:duomenys, ss:stekas        
start:                                             
mov ax,duomenys                                    
mov ds,ax                                          
;------------------                                
 ;   Valau ekrana      
 mov ax,0600h          
 mov bh,07h            
 mov cx,0000           
 mov dx,184fh          
 int 10h               
                       
                       
; Pozicija             
mov ah, 02h            
mov bh,00              
mov dh,12              
mov dl,20              
int 10h                
                       
                       
 lea dx,nam_1                                      
 mov ah,09h                                         
 int 21h                                           
 mov ah,3fh            
 mov bx,0                                          
 lea dx,vardas_1       
 int 21h                                               
                       
; Valau ekrana         
mov ax,0600h           
 mov bh,07h            
 mov cx,0000           
 mov dx,184fh          
 int 10h               
                       
; Pozicija             
mov ah, 02h            
mov bh,00              
mov dh,12              
mov dl,30              
int 10h                
                       
                       
lea dx,nam_2           
mov ah,09              
int 21h                
lea dx,vardas_1        
mov ah,09              
int 21h                
;mov ah,4ch             
;int 21h                
           
mov ah,0   
mov al,a   
mov bh,0   
mov bl,b   
add ax,bx  
mov dx,ax  
mov si,0   
           
           
skaic1:    
div dal    
mov ah,0   
cmp al,0   
je sk      
inc si     
jmp skaic1    
sk:        
mov ax,dx  
skaicius:  
div dal    
add ah,30h 
mov ats[si],ah
dec si      
mov ah,0    
cmp al,0    
je isvedimas
jmp skaicius
            
isvedimas:  
mov ah,09h  
lea dx,ats  
int 21h     
mov ah,4ch  
int 21h     
            
programa ends          
end start  