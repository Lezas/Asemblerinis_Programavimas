stekas segment stack
        db 256 dup (0)
stekas ends

duomenys segment
        t1 db 'iveskite sakini:','$'
        sakinys db 50,?,50 dup (0), 10,13, '$'
        rez db 31 dup (0),10,13,'$'
        zenklas db '$'
        handle dw 0
        fname db 'failas.txt', 0
duomenys ends

programa segment
assume ss:stekas, ds:duomenys, cs:programa
start:
mov ax, duomenys
mov ds, ax      
                
mov ax, 02h     
int 10h         
 
mov ah, 02h
mov bh, 0
mov dh, 13
mov dl, 25
int 10h
                
mov ah, 09h     
lea dx, t1      
int 21h         
                
mov ah, 0ah            
lea dx, sakinys
int 21h         
                
;vardo spauzdinimas ekrane  
mov cx, 0       
mov cl, sakinys
add bx, cx  
mov ch, zenklas    
mov [bx], ch 

lea bx, sakinys
lea si, rez
add si, 30
mov cl, 30
;ciklas apverciantis zodi
ciklas:
mov ah, [bx]
mov [si], ah
inc bx
dec si
loop ciklas   
  
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
lea dx, sakinys+2
int 21h         
                            
mov ah, 3ch             
mov cx, 0               
mov dx, offset fname    
int 21h                 

;irasymas i faila                        
mov handle, ax          
mov ah, 40h            
mov bx, handle          
mov cl, 30
mov dx, offset rez
int 21h
 
mov ah, 3eh             
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