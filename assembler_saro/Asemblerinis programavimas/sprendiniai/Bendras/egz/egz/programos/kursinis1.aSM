;Sudeda tris ivestus skaicius ir analizuoja rezultata
stekas segment stack                            
db 256 dup (?)                                  
stekas ends                                     
                                                
duomenys segment                                
Pran1 db 10,13,'Rezultatas yra neigiamas! $'       
Pran2 db 10,13,'Rezultatas yra teigiamas! $'       
Pran3 db 10,13,'Rezultatas yra nulis! $'
simbolis  db 10,13,'Neteisingas simbolis $'     
press  db 10,13,'Press any key  $'
aenter db 10,13,'Iveskite a: $'
benter db 10,13,'Iveskite b: $'
center db 10,13,'Iveskite c: $'
rfailas db "c:\tasm\temp\rez.doc",0          
handle dw 0                         
tempb db 0                                      
am dw 0                                         
ap dw 0                                         
des db 10                                      
tempwm dw (?)                                   
tempwp dw (?)                                   
info db 5,5 dup (?),'$'                         
duomenys ends                                   
                                                
programa segment                                
assume cs:programa, ds:duomenys, ss:stekas      
start:                                          
mov ax, duomenys                                
mov ds, ax                                      
mov ax, 0002h           ;ekrano valymas
int 10h
 
mov ah,3ch              ;failo sukurimas
mov cx,0
mov dx,offset rfailas
int 21h
       
                                        
mov ah, 09h             ;a ivedimo pranesimas      
lea dx, aenter                                  
int 21h                                         
call ivedimas           ;eina i ivedimas:                  
                                                
mov ah, 09h             ;b ivedimo pranesimas
lea dx, benter                                  
int 21h                                         
call ivedimas           ;eina i ivedimas:                  
                                                
mov ah, 09h             ;c ivedimo pranesimas                
lea dx, center                                  
int 21h                                         
call ivedimas           ;eina i ivedimas                
jmp patikrinimas            ;eina i patikrinima                
daugiau:                ;isveda pranesima Pran2                  
mov ah, 09h                                     
lea dx, Pran2
int 21h 

mov handle,ax
mov ah,40h
mov bx,handle
int 21h
jmp pabaiga      
patikrinimas:                                       
mov ax, ap              ;ap=ax     
cmp ax, am              ;tikrina ax su am
je nulis                ;jei lygus tai eina i nulis
ja daugiau              ;jei ax>am tai eina i daugiau 
jmp maziau              ;jei ax nelygu ir nedaugiau tada eina i maziau
                                                                 
pabaiga:           ;programos pabaiga
mov ah, 07h                                     
int 21h                                         
mov ah, 4ch                                     
int 21h                                         
                                                
nulis:                  ;isveda pranesima Pran3                 
mov ah, 09h                                     
lea dx, Pran3                                  
int 21h

mov handle,ax
mov ah,40h
mov bx,handle
int 21h                                              
jmp pabaiga                                       
                                                
maziau:                 ;isveda pranesima Pran1                  
mov ah, 09h                               
lea dx, Pran1                            
int 21h 

mov handle,ax
mov ah,40h
mov bx,handle
int 21h                                             
jmp pabaiga                                 
nera:                   ;isveda pranesima simbolis ir laukia klavisho paspaudimo                  
mov ax, 0002h                             
int 10h                                   
mov ah, 09h                               
lea dx, simbolis                          
int 21h                                   
mov ah, 07h                               
int 21h                                   
call start                                           
next:                                     
ret                            ;return           
                                          
ivedimas:                      ;ivedimas           
        mov bx, 0              ;uznulinam bx         
        mov ah, 0Ah            ;nuskaitymo is klaviaturos komanda            
        lea dx, info           ;patalpina i buferi adresa                                  
        int 21h                                          
        mov bl, info[1]        ;skaitliukas, kiek elementu ivedem               
        mov si, 0              ;uznulina si
        mov al, 0              ;uznulina al                          
        mov tempb, 0           ;uznulina tempb                       
        cmp info[2], 57        ;tikrina ar neivestas simb. su kodu ASCII lenteleje > 57
        ja nera                ;jei ivesto simb. kodas > 57 eina i nera
        cmp info[2], 45        ;tikrina ar neivestas simb. su kodu ASCII lenteleje < 45
        jb nera                ;jei ivesto simb. kodas < 45 eina i nera
        cmp info[2], 46        ;tikrina ar neivestas simb. su kodu ASCII lenteleje = 46
        je nera                ;jei ivesto simb. kodas = 46 eina i nera
        cmp info[2], 47        ;tikrina ar neivestas simb. su kodu ASCII lenteleje = 47
        je nera                ;jei ivesto simb. kodas = 47 eina i nera
        cmp info[2], 48        ;tikrina ar neivestas simb. su kodu ASCII lenteleje = 48
        je next                ;jei ivesto simb. kodas = 48 eina i next
        cmp info[2], 45        ;tikrina ar neivestas simb. du kodu ASCII lenteleje = 45
        je tikrinam            ;jei ivesto simb. kodas = 45 eina i tikrinum
        cmp info[2], 47        ;tikrina ar neivestas simbolis su kodu ASCII > 47
        ja desimt              ;jei ivesto simb. kodas > 47 eina i desimt
tikrinam:                                                                             
mov si, 1                      ;si->1                                                       
sub bl, 1                      ;atima is bl viena, nes mum reikes vienu maziau jei minusas                                                                                
desimt:                        ;al*10+cl, pilno skaiciau gavimas
        mov cl, info[si+2]     ;ikelia info[si+2] reiksme i cl                                                   
        sub cl, 30h            ;atima is cl 30, kad gautu simboli skaiciu
        mov al, tempb          ;tempb -> al                                                   
        mul des                ;al*10                                                   
        add al, cl             ;al*10+cl                                                   
        mov  tempb, al         ;al -> tempb                                                   
        inc si                 ;si=si+1                                                   
        dec bl                 ;bl=bl-1                                                   
        cmp bl,0               ;tikrina ar lygu bl nuliui
        je minplius            ;jei bl=0 eina i minplius                          
jmp desimt                     ;soka i desimt                         
minplius:                                    
        cmp info[2],45         ;tikrina ar info[2] yra minusas           
     je minusas                ;jei info[2] yra minuso kodas 45 eina i minusas                               
        cmp info[2],47         ;tikrina ar info[2] yra pliusas      
     ja pliusas                ;jei info[2] yra pliuso kodas 47 eina i pliusas
minusas:                       ;sudeda skaicius patekusius i cikla                                               
    mov al, tempb              ;tempb=al                          
    mov byte ptr tempwm, al    ;al=tempwm                         
    mov ax, 0                  ;                                               
    mov ax, am                 ;am=ax                             
    add ax, tempwm             ;ax=tempwm + ax                    
    mov am, ax                 ;ax=am                             
jmp next                       ;einu i next                                   
pliusas:                       ;sudeda skaicius patekusius i cikla                                    
    mov cx, 0                                                     
    mov cx, ap                                                    
    mov al, tempb                                 
    mov byte ptr tempwp, al                       
    add cx, tempwp                                
    mov ap, cx                                    
jmp next                                          
                                             
programa ends                                
end start