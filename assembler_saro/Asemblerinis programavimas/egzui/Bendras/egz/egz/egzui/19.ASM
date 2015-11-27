stekas segment stack
 db 256 dup (0)
 stekas ends
 duomenys segment
 sk_ilgis equ 5
 desimt db 10
 uzduotis db 'Kursinis Var.13',10,13
          db 'Programa padare Raimondas Rimkevicius ish II-2/3',10,13,10,13
          db 'Programa paprasho vartotoja ivesti skaiciu bei viena simboli,',10,13
          db 'ir ish ivesto simbolio ekrane suformuoja tusciaviduri trikampi,',10,13
          db 'kurio krastines ilgis lygus ivestam skaiciui.',10,13,10,13,'$'
 pran db 13,10,'Rezultatas:',10,13,'$'
 uzduotis1 db 'Iveskite skaiciu: ','$'
 uzduotis2 db 'Iveskite simboli: ','$'
 kl1 db 'Jus ivedete per maza skaiciu!',10,13
     db 'Toliau programa negali testi darbo.',10,13,'$'
 sk db 0,'$'            
 sk_ilgis2 dw 0,'$'     
 a db ?,'$'               
 b dw ?                   
 nl db 13,10,'$'        
 tmp dw 6 dup (?)       
 tpr db ?,'$'           
 tarpas db ' ','$'      
 duomenys ends             
 programa  segment         
 assume cs:programa,ds:duomenys,ss:stekas                                
 start:                    
      mov ax,duomenys      
      mov ds,ax 
            mov ax,0002h         
      int 10h                                                                 
      mov ah,09h
      lea dx,uzduotis      
      int 21h              
                           
;---------------[skaiciaus ivedimas]-----------------------------------
                                                                       
      mov ah,09h ;spausdinama iveskite skaiciu                         
      lea dx,uzduotis1                                                 
      int 21h                                                          
      mov si, sk_ilgis ;irashomas max skaiciaus ilgis                  
      sub si, 1                                                        
      mov di, 0        ;irashomas dabartinis skaiciaus ilgis           
                                                                       
tkr:  mov ah,08h       ;laukia kol bus paspaustas klavishas            
      int 21h                                                          
      mov a,al         ;klavisho reiksme ikelia i a kintamaji                                     
      cmp a, 39h       ;tikrina ar ivesta reiksme yra skaicius         
      jg tbs                                                           
      cmp a, 08h       ;jei nuspaudziamas backspace mygtukas                                       
      je trint                                                         
      cmp a, 13        ;tikrinama ar nuspaustas enter klavishas        
      jl tbs
      je ivestas         
      cmp di, sk_ilgis ;tikrinama ar ivestas skaicius turi maksimalu
      jge tbs          ;skaiciu skaitmenu
      mov cl, a        ;isvedamas skaicius i ekrana
      call print       
                                                                       
tk2:  sub a, 30h       ;vercia klaviaturos koda i skaiciu ir irasho i masyva
      mov al, sk        
      mul desimt        
      mov bx, 0       
      mov bl, a         
      add al, bl
      mov sk, al
      add di, 1        ;isimenama kiek skaitmenu turi skaicius
      sub si, 1  
      jmp tkr                                                          
                                                                       
tbs:                   ;pyp signalas girdimas nuspaudus nenumatyta klavisha
      mov cl, 07h
      call print
      jmp tkr                                                          
                                                                       
trint: mov b, sk_ilgis ;tikrinama ar galima dar trinti skaiciaus skaitmenu
       sub b, 1                                                        
       cmp si, b                                                       
       je tbs
       mov ax, 0h
       mov al, sk
       div desimt
       mov sk, al
       mov cl, 08h    ;perkeliama kursoriaus pozicija i kaire
       call print    
       mov cl, 32       ;istrinamas parashytas skaicius                 
       call print       ;spausdinant tarpo simboli                               
       mov cl, 08h      ;vel perkeliama kursoriaus pozicija kairen                          
       call print      ;nes spausdinant simboli ivyko pasislinkimas                                          
       add si, 1       ;keiciama skaiciaus reiksme masyve              
       sub di, 1       ;keiciamas skaiciaus skaitmenu skaicius
       jmp tkr                                                        
                                                                       
ivestas:                 
       mov sk_ilgis2, di 
       mov ah, 09h      
       lea dx, nl    
       int 21h          
                        
;---------------[simbolio ivedimas]-----------------------------------
       mov ah, 09h      
       lea dx, uzduotis2
       int 21h          
                               
smb:   mov ah,08h       
       int 21h       
       mov a,al         
       mov ah, 09h      
       lea dx, a        
       int 21h
       
       mov ah, 09h
       lea dx, nl
       int 21h
                        
;---------------[rezultatu formavimas]--------------------------------
       
       mov ah, 09h
       lea dx, nl
       int 21h
       
       cmp sk, 1
       jle klaida1

       mov ah, 09h
       lea dx, pran
       int 21h
                
       mov cx, 0
       mov bx, 0
       mov cl, sk
       sub cl, 2
                
       mov ah, 09h      
       lea dx, a
       int 21h  
       mov ah, 09h
       lea dx, nl
       int 21h  
                
sps:   mov ah, 09h
       lea dx, a        
       int 21h  
                
       cmp bx, 1
       jl sp4
       mov si, 0
sp2:   mov ah, 09h
       lea dx, tarpas
       int 21h   
       add si, 1          
       cmp si, bx
       jl sp2   

                
sp4:   add bx, 1
       mov ah, 09h
       lea dx, a        
       int 21h                 
       mov ah, 09h
       lea dx, nl
       int 21h 
       sub cx, 1
       cmp cx, 0
       jg sps
       
       cmp sk, 2
       je pabaiga          
       mov cx, 0    
       mov cl, sk
sp3:   mov ah, 09h
       lea dx, a        
       int 21h  
       loop sp3
       mov ah, 09h  
       lea dx, nl   
       int 21h  
       jmp pabaiga      
          
klaida1:  
       mov ah, 09h      
       lea dx, kl1       
       int 21h    
       jmp pabaiga                
                                                                            
        ;pabaiga                                                       
pabaiga: mov ah,07h
         int 21h                                                       
         mov ah,4ch                                                    
         int 21h
          
 save proc
    mov tmp[0], ax
    mov tmp[1], bx
    mov tmp[2], cx
    mov tmp[3], dx
    mov tmp[4], si
    mov tmp[5], di
    ret   
 save endp
          
 rest proc
    mov ax, tmp[0]
    mov bx, tmp[1]
    mov cx, tmp[2]
    mov dx, tmp[3]
    mov si, tmp[4]
    mov di, tmp[5]
    ret       
 rest endp    
              
 print proc
;    call save
    mov tpr, cl
    mov ah,09h
    lea dx, tpr
    int 21h
 ;   call rest
    ret    
 print endp
             
 programa ends
 end start