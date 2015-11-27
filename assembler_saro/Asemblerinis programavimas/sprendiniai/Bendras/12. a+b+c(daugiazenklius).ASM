;----------Programa sudedanti tris skaicius ivedamus is klaviaturos per buferi ir isvedanti rezultata----------
stekas segment stack    
db 256 dup (?)          
stekas ends             
                        
duomenys segment       
error  db 10,13,'Klaida $'
vardas db 10,13,'Dimitrianas Kondrasovas II-1/3 $'
kurs   db 10,13,'Uzduotis Nr8 $' 
aenter db 10,13,'Iveskite a < 256: $'
benter db 10,13,'Iveskite b < 256: $' 
center db 10,13,'Iveskite c < 256: $'
tempb db 0                 
a db 0                     
b db 0 
c db 0                    
ats dw 5 dup (?),'$'             
desw dw 10                       
desb db 10                         
rezw dw 0,'$'              
                                 
tempw dw (?)                     
baksas db 10,13,'$'              
info db 4,4 dup (?),'$'    
rezb db 185, '$'           
duomenys ends                    
                                 
programa segment                 
assume cs:programa, ds:duomenys, ss:stekas
start:                           
mov ax, duomenys                          
mov ds, ax                       
mov ax, 0002h                    
int 10h                          
                                 
mov ah, 09h                      
lea dx, vardas                   
int 21h                          
mov ah, 09h                      
lea dx, kurs                     
int 21h                          
                                 
mov ah, 09h             ;A               
lea dx, aenter             
int 21h                               
call ivedimas              
mov al, tempb                    
mov a, al                  
                           
                                 
mov ah, 09h             ;B                    
lea dx, benter             
int 21h                               
call ivedimas              
mov al, tempb                    
mov b, al                  
                           
mov ah, 09h             ;C 
lea dx, aenter             
int 21h                               
call ivedimas              
mov al, tempb                    
mov c, al                  
                           
                           
mov ax, 0                  
mov cx, 0                  
                           
mov al, a                  
mov byte ptr tempw, al     
add  cx,  tempw            
                           
mov al, b                  
mov byte ptr tempw, al     
add  cx,  tempw            

mov al, c                  
mov byte ptr tempw, al     
add  cx,  tempw 
                           
mov rezw, cx               
                           
                           
                                 
;isvedimas                        
mov dx, 0               ;uznulinam liekana
mov bx, 0               ;skaitliukas  
mov ax, 0   
mov ax, rezw            ;ka ishvesti
call isvedimas                   
                                 
mov ah, 09h                      
lea dx,baksas                    
int 21h                          
                                          
       mov bx, 4                    
ciklas:                          
       mov ah, 02h               
       mov dl,byte ptr ats[bx]   
       int 21h                   
       cmp bx, 0                 
       je endas                  
       dec bx                    
       jmp ciklas                
                                 
endas:                                                    
mov ah, 07h                               
int 21h                                   
mov ah, 4ch                               
int 21h                                   
                                          
isvedimas:                                
        div desw                          
        add dx, 30h                       
        mov ats[bx], dx          
        inc bx                            
        mov dx, 0                         
        cmp ax, 0                         
        je  next      ;jei sveikoji = 0 tai baigiam
        jmp isvedimas            
                                          
next:                            
ret                                
ifas:                            
mov ah, 09h                      
lea dx, error                    
int 21h                          
call endas                       
                                 
                                 
ivedimas:                        
        mov bx, 0                
        mov ah, 0Ah               
        lea dx, info              
        int 21h                  
        mov bl, info[1]        ;skailiukas
        mov si, 0                         
        mov al, 0  
        mov tempb, 0
xxx:                             
                                 
        mov cl, info[si+2]       
        sub cl, 30h              
        ;a*10+cl                 
        mov al, tempb
        mul desb                 
        add al, cl               
        mov  tempb, al
                                 
                                     
        inc si                   
        dec bx                   
        cmp bx,0                 
        je next                  
        jmp xxx        
                                          
                    
programa ends          
end start