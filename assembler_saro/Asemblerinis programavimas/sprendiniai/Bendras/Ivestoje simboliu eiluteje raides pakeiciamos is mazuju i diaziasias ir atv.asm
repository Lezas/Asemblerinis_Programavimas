stekas segment stack                           
       db 256 dup (?)                          
stekas ends                                    
                                               
duomenys segment                               
       vardas  db 10,13,'Atliko:Viktorija Briskmanaite, II-04/4','$'
       uzd     db 10,13,10,13,10,13,'Uzduotis:Ivestoje simboliu eiluteje raides pakeiciamos is mazuju i diaziasias ir atv, kiti nekinta.',10,13,'$'
       tekstas db 10,13,'Iveskite simboliu eilute: ','$'
       doleris db 10,13,'$'                                 
       masyvas db 128 dup (?),'$'                                                        
       kiekis  dw (?),'$'                                                                                                                
       stulp   db (?)  
       skait   dw (?),'$'                                 
       atv     db 'Rezultatas:','$'
duomenys ends                                                                    
                                                      
programa segment                                      
assume cs:programa, ds:duomenys, ss:stekas            
start:                                                
mov ax, duomenys                                      
mov ds,ax  
;ekrano isvalymas                                           
mov ax, 0002h                      
int 10h                                                   
                                                      
mov ah, 09h         
lea dx, vardas      
int 21h                                                                           
                                                                          
mov ah, 09h         
lea dx, uzd         
int 21h                                 
                                        
mov ah,09h          
lea dx, tekstas                     
int 21h                                                                   
                                                    
mov ah,09h                                          
lea dx, doleris                                                           
int 21h                                                                   
mov cx,0                                                                                                                                                                             
mov bx,0                                                                     


ciklas:                                                 

mov ah,0                                               
mov ah, 08h         ;pavienis nuskaitymas, al               
int 21h                                                             
mov masyvas[bx],al  ;irasau simboli i masyva, kur bx yra jo numeris                    
                                                                                                                    
mov ah,02h          ;pavienis isvedimas i ekrana                
mov dl,al                         
int 21h                                                                   
                                                                                  
inc bx              
                                                                                    
cmp al,13           ;13 - Enter mygtuko kodas
je tarpinis
             
inc cx                                                                                                  
jmp ciklas               ;gryztam i ciklo pradzia             
                                                        

tarpinis:
mov skait,cx
mov bx,0
jmp next

next:                                                                      

cmp cx,0
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
sub al,20h  ;pakeiciam i didziaja raide
mov masyvas[bx],al
inc bx
dec cx
jmp next

didzioji:
add al,20h  ;pakeiciam i mazaja raide
mov masyvas[bx],al
inc bx
dec cx
jmp next

kitas:
inc bx
dec cx
jmp next

done:
mov bx,0                
mov stulp,0         ;bus reikalinga rez spausdinimui stulpeliams didint
jmp rezult                                                               

rezult:                                                                    
mov ah,02        ;kursoriaus nustatymo komanda
mov bh,00        ;ekrano kodas
mov dh,14        ;eilute nr
mov dl,stulp     ;stulpelio nr
int 10h
                                             
mov ah, 02h          ;isvedimas i ekrana po viena simboli
mov dl, masyvas[bx]                                     
int 21h                                                 
      
inc stulp                                      
inc bx                                                           
cmp bx,skait           
ja pabaiga                            
jmp rezult                       
   
                                        
pabaiga:                          

mov ah,07h                         
int 21h                            
mov ah, 4ch                        
int 21h         
                   
programa ends                      
end start                          
