stekas segment stack
        db 256 dup (?)
stekas ends
      
duomenys segment
pran db 'Nu ka pradedam...Spausk ka nori', 10, 13, '$'
k db 10, '$'
l dw 15, '$'
n dw 5, '$'
m dw 3, '$'
c db 0, '$'
r db 5, '$'
mas db 0,1,2,3,4                                            
    db 1,2,3,4,5
    db 2,3,4,5,6
mas2  db 5 dup (?),'$'
kiek  db ?, '$' 
tarp db '  |  ','$'
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
xor cx,cx  ;apnulinam cx             
mov cx,l  ;ikeliam viso kiek bus elementu              
xor di,di ;apnulinam di                               
mov bx, n ;n-stulpeliu skaicius              
                        
ciklas:                 
dec cx
xor ah,ah
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
mov cx, n
mov di,0
mov bx, n
mov si,0
ciklas2: 
        mov bx, n                                               
        mov al, mas[di]          
        add al, mas[di+bx]
        add bx, cx
        add al, mas[di+bx]   
        mov si,2
        mov ah,0
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
       lea dx,mas2         
       call isved
inc di
cmp di, n
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
    