;Elementu vidurkis
;-steko segmentas-
stekas    segment stack  
          db 256 dup(?)  
stekas    ends             
;-duomenu segmentas-       
duomenys  segment          
mas       dw 4,-1,3,5,8 
masD      dw 5             
pran db ,10,13,'Vidurkis: '
d db ?                     
pr db '.'        
g db ?,'$'                 
duomenys  ends             
;-programos segmentas-            
programa  segment                 
          assume cs:programa, ds:duomenys, ss:stekas
;-paruosia ds-                    
start:    mov ax,duomenys         
          mov ds,ax               
                         
;ekrano valymas              
mov ax,0002h              
int 10h                  
mov ah,02h
mov bh,0
mov dh,00
mov dl,0
int 10h
                           
mov ax,0
mov cx,masD
mov si,0
sum:                              
add ax,mas[si]   ;adresu modifikavimas
add si,2
loop sum
                         
div masD
                         
mov d,al                 
mov g,dl                 
                         
add d,30h                
add g,30h                
mov ah,09h               
lea dx,pran              
int 21h                  
;laukia klaviso paspaudimo     
mov ah, 07h
int 21h
;-grizhta i DOS                
mov ah,4ch               
int 21h                  
programa ends            
end start