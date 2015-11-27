;Steko segmentas
stekas segment stack               
  db 256 dup(0)                    
stekas ends            
                 
;Duomenu segmentas                      
duomenys segment               
  zodis db '*lala*mumu*kaka*bebras*andrius',13,10
        db '*gedas*kompas*pele$'                      
 zodis2 db 80 dup(' '),10,13, '$'                
tekstas db 'Kursinio darbo uzduotis Nr.III.23' ,10,13
        db 'Uzduotis: Zodziu skirstymas',10,13   
        db 'Atliko: Andrius Gerasimas, II-2/2',10,13,'$'
                                                 
   ivesta db 'Tikrasis tekstas : ',13,10,'$'     
pakeistas db 13,10,'Pakeistas tekstas: ',13,10,'$'  
 simb dw 0, '$'                                  
 zv   db 0, '$'                                  
 tarp dw ?                                       
                                                 
duomenys ends                                    
                                                 
;Programos segmentas                             
programa segment                                 
  assume ds:duomenys, ss:stekas, cs:programa     
start:                                           
   mov ax,duomenys                               
   mov ds,ax                                     
                                                 
;Isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
                                                 
;Rodome pradini pranesima                        
   mov ah,09h                                    
   lea dx,tekstas                                
   int 21h                                       
                                                        
;rodome pranesima                                
  mov ah,09h                                     
  lea dx,ivesta                                  
  int 21h                                        
  lea dx,zodis                                   
  int 21h                                        
                                                 
 lea si, zodis                                   
 lea di, zodis2                                  
 sub di, si                                      
 dec di                                          
 mov simb, di                                    
                                                 
                                                 
  mov di,0                                       
  mov si,0                                       
ciklas:                                          
                                                 
  cmp zodis[si],'*'                              
  jne ckl                                        
  inc di                                         
                                                 
ckl:                                             
                                                 
  cmp si,simb                                    
  je tarpai                                      
  inc si                                         
  loop ciklas                                    
                                                 
tarpai:                                          
  sub di,1                                       
  mov ax,80                                      
  sub ax,simb                                    
  mov dx,0                                       
  div di                                         
  mov ah,00                                      
  mov tarp,ax                                    
                                                      
                                                 
  lea si,zodis+1                                 
  lea di,zodis2                                  
cikl:                                            
        
                                                     
  mov dl,[si]       
  cmp dl, 13 
  je nesiusk 
  cmp dl, 10 
  je nesiusk      
  mov [di],dl
nesiusk:                                      
                                                 
  inc di                                         
  inc si                                         
                                                 
  cmp si, simb                                   
  je pab                                         
                                                 
  cmp zodis[si],'*'                              
  jne cikl                                       
                                                 
  add di,tarp                                    
  inc di                                         
  inc si                                         
  jmp cikl
         
pab:     
           
;Rodom pakeista
  mov ah, 09h  
  lea dx, pakeistas
  int 21h      
               
  mov ah, 09h  
  lea dx, zodis2
  int 21h
            
;Baigiam darba
mov ah, 07h
int 21h  
mov ah,4ch  
int 21h     
                    
programa ends
end start