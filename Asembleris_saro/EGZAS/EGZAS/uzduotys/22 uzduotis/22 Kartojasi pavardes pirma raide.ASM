stekas segment stack             
 db 256 dup(?)                   
stekas ends                      
                                 
duomenys segment                                     
   bilietas     db 10,13,'Egzamino bilieto numeris 23 $'
   uzduotis db 10,13,'Iveskite teksta ne daugiau 100 simboliu $'
   Kart    db 10,13,'Duomenu kuriose kartojasi pirmas sibolis: $'
   klaida db 10,13,'DEMESIO!Nesikartoja pirmas simbolis! $'
   ats     db 'Simboliu ,atitinkanciu pirma simboli skaicius:  $'
   kiekis  db (?),'$'                  
   koks    db 0                                   
   doleris db 10,13,'$'                           
   masyvas db 100 dup(?),10,13,'$'     
   masyv   db 4 dup(?),10,13,'$'
   des     db 10 
duomenys ends                                     
                                                  
programa segment                                      
assume cs:programa, ds:duomenys, ss:stekas            
start:                                                
mov ax, duomenys                                      
mov ds,ax                                             
mov ax, 0002h       
int 10h                                                   
                                                      
mov ah, 09h         
lea dx, bilietas                                       
int 21h                                           
                                                                       
mov ah,09h          
lea dx, uzduotis                                   
int 21h                                                                   
                                                    
mov cx,0                                          
mov bx,0                                          
                                                        
                              
ciklas:                                                 
     mov ah,0                                     
     mov ah, 08h         
     int 21h                                                             
     mov masyvas[bx],al  
                                                                                                                    
     mov ah,02h          
     mov dl,al           
     int 21h                                                                   
                                                                                  
     inc bx              
                                                                                              
     cmp al,13           
     je next                          
                                                                                             
     inc cx              
jmp ciklas                            
                                      
              
next:                                 
mov ax, 0                
mov bx, 0                             
mov dx, 0                
mov dl, masyvas[bx]      
mov koks, dl               
                         
tikrin:                  
      dec cx             
      inc bx             
      mov dl, masyvas[bx]
      cmp koks, dl       
      je incr                                                          
      cmp cx, 0
      je next2
jmp tikrin                                      
                         
next2:        
     cmp ax, 0  
     je nera                      
     jmp kiek     
nera:                    
    mov ah,09h           
    lea dx,klaida      
    int 21h                   
    jmp exit                  
                              
incr:                         
    inc ax                    
    mov kiekis, al            
    jmp tikrin                        
                              
                                                                       
kiek:                         
mov ax, 0                     
mov cx, 0                      
mov dx, 0                      
mov bx, 0                      
mov di, 0                      
                               
skaicius:                         
       inc di                   
       mov al,0                 
       mov ah,0                 
       mov al, kiekis           
       div des                  
       mov masyv[di], ah        
       mov kiekis, al           
       cmp al, 0                
       je sidi                  
jmp skaicius                    
                                
sidi:                                                                  
mov si, di                      
asci:                           
       add masyv[si], 30h       
       dec si                   
       cmp si, 0                
       je isv                   
jmp asci                        
                                
isv:                                                                   
mov ah, 09h                     
lea dx, doleris                 
int 21h                         
                                
mov ah, 09h                     
lea dx, ats                     
int 21h                         
                                
mov dx, 0                       
isvedimas:                                                             
       mov ah, 02h              
       mov dl, masyv[di]        
       int 21h                  
       dec di                   
       cmp di, 0                                                       
       je exit                                                         
jmp isvedimas                   
                                      
exit:                                 
mov ah,07h                                              
int 21h                                                 
mov ah, 4ch                                             
int 21h                                                 
programa ends                                           
end start                                               
                                
                                
                                
                      