;formule 3*(aras+voitech)+(5-(kostia-viduto)*merginos)
stekas segment stack                                 
  db 256 dup(0)                                      
stekas ends                                                
                                                           
cr        equ 13                                           
lf        equ 10                                           
                                                           
duomenys segment                                           
  aras dw 4                                                
  voitech dw 3    
  kostia db 1     
  viduto db 6     
  merginos dw 8   
  penki dw 5      
  trys dw 3       
;  minus db -1                                        
ekranas   db 'Spresime lygti: ',cr,lf,7                    
          db '3*(aras+voitech)+(5+kostia+viduto)*merginos)' ,cr,lf
          db 'Uzduoti atliko: Arunas, Voitech ir Konstantinas. ',cr,lf
          db 'Spauskite bet koki klavisa',cr,lf
duomenys ends                                                
                                                           
program segment                                            
    assume cs:program,ds:duomenys,ss:stekas                
start:                                                     
mov ax,duomenys                                            
mov ds,ax                                                  
;isvalome ekrana                                           
mov ax,0002h                                               
int 10h                                                    
;rodome pranesima                                          
          mov ah,09h                                       
          lea dx,ekranas                                   
          int 21h                                          
                                                           
;laukia klaviso paspaudimo                                 
          mov ah, 07h                                      
          int 21h                                          
                    
;skaiciuojam formule              
mov ax,aras                       
mov bx,voitech                    
ADD ax,bx                         
mul trys                          
mov bx,ax                         
mov ah,0            
mov al,kostia       
;mul minus          
ADD ax,penki        
mov cx,ax           
mov ah,0            
mov al,viduto       
;mul minus                         
add ax,cx           
MUL merginos        
ADD ax,bx           
mov rez,ax 
          
;mov ah,09h
;lea dx,rez     
;int 21h  
         
 ;mov ah, 07h                                      
 ;int 21h 
                 
mov ah,4ch          
int 21h             
                                                           
program ends                                               
END start