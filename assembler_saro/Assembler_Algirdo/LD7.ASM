stekas segment stack      
db 256 dup (?)            
stekas ends               
                          
duomenys segment               
svd db 10,13, 'Sveikoji dalis ' 
spes db 3 dup (' '),'$'        
lie db 10,13, 'Liekana '   
spel db 3 dup (' '),'$'                       
de db 10                  
du db 2                   
tr db 3                   
a db 15                   
b db 13                   
c db 5                    
tarp db 0                 
duomenys ends             
                          
programa segment          
assume cs:programa, ds:duomenys, ss:stekas  
cik1 proc                                        
mov ah,0                  
div de                    
add ah,30h                
mov [bx],ah               
dec bx                    
loop cik1  
Ret
cik1 endp  
         
start:                    
mov ax,duomenys           
mov ds,ax                 
formule:                  
mov al,a                  
mov bl,b                  
add al,bl                 
mov cl,c                  
sub al,cl                 
mov dl,du                 
mul dl                    
mov dl,tr                 
div dl                    
mov tarp,ah               
sps:                      
lea bx,spes+2             
mov cx,3                  
call cik1                
spl:                      
mov al,tarp               
lea bx,spel+2             
mov cx,3 
call cik1                                  
spausdinimas:             
mov ah,09h                
lea dx,svd                
int 21h                     
lea dx,lie         
int 21h                   
mov ah,4ch         
int 21h            
programa ends      
end start                   
