;----------------------6proga.asm---------------- 
;--------Sudedanti masyvo elementus su isvedimu--
;-------------Dimitrianas Kondrasovas II-1/3-----
stekas segment stack                   
 db 256 dup(?)                         
stekas ends                            
                                       
duomenys segment                       
      vardas db 10,13,'Dimitrianas Kondrasovas II-1/3','$'
      uzd    db 10,13,'Uzduotis Nr6','$'
      dolar  db 10,13,'Atsakymas: $'   
      min    db '- $'                  
      oa     db 10,10,-30,-50,30
      sum    db 0                      
      des    db 10                     
      masyv  db 4 dup(0),'$'           
      temp   db (?)                    
duomenys ends                          
                                                   
programa segment                                   
 assume cs:programa, ds:duomenys, ss:stekas                   
start:                                                        
mov ax,duomenys                        
mov ds,ax                              
mov ax, 0002h                   ;ekrano valimas  
int 10h                                       
                                                              
mov ah,09h                      ;isveda i ekrana
lea dx, vardas                  ;vardo adresas
int 21h                                                       
                                       
mov ah,09h                      ;isveda i ekrana
lea dx, uzd                     ;uzd adresas
int 21h                                
                                                              
mov bx,0                        ;uznulinau skaitliuka bx
mov cl, 0                       ;uznulinu cl                  
ciklas:                                                        
       add cl, oa[bx]           ;sudedu oa elementus po viena
       mov sum, cl              ;cl -> sum         
       pushf                    ;issaugau flagu reikshmes
       inc bx                   ;padydinu vienetu bx
       cmp bx, 5                ;lyginu ar bx maziau uz vieneta, jei maziau tai toliau jei daugiau iseinu is ciklo
jb ciklas                       ;jump below keliauju i ciklas:
                                          
popf                            ;ishimu flagu reikshmes         
js minusas                      ;jei flagas s=1 einu i minusas:                       
jmp pliusas                     ;jei flagas s=0 einu i pliusas:                               
                                                               
minusas:                                                       
pushf                           ;saugau flagu reikshmes                               
neg sum                         ;invertuoju skaiciu                       
                                                   
pliusas:                                           
mov di, 0                       ;0 -> ;tai bus skaitliukas skaiciuojantis skaiciu kieki                  
skaicius:                                                                              
       inc di                   ;di+1                                                  
       mov al,0                 ;0 -> al                                               
       mov ah,0                 ;0 -> ah                                               
       mov al, sum              ;sum -> al                                             
       idiv des                 ;dalinu ish desimt                                     
       mov masyv[di], ah        ;idedu liekana i masyv                                 
       mov sum, al              ;pilna skaiciu dedu i sum                              
       cmp al, 0                ;tikrinu ar al=0                                       
       je next                  ;jei al=0 shokstam i next                   
jmp skaicius                    ;jei al nelygu 0 kartojam cikla                         
                                                               
next:                                                          
mov si, di                      ;di -> si                              
asci:                           ;verciam neaiskius simbolius :) i skaicius pagal ASCI                               
       add masyv[si], 30h       ;pridedu prie simbolio 30 kad gautus skaicius
       dec si                   ;si-1                               
       cmp si, 0                ;tikrinu ar si=0               
       je next2                 ;jei si=0 shokstam i next2     
jmp asci                        ;jei si nelygu 0 kartojam cikla
                                                               
next2:                                                         
mov ah, 09h                     ;talpinam isvedimo komanda 09h i ah                               
lea dx, dolar                   ;dolar adresas -> dx                               
int 21h                         ;i DOS ir isvedu simboli $                               
popf                            ;istraukiu flagu parametrus                                
js minus                        ;jei s=1 einu i minus, jei ne toliau                               
mov dx, 0                       ;dx->0                                    
isvedimas:                                           
       mov ah, 02h              ;isvedimo po viena simboli komanda 
       mov dl, masyv[di]        ;spausdinam tai kas dl'e                                  
       int 21h                  ;DOS                        
       dec di                   ;di-1                
       cmp di, 0                ;jei di=0 einu i exit    
       je exit                                       
jmp isvedimas                   ;jei di nelygu 0 kartoju cikla                    
                                                              
minus:                                                        
mov ah, 09h                                                   
lea dx, min                                                   
int 21h                         ;isvedu min pranesima                              
jmp isvedimas                                                 
                                                              
exit:                                                         
       mov ah,07h               ;komanda laukianti klavisho paspaudimo                              
       int 21h                                                        
       mov ah,04Ch              ;pabaigos komanda                              
       int 21h                  ;dos                              
                                ; :)                              
Programa ends                                                 
end start