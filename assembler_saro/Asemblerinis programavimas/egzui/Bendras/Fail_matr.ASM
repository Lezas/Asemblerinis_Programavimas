stekas segment stack                     
  db 256 dup(0)                          
stekas ends                            
                                                            
duomenys segment                       
  tekstas db 'Programa skaiciuoja stulpeliu suma',10,13
          db 'ir visos matricos suma',10,13
          db '!!!!Matricos suma neturi virsyti 255!!!!',10,13
          db 10,13,'$'
 rezult   db 'Matricos suma:=','$'
 
        mas db 10,20,30
            db 40,0,60
            db 10,20,15
			
           
        handle dw 0
        fname db 'ats.txt', 0
        
		rez db 3 dup(0), ' Stulp1',10,13,'$'
        rez2 db 3 dup(0), ' Stulp2',10,13,'$'
        rez3 db 3 dup(0), ' Stulp3',10,13,'$'                
        sum db 3 dup(0),10,13,'$'
                                          
        des db 10                                
netelpa db 'Atsakymas netelpa,baitas PERPILDYTAS!! :P','$'
stulp1 db 0
stulp2 db 0
stulp3 db 0
suma dw 0
duomenys ends                                         
                                                                                        
program segment                                       
 assume cs:program, ds:duomenys, ss:stekas            
                                                      
 start:                                               
  mov ax, duomenys                                    
  mov ds, ax                                                                                          
;Ekrano valymas
  mov ax,0002h                                   
  int 10h                                                                                        
;Rodomi pranesimai                                 
  mov ah,09h                                       
  lea dx,tekstas                                 
  int 21h                                                                                         
;stulpeliu sudejimas cikle
  mov cx, 3
  mov ax, 0                                      
  mov bx, 0
;pirmas stulpelis                                               
ciklas:                                          
add al, mas[bx]
JC perpildymas
add bx,3
loop ciklas
add dl,al
JC perpildymas
mov stulp1,al
;antras stulpelis
mov cx, 3
mov ax, 0
mov bx, 0
ciklas2:                                          
add al, mas+1[bx]
JC perpildymas
add bx,3
loop ciklas2
add dl,al
JC perpildymas
mov stulp2,al 
;trecias stulpelis              
mov cx, 3
mov ax, 0
mov bx, 0
ciklas3:                                          
add al, mas+2[bx]
JC perpildymas
add bx,3
loop ciklas3
add dl,al
JC perpildymas
mov stulp3,al
mov suma,dx
jmp next                                           

perpildymas:
;Jei netelpa rodom pranesima
mov ah, 09h 
lea dx, netelpa
int 21h                             
jmp pab

next:

  mov ax,0
  mov ax,suma
  mov dx, 0            
  div des          
  mov sum+2, ah
  add sum+2, 30h
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov sum+1, ah
  add sum+1, 30h
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov sum, ah
  add sum, 30h
                       
 mov ah,09h
 lea dx, rezult
 int 21h
                                    
  mov ah, 09h
  lea dx, sum
  int 21h     
;(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((             
mov ax,0
mov ah, 3ch             ;failo kurimo komanda
mov cx, 0               ;failas kuriamas be atributu
mov dx, offset fname
int 21h
 
mov handle, ax
mov ah, 40h             ;kreipimasis i faila
mov bx, handle
mov cl,15
mov dx, offset rezult
int 21h              

mov ah, 42h
mov bx, handle
mov al, 0
mov cx, 0
mov dl,15

int 21h

mov ah, 40h
mov bx, handle
mov cl, 3
mov dx, offset sum

int 21h

;mov dx, offset sum   ;ka irasyti

 
mov ah, 3eh             ;uzdaro faila
mov bx, handle
int 21h  
;)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))                     
;stulpeliu konvertavimas
  mov ax,0
  mov al,stulp1
  mov dx, 0            
  div des          
  mov rez+2, ah    
  add rez+2, 30h   
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov rez+1, ah                                  
  add rez+1, 30h                                 
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov rez, ah                       
  add rez, 30h                                                           
  mov ah, 09h                       
  lea dx, rez                       
  int 21h
 ;antras stulpelis 
  mov ax,0
  mov al,stulp2
  mov dx, 0            
  div des          
  mov rez2+2, ah    
  add rez2+2, 30h   
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov rez2+1, ah                                  
  add rez2+1, 30h                                 
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov rez2, ah                       
  add rez2, 30h                      
  mov ah, 09h                       
  lea dx, rez2                       
  int 21h
 ;trecias stulp                            
  mov ax,0
  mov al,stulp3
  mov dx, 0            
  div des          
  mov rez3+2, ah
  add rez3+2, 30h   
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov rez3+1, ah                                  
  add rez3+1, 30h                                 
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov rez3, ah                       
  add rez3, 30h                      
  mov ah, 09h                       
  lea dx, rez3                       
  int 21h     
;pabaiga 
mov ah, 07h
int 21h
mov ah,4Ch
int 21h                             
pab:
;Laukiamas paspaudimas                                 
  mov ah, 07h                                      
  int 21h        
mov ah,4Ch
int 21h                                
program ends     
end start