stekas segment stack
db 256 dup(0)
stekas ends
duomenys segment 
pran1 db 'paskaiciuosime ((a+b)*100)/a',10,13,'$'
pran2 db 10,13, 'iveskite a ',10,13,'$'
pran3 db 10,13, 'iveskite b ',10,13,'$'
pran4 db 10,13, 'ats: ','$'
pran5 db 'klaida !!! iveskite is naujo',10,13,'$'
ivsr db 2,?,2 dup(0),10,13 
a db 2 dup(0)             
b db 2 dup(0)             
rez db 6 dup(0),'$'
simt db 100
des  db 10
duomenys ends             
programa segment          
assume cs:programa,ds:duomenys,ss:stekas
start:                    
mov ax,duomenys           
mov ds,ax                 
                          
mov ax,0002h              
int 10h                   
                          
mov ah,09h                
lea dx,pran1              
int 21h                   
pradzia:                  
lea dx,pran2              
int 21h                   
mov ah,0ah                
lea dx,ivsr               
int 21h                   
mov al,ivsr+2             
sub al,30h                
mov a,al                  
cmp a,0                   
je klaida                 
jmp toliau                
klaida:                   
lea dx,pran5              
mov ah,09h                
int 21h             
jmp pradzia         
toliau:
mov ah,09h             
lea dx,pran3        
int 21h             
mov ah,0ah          
lea dx,ivsr         
int 21h             
mov al,ivsr+2       
sub al,30h          
add al,a            
mul simt
div a  
             
mov cx,4  
mov bx,3  
mov ah,00h             
pasivertimas: 
div des       
add ah,30h    
mov rez+bx,ah
dec bx    
mov ah,00h
cmp al,0  
je pabaiga
loop pasivertimas
          
add ah,30h
mov rez+4,2ch
mov rez+5,al
pabaiga:    
lea dx,pran4
mov ah,09h  
int 21h     
lea dx,rez  
int 21h     

mov ah,07h
int 21h
            
mov ah,4ch  
int 21h     
programa ends
end start
         
        
        
