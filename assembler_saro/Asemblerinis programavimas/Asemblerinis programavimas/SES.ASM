;Uzduoti atliko :)
stekas segment stack               
  db 256 dup(0)                    
stekas ends       
cr        equ 13                
lf        equ 10                     
                      
duomenys segment               
  kiek db 20, ?  
  vardas db 20 dup('*'),cr,lf,7,'$'   
  ekranas   db 'Uzduoti atliko: ',cr,lf,7,'$'
  ivesk db 'Iveskite varda: ',cr,lf,7,'$'
  ssk db 1 dup(0),'$'
duomenys ends                                  
                                               
programa segment                               
  assume ds:duomenys, ss:stekas, cs:programa   
start:                                         
   mov ax,duomenys                             
   mov ds,ax                                   
   ;isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
                                    
 ;rodome pranesima                  
   mov ah,09h                                  
   lea dx,ivesk                     
   int 21h                                     
                                                           
;vardas:                            
    mov ah,0Ah   
    mov bx,0                        
    lea dx, kiek
    int 21h                       
                                    
 
  ;isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
  
 ;rodome pranesima                  
   mov ah,09h                                  
   lea dx,ekranas                              
   int 21h                                     
                                    
   mov cl, kiek+1
   mov ssk, cl                      
   
   mov ax, ssk
   mov bx, 0  
              
                
   mov vardas+4, '$'
   
   mov ah,09h   
   lea dx, vardas
   int 21h                                     
                
                                    
   ;rodome pranesima                
   mov ah,09h                                  
   lea dx,ssk                       
   int 21h                          
                                    
;   CMP ax, bx                      
;   JE lygus                      
;   JG didesnis                   
;   JL mazesnis                  
                                 
                                 
; lygus:                         
 ;rodome pranesima               
 ;  mov ah,09h                                  
 ;  lea dx,lygus1                
 ;  int 21h                      
                                
;mov ah,4ch                      
;int 21h                         
                                
;didesnis:                       
 ;rodome pranesima              
 ;  mov ah,09h                                  
 ;  lea dx,didesnis1             
 ;  int 21h                      
                     
;mov ah,4ch         
;int 21h            
                    
;mazesnis:                 
 ;rodome pranesima 
 ;  mov ah,09h                                  
 ;  lea dx,mazesnis1   
 ;  int 21h          
                  
mov ah,4ch        
int 21h  
         
programa ends
end start