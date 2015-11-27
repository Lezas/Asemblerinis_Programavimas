;Laboratorinio darbo uzduotis Nr. 9
;Atliko: Arunas Ciesiunas, II-1/5

;Steko segmentas
stekas segment stack               
  db 256 dup(0)                    
stekas ends            

;Duomenu segmentas                      
duomenys segment               
;Leisime ivesti 20 simboliu
  zodis db 'GEROS DIENOS','$'
  zodis2 db 12 dup('*'),10,13,'$'
tekstas db "Laboratorinio darbo uzduotis Nr. 9",10,13
        db "Uzduotis: Teksto spausdinimas atvirkstine tvarka",10,13
        db "Atliko: Arunas Ciesiunas, II-1/5",10,13,'$'
                                
 ivesta db "Tikrasis tekstas: ",'$'
 pakeistas db "Pakeistas tekstas: ",'$'
                                
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
                                                           
            
;Nustatome kursoriu
  mov ah, 02h
  mov bh, 00h
  mov dh, 7h
  mov dl, 10h
  int 10h


;rodome pranesima                  
  mov ah,09h
  lea dx,ivesta
  int 21h   

           
  mov ah,09h    
  lea dx,zodis  
  int 21h                                     
               
              
;Siunciam pertvarkytus duomenis i zodis2
mov cx, 12
mov bx, 0  
mov ax, 11
ciklas:                         
 lea si,zodis 
 add si, bx
 mov dl,[si]
           
 lea si, zodis2 
 add si, ax
 mov [si],dl              
               
 dec ax        
 inc bx        
loop ciklas       
               
;Nustatome kursoriu
  mov ah, 02h
  mov bh, 00h
  mov dh, 8h
  mov dl, 10h
  int 10h

;Rodom pakeista
  mov ah, 09h  
  lea dx, pakeistas
  int 21h      
               
  mov ah, 09h  
  lea dx, zodis2
  int 21h
            
;Baigiam darba
mov ah,4ch  
int 21h     
                    
programa ends
end start