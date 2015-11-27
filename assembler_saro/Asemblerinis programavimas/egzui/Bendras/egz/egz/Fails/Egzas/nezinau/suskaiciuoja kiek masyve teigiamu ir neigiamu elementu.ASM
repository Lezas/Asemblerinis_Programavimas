STEKAS SEGMENT STACK
       db 256 dup (?)
STEKAS ENDS          
DUOMENYS SEGMENT       
array    db  -1,-4,-8,-7,-5,2,-6,-3,-10,-3,'$'
present  db 'Masyvas: -1,4,-8,-7,-5,2,-6,-3,0,3','$'
pplus    db 'Teigiamu elementu skaicius yra  ','$'
pminus   db 'Neigiamu elementu skaicius yra  ','$'   
plus     db  0,'$'                              
minus    db  0,'$'                             
                                               
DUOMENYS ENDS                                  
PROGRAMA SEGMENT                               
         ASSUME CS:PROGRAMA, DS:DUOMENYS, SS:STEKAS
                                             
PRADZIA:                                     
mov ax,duomenys                              
mov ds,ax                                    
mov ax,0002h                                 
int 10h                                        
                                               
mov ah,02                                     
mov bh,00                                    
mov dh,06                                      
mov dl,20                                      
int 10h                       
lea dx,present                
mov ah,09h                    
int 21h

;skaitliukas neigiamiems      
mov si,0     
;skaitliukas teigiamiems               
mov di,0                
;skaitliukas            
mov cx,10               
lea bx,array            
cycle:                  
      mov al,[bx]       
      cmp al,0          
      jl less           
      jg greater  
      jmp the_end      
   less:               
      add si,1
      jmp the_end               
   greater:  
      add di,1
   the_end:     
      inc bx       
loop cycle   
             
mov ax,si    
mov ah,0     
mov minus,al 
add minus,30h
mov ax,di    
mov ah,0     
mov plus,al  
add plus,30h
             
mov ah,02    
mov bh,00    
mov dh,11    
mov dl,20    
int 10h      
mov ah,09h   
lea dx,pplus 
int 21h      
mov ah,09h   
lea dx,plus  
int 21h      
             
mov ah,02    
mov bh,00 
mov dh,12  
mov dl,20 
int 10h 
mov ah,09h 
lea dx,pminus
int 21h    
mov ah,09h
lea dx,minus
int 21h         
        
mov ah,07h
int 21h 
mov ah,4ch
int 21h          
           
PROGRAMA ENDS     
END PRADZIA