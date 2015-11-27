;Is masyvo, kuriame yra 30 elementu, isrenkamas maziausias elementas

stekas segment stack                
       db 256 dup (0)                                                         
ends stekas                                                                   
                                                                     
duomenys segment                                                              
         a db 10,10,11,1,12,7
           db 2,2,21,2,2,2
           db 2,4,5,20,8,3
           db 9,6,4,6,8,9
           db 2,15,8,5,41,17
         pran db 'Maziausias masyvo elementas:',10,13, '$'
         sk db 4 dup (0),'$'
         dal db 10 
ends duomenys                     
                                  
programa segment                  
         assume ds:duomenys, cs:programa, ss:stekas 
  start: mov ax,duomenys          
         mov ds,ax
                                  
         ;ekrano valymas          
         mov ax,0002h             
         int 10h                  
                
    mov ax,0    
    mov cx,30 ;30 kartus suksime cikla
    mov bx,0                                          
                        
    mov al,a[bx] ;issaugomas pirmos eilutes pirmas elementas, t.y. nurodoma 1 elemento vieta

  ciklas:                         
       cmp a[bx],al ; lyginamas 1 elementas su esanciu AL'e
       jg toliau              
       mov al,a[bx]      
  
       toliau:                 
       inc bx            
  loop ciklas 
                         
mov sk,al   ;i sk patalpinama al reiksme, t.y. musu didziausias elementas             
                         
;rez vertimas i kodus    
mov cx,4
lea bx,sk+3

ats:
 mov ah,0
 div dal    

 add ah,30h
 mov [bx],ah
 dec bx
loop ats
                                        
;pranesimo spausdinimas                 
mov ah,09h               
lea dx,pran                       
int 21h          
                       
                                   
;spausdiname ats    
mov ah,09h       
lea dx,sk        
int 21h          
                 
;laukiame klaviso paspaudimo
mov ah,07h      
int 21h         
                
 mov ah,4ch     
 int 21h        
programa ends                                                   
 end start                                                      
     