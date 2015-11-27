         
 stekas segment stack 
 db 256 dup (?)       
 stekas ends                    
 duomenys segment               
a db 20,?,5 dup(0),10,13,'$'; nuskaitymas is ekrano ( 20-viso kiek nuskaito simboliu)            
b db 20,?,5 dup(0),10,13,'$';            
c dw 6,?,5 dup(0),10,13,'$'           
d dw 2005                                     
f dw 10        
fi db 100      
fo db 10                                                                
i db 0,10,13,'$'  ;rez   
q db 0,'$' ;spau                                                  
p db 0                                                            
ats dw 0                                                          
m dw 0,'$'                                                        
t1 db 'Vardas:','$'                                               
t2 db 10,13,'Pavarde:','$'                                        
t3 db 10,13,'Gimimas:','$'                                        
t4 db 'Gimimo metai',10,10,13,'$'                                 
t5 db ' metukai','$'                                              
t6 db 'Klaida!Nepazistu nei vieno zmogaus turincio daugiau nei 255 metus',10,13,'$'         
t7 db 10,10,13,'REZULTATAI',10,10,13,'$'                         
 duomenys ends                                                   
 programa segment                                                
 assume cs: programa, ds:duomenys, ss:stekas                     
  start: mov ax, duomenys                                        
         mov ds, ax                                              
         ;tekstinio ekrano ishvalymas                            
         mov ax, 002h                                            
         int 10h                                                 
        ; Pavadinimas                                            
         mov ah,09h                                              
         lea dx,t4  ; Isvedame programos pavadinima Gimimo metai                                             
         int 21h                                                 
         ;Vardo ivedimas                                         
       mov ah,09h                                                
      lea dx,t1; Isvedame Varda                                                 
      int 21h                                                   
      mov ah,0Ah                                                
      lea dx,a                                                  
      int 21h                                                   
             ;Pavardes ivedimas                                 
       mov ah,09h                                               
      lea dx,t2 ; Isvedame Pavarde                  
      int 21h                     
      mov ah,0Ah                  
      lea dx,b                    
      int 21h                     
             ;Gimimo metu  ivedimas
       mov ah,09h                 
      lea dx,t3                   
      int 21h                     
      mov ah,0Ah                  
      lea dx,c                    
      int 21h                     
         ; skaiciavimai           
         ;verciame                
         mov i,0                  
         mov ax,c+2               
         mov ah,0                 
         push ax                  
          mov ax,c+3              
         mov ah,0                 
         push ax                  
          mov ax,c+4              
         mov ah,0                 
         push ax                  
          mov ax,c+5              
         mov ah,0                 
         push ax                  
                                  
         pop ax                   
         sub ax,30h               
         mov ats,ax               
         mov i,1                  
         ups:                     
         add i,1                  
         pop ax                   
         sub ax,30h               
         mov p,1                  
         daug:                    
         mov bx,0                 
         add p,1                  
         mul f                    
         mov bh,p                 
         cmp i,bh                 
         jne daug                 
         add ats,ax               
         mov bl,byte ptr c+1       
         cmp i,bl                 
         jne ups                  
         ;rezultatas ax           
         ; atimam                 
         mov ax,ats               
         sub d,ax                 
         cmp d,255                
         jl upss                  
         mov ah,09h               
         lea dx,t6                
         int 21h                  
                                  
                                  
                                  
          upss:                   
          mov ah,09h              
         lea dx,t7                
         int 21h                    
         ; verciame isvedimui     
                                  
     ;   div f                    
                                  
     mov i,0                      
     mov ax,0                     
     mov al,byte ptr d  
     verc:       
     div fo       
     mov q,al    
     mov al,0      
     add i,1     
     add ah,30h     
     push ax     
     mov ax,0    
     mov al,q    
     cmp al,0    
     jne verc    
                 
     sppp:       
     pop m       
     sub i,1     
     mov ah,09h  
     lea dx,m    
     int 21h     
     cmp i,0     
     jne sppp      
  ;   verc:                        
  ;    cmp al,100                  
  ;    jl des                      
  ;    jge simt                    
  ;    simt:                       
  ;   div fi                       
  ;   jmp visks                    
  ;                                
  ;   des:                         
  ;   cmp al,10                    
  ;   jl ps                        
  ;   div fo                       
  ;   visks:                       
  ;                                
  ;   ps:                          
  ;   add al,30h                   
  ;   mov q,al                     
  ;   mov m,ah                     
  ;   mov ah,09h                   
  ;   lea dx,q                     
  ;   int 21h                      
  ;   mov ax,0                     
  ;   mov al,m                     
  ;   sub i,1                      
  ;    cmp al,0                    
   ;   jne verc                    
  ;                                
                                  
     mov ah,09h                   
     lea dx,t5                    
     int 21h                      
     ;irasymas i faila            
 ;    mov ax,5bH                  
  ;   mov cx,0                    
  ;   lea dx, as.txt              
                                  
                                  
                                  
      ;laukia klavisho paspaudimo  
     mov ah, 07h                  
     int 21h                      
     ;pabaiga                     
      mov ah,4ch                  
      int 21h                     
      programa ends               
      end start