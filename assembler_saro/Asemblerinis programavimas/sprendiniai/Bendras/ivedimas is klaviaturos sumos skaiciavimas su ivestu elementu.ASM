stekas segment stack
db 256 dup(0)            
stekas ends              
duomenys segment         
t1 db "darba atliko: ", "$"
t2 db "x=a+b=","$"       
t3 db "Iveskite varda ","$"
t4 db "Iveskite A skaiciu " ,"$"
                          
vardas db 20,?,20 dup (0),'$',10,13
skaicius db 5,?,5 dup (0)
a db 0                    
b db 5                    
des db 10                 
zenklas db "$"            
rez db 0, "$"             
rez1 db 3 dup(0),"$",10,13
duomenys ends             
                          
programa segment          
assume ss:stekas, ds:duomenys, cs:programa
start:                    
mov ax,duomenys           
mov ds,ax                 
mov ax,02h                
int 10h                   
;Vardo ivedimas is klaviaturos       
mov ah,09h; iveda pasoma ivesti varda
lea dx,t3                 
int 21h                   
                          
mov ah ,0ah;Iveda varda is klaviaturos
lea dx,vardas             
int 21h                   
 ;ekrano valymas          
mov ax,02h                
int 10h                   
;Skaiciaus ivedimas is klaviaturos
                          
mov dx,00                 
mov ah,09h;isveda prasome ivesti skaiciu
lea dx,t4                 
int 21h                   
mov ah,0ah;skaiciaus ivedimas is klaviaturos     
lea dx,skaicius                    
int 21h                            
                                   
lea si,skaicius+2                  
mov cl,skaicius+1                  
mov ch,0                           
dec cl                             
mov al,[si]                        
mov ah,0                           
sub al,30h                         
mov a,al                           
cmp cl,0                           
je skaiciavimai                    
                          
ciklas1:                  
inc si                    
mov al,a                  
mul des                   
mov bl,30h                
sub [si],bl               
add al,[si]               
mov a,al                  
loop ciklas1              
                          
skaiciavimai:             
mov al,a                  
add al,b                  
mov rez,al                
                          
mov cl,2                  
mov ch,0                  
                          
ciklas2:                  
mov ah,0                  
div des                   
add ah,30h                
mov [bx],ah               
mov ah,0                  
dec bx                    
loop ciklas2              
;vardo spausdinimas i ekrana
lea bx,vardas               
mov cx,0                  
mov cl,vardas             
add bx,cx                 
mov ch,zenklas            
mov [bx],ch               
;rezultatu isvedimas      
                          
mov ah,02h                
mov bh,0                  
mov dh,12                 
mov dl,25                 
int 10h                   
                          
mov ah,09h                
lea dx,t1                 
int 21h                   
mov ah,09h                
lea dx,vardas+2           
int 21h  
                   
mov ah,02h                
mov bh,0                  
mov dh,13                 
mov dl,25                 
int 10h                   
;isveda rezultata         
mov ah,09h                
lea dx,t2                 
int 21h  
         
mov ah,02h                
mov bh,0                  
mov dh,13                 
mov dl,26                
int 10

mov ah,09h                
lea dx,rez1               
int 21h                   
mov ah,07                 
int 21h                   
                          
mov ah,4ch                
int 21h                   
programa ends             
end start                 
                          
                            
                          
                          
                          

  