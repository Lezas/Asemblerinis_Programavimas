stekas segment stack ;aprasomas stekas
db 256 dup (0)    
stekas ends                   
duomenys segment ;aprasomi duomenys
pran db 'Iveskite masyva:',10,13,'$'
atsakymas db '',10,13,'Skaiciu yra:',10,13,'$'
nesk db 'Kitu elementu:',10,13,'$'              
masyvas db 255, ?, 255 dup (0)                                             
rez db 3 dup (0),10,13,'$'                 
desimt db 10
skaiciu db 0
kitu db 0                                                                                                            
duomenys ends                                                                  
programa segment                                                               
assume cs:programa, ds:duomenys, ss:stekas                                     
start:                                                                         
mov ax, duomenys                                                               
mov ds, ax 
                                                                    
mov ax, 02h                     
int 10h                         
                                     
mov ah,09h                     
lea dx,pran                    
int 21h                        
                               
mov ah,0ah                     
lea dx,masyvas                 
int 21h                        
mov si,2                       
mov cl,masyvas[1]              
mov ax,0                       
tikrinimas:                     
cmp masyvas[si],48             
jl galan                    
cmp masyvas[si],57             
jg galan                              
inc skaiciu                  
galan:     
inc si                         
loop tikrinimas
mov al,masyvas[1]
sub al,skaiciu
mov kitu,al                 
mov si,2
mov ax,0       
mov al,skaiciu
call dalyba
;isvedam skaiciu kieki
mov ah,09h                     
lea dx,atsakymas               
int 21h                        
mov ah,09h                     
lea dx,rez                     
int 21h    
mov ax,0           
mov al,kitu
call dalyba               
mov ah,09h 
lea dx,nesk
int 21h    
mov ah,09h 
lea dx,rez 
int 21h    
jmp pabaiga                       
dalyba:                        
div desimt                     
add ah,30h                     
mov rez[si],ah                 
mov ah,0                       
cmp al,0                       
je grist                      
dec si  
grist:  
ret                        
pabaiga:                                     
     mov ah, 07h     ;sulaiko ekrana                                 
   int 21h                           
                                     
     mov ah, 4ch       ;uzbaigia programa                               
     int 21h                                          
     programa ends                                    
     end start     ;programos pabaiga                                   
