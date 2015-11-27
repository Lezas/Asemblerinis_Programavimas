


       
stekas segment stack                           
       db 256 dup (?)                          
stekas ends                                                         
                                                                    
duomenys segment                                                    
       atl  db 'Atliko:SIGITA CIAPAITE II-2/6 ',10,13,'$'           
       pav  db 'Asemblerinio programavimo kursinis darbas',10,13,'$'
       uzd  db 10,13                                                
            db 'Uzduotis Nr.2',10,13                                
            db 'Programa papraso vartotojo ivesti simboliu eilute',10,13
            db 'ir isveda dvi naujas eilutes, kuriu pirmoji sudaryta',10,13         
            db 'is ivestos eilutes mazuju raidziu, ',10,13            
            db 'o antroji-is didziuju raidziu',10,13                                                  
            db '(neraidziu simboliai ignoruojami).',10,13,'$'         
       ived db 10,13,'Iveskite eilute ir paspauskite ENTER: ',10,13,'$'                                 
       masyvas db 128 dup (?),'$'                                     
       mazos db 128 dup (?), '$'                                      
       dideles db 128 dup (?), '$'                                                                                                                                                                      
       stulp   db (?)                                                                                             
      ; atv     db 'Pertvarkyta simboliu eilute:','$'                  
duomenys ends                                                                    
                                                                      
programa segment                                                      
assume cs:programa, ds:duomenys, ss:stekas                            
start:                                                                
mov ax, duomenys                                                      
mov ds,ax                                                             
                                                                      
mov ax, 0002h       ;valau ekrana                                     
int 10h                                                               
                                                                      
mov ah,09h                                                            
lea dx,pav                                                            
int 21h                                                               
                                                                      
mov ah, 09h                                                           
lea dx, atl                                                           
int 21h                                                                           
                                                                          
mov ah, 09h                                                           
lea dx, uzd                                                           
int 21h                                                               
                                                                      
mov ah,09h                                                            
lea dx, ived                                                          
int 21h                                                                   
                                                                      
mov cx,0;skaiciuos smb skaiciu    (jei jo nebutu isvestu maz raides n kartu)                                                                                                                                                                             
mov bx,0                                                            
mov si, 0                                                           
mov di, 0                                                                     
                                                                    
ciklas:                                                             
                                                                    
mov ah,0                                                            
mov ah, 01h         ;pavienis nuskaitymas,irasoma i al               
int 21h                                                             
mov masyvas[bx],al  ;irasau simboli i masyva, kur bx yra jo numeris                                                                                                                                                                                                                
inc bx               ;+1                                                         
                                                                                    
cmp al,13           ;13 - Enter mygtuko kodas                       
je tarpinis                                                         
                                                                    
inc cx   ;sk smb skaiciu                                                           
jmp ciklas               ;gryztam i ciklo pradzia                   
                        ;cikla vykdom kol pasp enter                                            
tarpinis:                                                                                                                 
mov bx,0                                                            
jmp next                                                            
                                                                    
next:                                                                      
cmp cx,0  ;ar ivesta smb,arba ar ju dar yra                                                          
je done                                                             
mov al,masyvas[bx]                                                  
                                                                    
cmp al,61h                                                          
jge maz1  ; jei >= 61 (mazuju raidziu apatine riba)                 
jmp did                                                             
                                                                    
maz1:                                                               
cmp al,7Ah                                                          
jle mazoji  ; jei <=7A (mazuju raidziu virsutine riba)              
jmp kitas                                                           
                                                                    
did:                                                                
cmp al,41h                                                          
jge did1 ; jei >=41 (didziuju raidziu apatine riba)                 
jmp kitas                                                           
                                                                    
did1:                                                               
cmp al,5Ah                                                          
jle didzioji ; jei <=5a (didziuju raidziu virsutine riba)           
jmp kitas                                                           
                                                                    
mazoji:                                                             
;sub al,20h  ;pakeiciam i didziaja raide                            
mov mazos[si],al                                                    
inc si  ; i kt vieta                                                            
inc bx ;i kt smb                                                             
dec cx  ;-1 kiek dar liko smb                                                            
jmp next                                                            
                                                                    
didzioji:                                                                                      
mov dideles[di],al                                                  
inc di                                                              
inc bx                                                              
dec cx                                                              
jmp next                                                            
                                                                    
kitas:                                                              
inc bx                                                              
dec cx                                                              
jmp next                                                            
                                                                    
done:                                                               
mov bx,0                                                            
mov stulp,0         ;bus reikalinga rez spausdinimui stulpeliams didinti                                  
jmp rezMAZ                                                               
                                                                        
rezMAZ:                                                                    
mov ah,02        ;kursoriaus nustatymo komanda                          
mov bh,00        ;ekrano kodas                                          
mov dh,14       ;eilute nr                                              
mov dl,stulp     ;stulpelio nr                                          
int 10h                                                                 
                                                                        
mov ah, 02h          ;isvedimas i ekrana po viena simboli               
mov dl, mazos[bx]                                                       
int 21h                                                                 
                                                                        
inc stulp                                                               
inc bx                                                                  
cmp bx,si                                                               
ja done1       ;bx>si nes si-perejimas i kt vieta, o bx-paima kt smb                                    
jmp rezMAZ                                                              
                                                                        
done1:                                                                  
mov bx,0                                                                
mov stulp,0         ;bus reikalinga rez spausdinimui stulpeliams didint 
                                                                        
rezDID:                                                                 
mov ah,02        ;kursoriaus nustatymo komanda                          
mov bh,00        ;ekrano kodas                                          
mov dh,15       ;eilute nr                                              
mov dl,stulp     ;stulpelio nr                                          
int 10h                                                                 
                                                                        
mov ah, 02h          ;isvedimas i ekrana po viena simboli               
mov dl, dideles[bx]                                                     
int 21h                                                                 
                                                                        
inc stulp                                                               
inc bx                                                                  
cmp bx,di                                                               
ja pabaiga                                                              
jmp rezDID                                                              
                                                                        
pabaiga:                                                                
                                                                        
mov ah,07h                                                              
int 21h                                                                 
mov ah, 4ch                                                             
int 21h                                                                 
                                                                        
programa ends                                                           
end start                                                               
