stekas segment stack
db 256 dup (?) 
stekas ends    
               
duomenys segment     
minus_s db 00h ; laikysim zenkla
minus_v db 00h  
skait db 5,?,5 dup ('$')
vard db 5,?,5 dup ('$')                                            
v dw 1 dup (00h)
s dw 1 dup (00h)
des db 10 
desw dw 10
             
ats_s db 13,10,'Sveikoji dalis:','$'
ats_v db 13,10,'Liekana:','$'
as db ' Atliko Dovile Mureikaite II-2/1'
   db   ' Asamblerio kursinis darbas Nr: 1','$'
skaitiklis db 13,10,'Iveskite skaitikli:','$'
vardiklis db 13,10,'Iveskite vardikli:','$'
klaid db 13,10,'KLAIDA IVEDANT!...', '$'
duomenys ends       
                    
programa segment                            
assume CS: programa, DS:duomenys, SS:programa   
   start:                                   
   mov ax, duomenys                         
   mov ds, ax                               
                                            
   mov ax, 0002h                            
   int 10h      ; issivalom ekrana            
                                            
   mov ah, 09h                              
   lea dx, as                               
   int 21h                                  
   lea dx, skaitiklis
   int 21h           
                     
   mov ah, 0ah       
   lea dx, skait      
   int 21h       ; ivedam skaitikli
                 
   mov ah, 09h   
   lea dx, vardiklis
   int 21h       
                 
   mov ah, 0ah   
   lea dx, vard  
   int 21h       ; ivedam vadrikli
                                  
                                  
   xor ch, ch   ; isvalom ch      
   mov cl, skait + 1 ; ciklo skaicius    
   lea si, skait + 2 ; duomenu adresas    
tikrinam1:                         
   mov al, [si]                   
   cmp al, 2dh ; ar tai '-' ?     
   je  minusas1 ; tada viskas gerai
                                  
   cmp al, 30h ;                  
   jl  klaida1  ; jei < '0'        
                                  
   cmp al, 39h                    
   jg  klaida1  ; jei > '9'        
                                  
   sub al, 30h ; paverciam i skaiciu 
   mov [si], al 
 ;  xor ah, ah  ; issivalom        
 ;  add bx, ax  ; pridedinejam     
                                  
   jmp gerai1                      
minusas1:                          
   mov minus_s, 01h ; ?
   jmp gerai1    
klaida1:         
   jmp programos_klaida           
gerai1:          
   inc si        
   loop tikrinam1 
   ; kai turim skaiciu padrika .... 
   xor cx, cx   
   xor ax, ax    
   xor bx, bx    
   mov cl, skait + 1 ;skaitiklis
   lea si, skait + 2
   cmp minus_s, 01h                       
   je  pastumiam1     ; jei minusas
   jmp pervedimas1
pastumiam1:            
   inc si   ; vienu maziau, praleisim minusa                  
   dec cl   ; ciklas taip pat              
pervedimas1:                
   mul des      
   mov bl, [si] 
   add ax, bx      
   inc si          
   loop pervedimas1                      
                
   mov s, ax  ; issisaugom reiksme             
   ; TA PATI ATLIEKAM SU ANTRU !!!              
                 
   xor ch, ch   ; isvalom ch
   mov cl, vard + 1 ; ciklo skaicius    
   lea si, vard + 2 ; duomenu adresas    
tikrinam2:                         
   mov al, [si]                   
   cmp al, 2dh ; ar tai '-' ?     
   je  minusas2 ; tada viskas gerai
                                  
   cmp al, 30h ;                  
   jl  klaida2  ; jei < '0'        
                                  
   cmp al, 39h                    
   jg  klaida2  ; jei > '9'        
                                  
   sub al, 30h ; paverciam i skaiciu 
   mov [si], al; ten pat irasom pervesta
  ; xor ah, ah  ; issivalom        
  ; mul des     ; padauginam is 10
  ; add bx, ax  ; pridedinejam     
                                  
   jmp gerai2                      
minusas2:                          
   mov minus_v, 01h ; minusas tada...
   jmp gerai2    
klaida2:         
   jmp programos_klaida           
gerai2:          
   inc si                 
   loop tikrinam2         
   ; persivedam i suma, kaip viena skaiciu  
   xor cx, cx    
   xor ax, ax    
   xor bx, bx    
   mov cl, vard + 1 ;skaitiklis                                       
   lea si, vard + 2
   cmp minus_v, 01h                       
   je  pastumiam2     ; jei minusas
   jmp pervedimas2
pastumiam2:            
   inc si   ; vienu maziau, praleisim minusa                  
   dec cl   ; ciklas taip pat              
pervedimas2:                
   mul des      
   mov bl, [si] 
   add ax, bx   
   inc si       
   loop pervedimas2                      
   ; atliekam veiksmus:
                
   xor dx, dx   
                
   mov bx, ax    ; bx vardiklis
   mov ax, s     ; ax skaitiklis  
                
   div bx       
                
   ; ax - sveikoji
   ; dx - liekana
                
   mov s, ax    ; dabar cia saugosim skaitikli
   mov v, dx    ; ... cia vardikli
                
   mov ah, 09h  
   lea dx, ats_s
   int 21h      
   ; gudrybe :) 
   mov al, minus_v
   xor minus_s, al ; jei bus minus_s:00 - teigiamas; 01 - neigiamas ats   
                
   cmp minus_s, 00h ; ar vienodi zenklai ?
   je  teigiamas
                
   mov dx, 002dh ; '-' 
   mov ah, 02h  
   int 21h                            
teigiamas:      ; isvedimo organizavimas  
   push '$'     ; nuo galo
   mov ax, s       
istacka:        
   xor dx, dx   
   div desw      
   push dx               
   cmp ax, 0000h
   je  spausdinam       
   jmp istacka   
spausdinam:     
   pop dx       
   cmp dx, '$' ; pabaiga? :)
   je endas                        
   add dx, 30h  
   mov ah, 02h  
   int 21h      
   jmp spausdinam                         
endas: ; sveikaja dali isspausdinom
  ; daba liekana spausdinsim
                
   mov ah, 09h  
   lea dx, ats_v
   int 21h      
                                
   cmp minus_s, 00h ; ar vienodi zenklai ?
   je  teigiamas2 
                
   mov dx, 002dh ; '-' 
   mov ah, 02h  
   int 21h                            
teigiamas2:      ; isvedimo organizavimas  
   push '$'     ; nuo galo
   mov ax, v       
istacka2:        
   xor dx, dx   
   div desw      
   push dx               
   cmp ax, 0000h
   je  spausdinam2       
   jmp istacka2   
spausdinam2:    
   pop dx       
   cmp dx, '$' ; pabaiga? :)
   je endas2                        
   add dx, 30h
   mov ah, 02h
   int 21h   
   jmp spausdinam2
endas2: ; sveikaja dali isspausdinom
                                                  
  ; atsisvekinimas                         
   jmp dosas     
programos_klaida:               
   mov ah, 09h  
   lea dx, klaid
   int 21h      
dosas:                
   mov ah, 07h   
   int 21h       ; laukiam paspaudimo  
             
   mov ah, 4ch  
   int 21h               
programa  ends  
end start