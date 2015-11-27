stekas segment stack
        db 256 dup (0)
stekas ends

duomenys segment
        t1 db 'iveskite sakini:','$'
        vardas db 50,?,50 dup (0), 10,13, '$'
        zenklas db '$'
        handle dw 0
        fname db 'ats.txt', 0
duomenys ends

programa segment
assume ss:stekas, ds:duomenys, cs:programa
start:
mov ax, duomenys
mov ds, ax      
                
mov ax, 02h     
int 10h         
                
mov ah, 09h     
lea dx, t1      
int 21h         
                
mov ah, 0ah             ;vardo ivedimas is klaviaturos
lea dx, vardas  
int 21h         
                
;vardo spauzdinimas ekrane  
mov cx, 0       
mov cl, vardas  
add bx, cx      
mov ch, zenklas 
mov [bx], ch    
  
;ekrano valymas
mov ax, 02h
int 10h
                
;rezultatu isvedimas
mov ah, 02h     
mov bh, 0       
mov dh, 12      
mov dl, 25
int 10h         
                
mov ah, 09h     
lea dx, vardas+2
int 21h         
                            
mov ah, 3ch             ;failo kurimo komanda
mov cx, 0               ;failas kuriamas be atributu
mov dx, offset fname
int 21h
 
mov handle, ax
mov ah, 40h             ;kreipimasis i faila
mov bx, handle
mov cl, vardas+1
mov dx, offset vardas+2   ;ka irasyti
int 21h
 
mov ah, 3eh             ;uzdaro faila
mov bx, handle
int 21h  
  
;ekrano uzlaikymas
mov ah, 07h
int 21h

;grizimas i DOS'a
mov ah, 4ch
int 21h

programa ends
end start