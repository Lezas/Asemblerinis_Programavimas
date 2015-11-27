stekas segment stack                   
       db 256 dup (0)                  
stekas ends                            
duomenys segment                       
  vardas db 'Atliko Jaroslav Jakubovskij II-2/2' , 13,10,'$'
masyvas   db 1,2,4,32,111,3,4,55,'*'
     suma db 'suma lygi:  ','$'                   
 vidurkis db 'vidurkis lygus:  ','$'             
      vid db ?, '$'               
      sum db ?,13,10,'$'                       
      prad db ?,'$'               
     lk db 2 dup (?),'$'
    list  db 3 dup (?),13,10,'$'  
      de db 10       
      bbd db ?                
      kab db ',$'
  duomenys ends                
programa segment                       
 assume cs:programa, ds:duomenys, ss:stekas
start:                                 
mov ax,0002h                           
int 10h                                
                                       
mov AX,duomenys                        
mov ds,ax                              
                                                                     
;ciklo formavimas                     
mov si,0                          
mov al,0                          
mov sum,0                              
ciklas:                                
CMP masyvas[Si],'*'                    
je toliau                              
add al,masyvas[si]                     
inc si                                 
loop ciklas                            
                                       
toliau:                                
mov sum,al                             
mov cx,3                          
mov di,2                               
                                       
                                       
ciklas2:                               
mov ah,00                               
div de                                 
add ah, 30h                            
mov list[di],ah                        
dec di                                 
loop ciklas2                           
                                  
mov ah,09h                        
lea dx,vardas                     
int 21h                           
lea dx,suma                       
int 21h                           
lea dx, list                      
int 21h                           
                                  
 mov al,sum                       
 mov ah,00                        
 mov dx,0000                            
 div si                           
 mov bbd,dl                       
 mov vid,al                       
 mov di,1            
 mov cx,2            
ciklas3:             
                             
   mov ah,00                              
   div de                                 
   add ah, 30h                               
   mov lk[di],ah     
   dec di                                   
  loop ciklas3       
  mov ah,09h
  lea dx,vidurkis
  int 21h         
  lea dx,lk
  int 21h            
  lea dx,kab         
  int 21h            
  mov al,bbd                            
  mov di, 0          
  mov cx, 2          
  mov dx,0000        
    ciklas4:                   
                                                   
   mov ah,00         
   mul de            
   div si            
   add al,30h        
   mov lk[di],al     
   mov al,dl         
   inc di            
   loop ciklas4      
   mov ah,09h        
   lea dx,lk         
   int 21h           
;laukimas                              
;mov ah,07h                             
;int 21h                                
mov ah, 4ch                            
int 21h                                
programa ends                          
        end start            
                             
                               
                               
                             
              	             
 