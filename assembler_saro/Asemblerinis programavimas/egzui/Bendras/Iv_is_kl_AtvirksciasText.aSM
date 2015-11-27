;----------------------------8proga.asm---------------------------
;---------------Programa atvirksciai isvedanti teksta-------------       
;--------------------Dimitrianas Kondrasovas II-1/3---------------
stekas segment stack                           
       db 256 dup (?)                          
stekas ends                                    
                                               
duomenys segment                               
       vardas  db 'Dimitrianas Kondrasovas II-1/3','$'
       uzd     db 10,13,'Uzduotis Nr8 $'
       tekstas db 10,13,'Iveskite teksta(nedaugiau uz <=30 simboliu)','$'
       iss     db 10,13,'Ivestu simboliu skaicius:','$' 
       doleris db 10,13,'$'                                 
       masyvas db 31 dup(?),10,13,'$'                   ;uzduodu masyva ish 31-elemento
       suma    db 3 dup (?),'$'                                                            
       kiekis  dw (?),'$'                                                                
       des db 10                                                                        
       stulp db(?)                                    
       atv db 'Atvirkscias tekstas:','$'              
duomenys ends                                                                    
                                                      
programa segment                                      
assume cs:programa, ds:duomenys, ss:stekas            
start:                                                
mov ax, duomenys                                      
mov ds,ax                                             
mov ax, 0002h       ;valau ekrana                      
int 10h                                                   
                                                      
mov ah, 09h         ;komanda isvedanti pranesima vardas i ekrana
lea dx, vardas      ;talpinu pranesimo vardas adresa i dx
int 21h                                                                           
                                                                          
mov ah, 09h         ;komanda isvedanti pranesima uzd i ekrana
lea dx, uzd         ;talpinu pranesimo vardas adresa i dx
int 21h                                 
                                        
mov ah,09h          ;komanda isvedanti pranesima tekstas i ekrana
lea dx, tekstas     ;talpinu pranesimo tekstas adresa i dx                 
int 21h                                                                   
                                                    
mov ah,09h          ;perveda i kita eilute kursoriu                                
lea dx, doleris                                                           
int 21h                                                                   
                                                                          
mov cx,0            ;uznulinu cx                                           
mov bx,30           ;30 -> bx, nes daugiau ivesti netelpa                                              
                                                        
;---simboliu irasymo i masyva ciklas---                 
ciklas:                                                 
     mov ah,0            ;uznulinu ah                                   
     mov ah, 08h         ;vieno simbolio nuskaitimas is klaviaturos i aela, al               
     int 21h             ;i dosa                                                
     mov masyvas[bx],al  ;simbolio nuskaityto ish klaviaturos irasymas i masyva kurio elemento numeris bx                    
                                                                                                                    
     mov ah,02h          ;1 simbolio nuskaityto ish klaviaturos isvedimas i ekrana                
     mov dl,al           ;spausdina tai kas dl'e              
     int 21h                                                                   
                                                                                  
     dec bx              ;bx = bx - 1
                                                                                    
     cmp al,13           ;tikrinam ar nebuvo paspaustas "Enter"
     je next             ;jei paspaustas tai keliausim ish ciklo, 13 Enter klavisos kodas
                                                                                             
     inc cx              ;cx = cx+1
jmp ciklas               ;gryztam i ciklo pradzia             
                                                        
next:                                                   
mov kiekis, cx           ;ishsaugojam skaitliuka    
mov bx, 2                ;simbolis nebus didesnis uz trizenkli
mov ah,0                 ;uznulinam ah                           
mov ax, kiekis           ;uzkraunam i ax tai ka reikia ishvesti           
                                   
isved:                   
     div des             ;ah-liekana ;al-sveika dalis       
     add ah, 30h         ;pervedam i 10imtaine
     mov suma[bx],ah     ;ishsaugom liekana   
     dec bx              ;bx = bx - 1
     mov ah, 0           ;uznulinam liekana
     cmp al,0            ;sveika dalis = 0 ?
     je forward          ;jei taip -> forward
jmp isved                ;jei ne tesiam                  
                                   
forward:                           
                                   
mov ah, 09h              ;pranesimo iss isvedimas          
lea dx, iss                                      
int 21h                                          
                                                 
mov ah, 09h              ;isvedam skaiciu                        
lea dx, suma                             
int 21h                                  
                                         
mov ah,02               ;kursoriau nustatymo komanda
mov bh,00               ;ekrano kodas        
mov dh,08               ;eilutes numeris     
mov dl,26               ;stulpelio numeris   
int 10h                                      
                                             
mov ah, 09h             ;isvedam pranesima atv                 
lea dx, atv                                   
int 21h                                       

;suzinom nuo kelinto masyvo elemento isvedinet                                              
mov bx, 30              ;bx=30                      
sub bx, kiekis          ;bx=bx-kiekis                      
mov stulp, 25           ;stulp=25                     
                                              
vidurys:                                      
       mov ah,02            ;kursoriau nustatymo komanda             
       mov bh,00            ;irenginio skaicius - monitorius                            
       mov dh,10            ;eilute          
       mov dl,stulp         ;stulpelis       
       int 10h                               
                                             
       mov ah, 02h          ;isvedimo po viena elementa komanda
       mov dl, masyvas[bx]                                     
       int 21h                                                 
                                             
       inc bx               ;bx = bx + 1                 
       inc stulp            ;stulp = stulp + 1                 
       cmp bx,30            ;bx > 30?
       ja pabaiga           ;jei taip pabaiga                 
jmp vidurys                 ;jei ne vidurys       
                                           
pabaiga:                    ;exitas :)       
mov ah,07h                         
int 21h                            
mov ah, 4ch                        
int 21h                            
programa ends                      
end start                          
