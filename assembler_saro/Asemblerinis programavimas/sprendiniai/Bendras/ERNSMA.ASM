stekas segment stack     
db 256 dup (0)           
stekas ends                
                           
duomenys segment           
pran db 'Darba atliko: Ernestas Smalskys II-3/6',10,13,'$'                           
pran1 db 'Reiksme teigiama',10,13,'$'
pran2 db 'Reiksme neigiama arba lygi nuliui',10,13,'$'
des db 10                  
rez db 3 dup(?),10,13,'$'
a dw 0  
sign db '-','$'                 
                                           
duomenys ends                              
                                           
programa segment                           
assume ss:stekas, ds:duomenys, cs:programa 
start:                                     
                                           
mov ax, duomenys                           
mov ds, ax                                 
mov ax, 02h                                
int 10h 
        
mov ah,  09h
lea dx, pran
int 21h 
                                  
;mov ax, 10  
        
mov a, ax                                                   
cmp ax, 0                                  
jg teigiama                                
                                           
                                           
                                           
mov ah, 09h                                
lea dx, pran2                              
int 21h        
cmp a, 0
je galas 
               
mov ah, 09h    
lea dx, sign   
int 21h        
               
neg a                                   
                                                                                                                       
jmp galas                                  
teigiama:                                                                             
                                           
mov ah, 09h                                
lea dx, pran1                             
int 21h                
                       
                                                                             
galas:                 
                       
      mov ax, a          
                       
      mov cx,3                                                         
      mov si,2                                                         
                                                                                                                                                                                                
ciklas:                                                               
      mov ah,0                                                      
      div des                                                          
      add ah,30h                                                       
      mov rez[si],ah                                             
       cmp al, 0                                                
       je toliau                                                
      dec si                                                           
      loop ciklas                                                
                                                                 
      toliau:                                                   
      mov ah, 09h                                                
      lea dx, rez                                                
      int 21h                                                    
                                                                 
                                                                 
                    
mov ah, 07h                                
int 21h                                    
                                           
mov ah, 4ch                                
int 21h                                    
             
programa ends
end start           
 