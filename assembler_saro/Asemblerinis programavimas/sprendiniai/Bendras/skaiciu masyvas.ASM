stekas segment stack ;aprasomas stekas
db 256 dup (0)    
stekas ends                   
duomenys segment ;aprasomi duomenys
pran db 'Iveskite skaiciu masyva:',10,13,'$'
atsakymas db 'Atsakymas:','$'
nesk db 'Ivestas neskaicius!',10,13,'$'              
masyvas db 255, ?, 255 dup (0)                                             
rez db 4 dup (0),10,13,'$'                 
desimt db 10                                                                                                           
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
sumavimas:                     
cmp masyvas[si],48             
jl neskaic                     
cmp masyvas[si],57             
jg neskaic                     
sub masyvas[si],30h            
add al,masyvas[si]             
inc si                         
loop sumavimas                 
mov si,3                       
dalyba:                        
div desimt                     
add ah,30h                     
mov rez[si],ah                 
mov ah,0                       
cmp al,0                       
je isvest                      
dec si                         
loop dalyba                    
isvest:                        
mov ah,02h                     
mov bh,00                      
mov dh,2                       
mov dl,1                       
int 10h                        
                               
mov ah,09h                     
lea dx,atsakymas               
int 21h                        
mov ah,09h                     
lea dx,rez                     
int 21h                        
jmp pabaiga
neskaic:                       
mov ah,09h                     
lea dx,nesk                    
int 21h                                            
pabaiga:                                     
     mov ah, 07h     ;sulaiko ekrana                                 
   int 21h                           
                                     
     mov ah, 4ch       ;uzbaigia programa                               
     int 21h                                          
     programa ends                                    
     end start     ;programos pabaiga                                   
