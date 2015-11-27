stekas segment stack
db 256 dup(0)
stekas ends
       
duomenys segment
pran1 db 'paskaiciuosime reiskini c=(a*b)/10',10,13,'$'
pran2 db 10,13, 'iveskite a ',10,13,'$'
pran3 db 10,13, 'iveskite b ',10,13,'$'
pran4 db 10,13, 'ats: ','$'
ivsr db 2,?,2 dup(0),'$'
a db 2 dup(0)
b db 2 dup(0)        
des db 10                       
rez db 3 dup(0),'$'
temp db 3 dup(0)
duomenys ends   
                
programa segment
assume cs:programa,ss:stekas,ds:duomenys
start:          
mov ax,duomenys 
mov ds,ax       
;isvalomas ekranas                
mov ax,0002h    
int 10h 
;pranesimu isvedimas        
mov ah,09h      
lea dx,pran1    
int 21h    
     
lea dx,pran2    
int 21h         
mov ah,0ah 
     
lea dx,ivsr     
int 21h         
mov al,ivsr+2   
sub al,30h      
mov a,al        
mov ah,09h   
   
lea dx,pran3    
int 21h         
mov ah,0ah  

    
lea dx,ivsr     
int 21h         
mov al,ivsr+2   
sub al,30h      
mov b,al        
                
mov al,a        
mul b           
div des         
add al,30h      
mov rez,al      
mov rez+1,2ch   
add ah,30h      
mov rez+2,ah    
                
mov ah, 09h     
lea dx,pran4    
int 21h         
lea dx,rez      
int 21h         

mov ah,07h
int 21h
                
mov ah,4ch      
int 21h         
programa ends   
end start       
