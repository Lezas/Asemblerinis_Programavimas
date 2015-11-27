 
  ;klaviatura         
 stekas segment stack 
 db 256 dup (?)       
 stekas ends                    
 duomenys segment               
a db 25,?,10 dup(0),10,13,'$'            
b db 25,?,10 dup(0),10,13,'$'            
c dw 6,?,5 dup(0),10,13,'$'           
d dw 2005                                     
f dw 10        
reikia db 0,'$'         
handle dw ?       
failas db "c:\tasm\temp\failas.txt",0          
;fi db 100        
zod1 db 0,'$'         
fo db 10                                                                
i db 0,10,13,'$'  ;rez        
q db 0,'$' ;spau                                                  
p db 0                                                            
ats dw 0                                                          
m dw 0,'$'              
zod dw 0,10,13,'$'                                                            
t1 db 'Vardas:','$'                                               
t2 db 10,13,'Pavarde:','$'                                        
t3 db 10,13,'Gimimas:','$'                                        
t4 db 'Gimimo metai',10,10,13,'$'                                 
t5 db ' metai(u) ','$'                                              
t6 db 10,13,'Klaida!Nepazistu nei vieno zmogaus turincio daugiau nei 255 metus',10,13,'$'         
t7 db 10,10,13,'REZULTATAI',10,10,13,'$'                               
tarpas db ' ','$'                                                      
t8 db 10,10,10,10,10,13,'Rezultatu failas patalpintas c:\tasm\temp\failas.txt',10,13,'$'
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
         lea dx,t4                                               
         int 21h                                                 
         ;Vardo ivedimas                                         
       mov ah,09h                                                
      lea dx,t1                   
      int 21h                     
      mov ah,0Ah                  
      lea dx,a                    
      int 21h                     
             ;Pavardes ivedimas   
       mov ah,09h                 
      lea dx,t2                   
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
         ;1 ivedame po 1 i steka
         lea bx,c+1                
         mov i,0                
         pushinimas:            
         add bx,1               
         add i,1                
         mov cx,[bx]            
         mov ch,0               
         push cx                
         mov al, byte ptr c+1                
         cmp al,i               
         jne pushinimas         
          mov ax,0
          mov bx,0
          mov cx,0
          mov i,0                      
         ;2 ishimame ish steko,atimam 30 ir sudarom 1 skaiciu is 4 skaitmenu                       
         pop ax                                                             
         sub ax,30h                                                         
         mov ats,ax                                                         
         mov i,0                                                            
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
                        
                        
                        
         ;verciame atgal                
         mov ax,ats               
         sub d,ax                 
         cmp d,255                
         jl upss                  
         mov ah,09h               
         lea dx,t6                
         int 21h                  
         jmp pabaiga                                                       
          ;skaiciuojam                        
          upss:                              
                                             
                                             
             ;failo sukurimas
     mov ah,3ch         
     lea dx,failas      
     mov cx,0           
     int 21h            
     mov handle,ax      
         ; uzhrashas REZULTATAI                   
          mov ah,09h              
         lea dx,t7                
         int 21h        
        ; isvedame varda,pavarde
                        
                        
        ;  verciame varda  
              mov si,0         
       mov di,1                   
         lea si,a+1            
         jk:            
         inc di         
         add si,1       
         mov cl,[si]    
         mov zod1,cl    
         mov ax,0       
         mov dx,0       
         mov ah,09h     
         lea dx,zod1    
         int 21h              
     ;irasymas i faila            
     mov ah,40h         
     mov bx,handle                                      
    lea dx,zod1           
    mov cx,1                 
    int 21h                          
         mov zod,di     
         mov cl,byte ptr zod    
         cmp cl,a+1         
         jle jk         
                        
                        
    ; tarpelis tarp vardo ir pavardeas            
    mov ah,09h                        
    lea dx,tarpas                     
    int 21h                           
            ;irasymas i faila            
     mov ah,40h                       
     mov bx,handle                                      
    lea dx,tarpas                     
    mov cx,1                          
    int 21h                           
                                      
                                      
                                      
     ;verciame pavarde         
                mov si,0
                        
                mov di,1        
                lea si,b+1            
         jk1:           
         add di,1           
         add si,1       
         mov cl,[si]    
         mov zod1,cl    
                        
         mov ax,0       
         mov dx,0       
         mov ah,09h     
         lea dx,zod1    
         int 21h        
   ;irasymas pavardes i faila            
     mov ah,40h         
     mov bx,handle                                      
    lea dx,zod1           
    mov cx,1                     
    int 21h             
        mov cl,0         
         mov zod,di     
         mov cl,byte ptr zod    
         cmp cl,b+1         
         jle jk1        
                        
         ;tarpelis      
           mov ah,09h                        
    lea dx,tarpas                     
    int 21h             
              mov ah,40h                       
     mov bx,handle                                      
    lea dx,tarpas                     
    mov cx,1                          
    int 21h                           
                        
         ; verciame metus isvedimui     
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
     mov ax,0           
                        
     sub i,1            
                        
     mov bx,handle                                      
    mov ax,m                 
    mov reikia,ah       
    lea dx,reikia           
    mov cx,1            
     mov ah,40h                          
    int 21h             
     mov ah,09h         
     lea dx,reikia           
     int 21h            
            ;irasymas metu i faila  
      mov ah,0          
      mov bx,0          
      mov dx,0                  
                        
     cmp i,0            
     jne sppp                    
                        
                              
                                  
     mov ah,09h                   
     lea dx,t5                    
     int 21h            
             ;irasymas i faila            
     mov ah,40h         
     mov bx,handle                                      
    lea dx,t5           
    mov cx,9                 
    int 21h                
                        
     ;failo uzdarymas              
     mov ah,3eh         
     mov bx,0           
     int 21h  
     mov ah,09h
     lea dx,t8  
     int 21h                           
                                  
   pabaiga:                               
      ;laukia klavisho paspaudimo  
     mov ah, 07h                  
     int 21h                      
     ;pabaiga                     
      mov ah,4ch                  
      int 21h                     
      programa ends               
      end start 