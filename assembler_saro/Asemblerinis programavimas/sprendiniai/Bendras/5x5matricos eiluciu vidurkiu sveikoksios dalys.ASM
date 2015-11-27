stekas segment stack
        db 256 dup (?)
stekas ends
      
duomenys segment
pran db 'Nu ka pradedam...Spausk ka nori', 10, 13, '$'
k db 10, '$'
l dw 25, '$'
n dw 5, '$'
sum db ?, '$'
c db 0, '$'
mas db 0,1,1,1,1                                            
    db 2,2,2,2,3
    db 2,3,4,5,6
    db 8,8,8,8,8
    db 2,5,6,5,7
mas2   db 3 dup (?), '$'
tarp db '  ','$'
tarp2 db '  ',10, 13,'$'
tarp3 db '================================',10, 13,'$'      
duomenys ends
programa segment
assume cs:programa, ds:duomenys, ss:stekas


start:              
mov ax, duomenys                    
mov ds, ax                                        
call valyti       
lea dx,pran    
call isved        
call uzlaik
;;;;;;;;;;;;;;;;;;;;;;;;
                                           
;;;;;;;;;;;;;;;;;;;;;;;;
mov cx, 0
mov cx,l
mov di,0
mov bx, n

ciklas:
dec cx
mov ah,0
mov al, 0
mov ah, mas[di]
inc di
add ah,30h             
mov c,ah
lea dx,c             
call isved
lea dx,tarp             
call isved
  dec bx 
    cmp bx,0
       je go
       jmp tl
          go:
          lea dx,tarp2             
          call isved
          mov bx,n
tl:
cmp cx, 0
je toliau
jmp ciklas                                          
;;;;;;;;;;;;;;;;;;;;;;;;;
toliau:
lea dx,tarp3    
call isved
;;;;;;;;;;;;;;;;;;;;;;;;;   
mov cx, l
mov di,0
mov si,0
mov al,0
ciklas2:
 mov al,0
 mov si,0
 mov al, mas[di]
ciklas3:
       inc di
       dec cx
       inc si
       add al, mas[di]
       mov sum, al
       cmp si, n
       je spaus
       jmp ciklas3
spaus:
mov al, sum
mov ah,0                                                         
mov dx, 0        
div si          
mov ah,0
mov si,2
ciklas5:                
           div k                  
           add ah,30h                  
           mov mas2[si],ah        
           xor ah,ah                  
           cmp al,0                            
           je spau                   
           dec si                    
           jmp ciklas5                
      spau:
lea dx,tarp2    
call isved  
lea dx,mas2         
call isved



cmp cx, 0
je pab
jmp ciklas2                                                
;;;;;;;;;;;;;;;;;;;;;;;;;;

pab:
call uzlaik                                   
int 21h               
mov ah,4ch                          
int 21h 

valyti proc                    
        mov ax, 02h                               
        int 10h                                                 
        mov ax, 0             
        ret                    
 endp valyti
isved proc                                   
        mov ah, 09h          
        int 21h                        
        ret                                       
 endp isved                                                             
 uzlaik proc                  
        mov ah, 07h                           
        int 21h                                                         
        ret                                     
 endp uzlaik 
programa ends
end start
    