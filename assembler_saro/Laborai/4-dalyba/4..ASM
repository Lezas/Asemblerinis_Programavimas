
stekas segment stack               
  db 256 dup(?)                    
stekas ends    
             
duomenys segment   
         
a db 40           
b db 0            
c db 3            
desimt db 10      
temp db 0         
taskas db '.','$' 
pran1  db 'Sveikoji dalis: ','$'
pran2  db ' Liekana: ','$'
pran3 db 'Skaicius su kableliu 5 sk tikslumu: ','$'
                  
temp_sveikoji db 2 dup(0),'$'
temp_liekana db 2 dup(0),10,13,'$'
sveikoji db 2 dup(0),'$'
liekana db 2 dup(0),10,13,'$'
rez db 5 dup(0),'$'
duomenys ends                                                 
                                                              
program segment                                              
  assume ds:duomenys, ss:stekas, cs:program                  
start:                                                        
mov ax,duomenys                             
mov ds,ax                                   
                        
mov ax,002h    ;ekrano isvalymas                                            
int 10h                                                    
                  
mov al,a      ; al=a   
mov bl,b      ; bl=b
add al,bl     ; al=al+bl    
div c         ; al=(al+bl)/c          
                  
mov temp_sveikoji, al
mov temp_liekana, ah
mov ah,0          
div desimt        
cmp al, 0         
je zyme           
mov sveikoji[0], al
add sveikoji[0], 30h
zyme:             
mov sveikoji[1], ah
add sveikoji[1], 30h
                  
mov ah,0          
mov al, temp_liekana
div desimt        
mov liekana[0], ah
add liekana[0], 30h
                  
                  
                  
mov si, 0         
mov ah,0          
mov al, temp_liekana
ciklas:           
mul desimt        
div c             
mov rez[si], al   
add rez[si], 30h  
mov al, ah        
cmp al,0          
je exit           
add si,1          
cmp si, 5 ;tikslumas
jne ciklas        
                  
exit:             
                  
add temp_sveikoji, 30h
                  
  mov ah,09h
   lea dx,pran1   
   int 21h        
                                                        
   mov ah,09h     
   lea dx,sveikoji
   int 21h        
                  
  mov ah,09h
   lea dx,pran2   
   int 21h        
                  
   mov ah,09h        
   lea dx,liekana 
   int 21h        
                     
  mov ah,09h        
   lea dx,pran3   
   int 21h        
                  
   mov ah,09h       
   lea dx,sveikoji
   int 21h 
          
   mov ah,09h
   lea dx,taskas
   int 21h 
            
  mov ah,09h
   lea dx,rez
   int 21h 
           
   mov ah,07h
   int 21h   
         
   mov ax,4C00h                                               
   int 21h  
program ends
end start