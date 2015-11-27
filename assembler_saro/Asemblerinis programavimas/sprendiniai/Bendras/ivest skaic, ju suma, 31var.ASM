stekas segment stack
db 256 dup(0)
ends stekas
duomenys segment
pran1 db 'iveskite skaiciu',10,13,'$'
pran2 db 'skaiciu suma: ','$'
ivsr db 2,?,2 dup(0),10,13,'$'
rez db 3 dup(0),'$'
mas db 10 dup(0),'$'   
des db 10           
duomenys ends       
programa segment    
assume cs:programa, ds:duomenys, ss:stekas
start:              
mov ax,duomenys     
mov ds,ax           
                    
mov ax,0002h        
int 10h             
                    
mov ah, 09h         
lea dx,pran1        
int 21h             
                    
mov cx,0ah          
mov bx,00h          
suvedimas:          
mov ah,0ah             
lea dx,ivsr         
int 21h             
mov al,ivsr+2       
sub al,30h          
mov mas[bx],al      
inc bx              
loop suvedimas      
                    
mov al,00h          
mov cx,0ah          
mov bx,00           
sudetis:            
add al,mas[bx]      
inc bx              
loop sudetis        
                    
mov bx,2            
mov cx,3            
mov ah,0             
pasivertimas:       
div des             
add ah,30h             
mov rez+bx,ah
dec bx              
mov ah,00           
cmp al,0            
je pabaiga          
loop pasivertimas   
                    
pabaiga:            
mov ah,09h          
lea dx,pran2
int 21h   
lea dx,rez
int 21h         
          
mov ah,4ch
int 21h   
programa ends    
end start