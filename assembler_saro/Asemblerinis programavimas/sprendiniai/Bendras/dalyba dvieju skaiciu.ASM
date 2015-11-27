; 11 10
;II-3/5 Dainiaus Stasiuno
;Suskaiciuoti a/b 
;atskirai isvesti liekana ir sveika dali



stekas segment stack
db 256 dup(0)
stekas ends
          
duomenys segment
a  db 21        
b  db 2         
r  db 0 ,10,13,'$'
duomenys ends
            
programa segment 
assume cs:programa,ds:duomenys,ss:stekas
start:   
;uzkraunam duomenis      
mov ax,duomenys    
mov ds,ax
;issivalom ekrana
mov ax,0002h
int 10h 
;dalinam a/b         
mov cl,a
mov ch,0
div b   
;atiduodam valdyma dosui              
mov ah,4ch           
int 21h              
programa ends        
end start            
                     
                     
