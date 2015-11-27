stekas segment stack
        db 256 dup (?)
stekas ends                   
               
duomenys segment
        pran1 db ' ivesta simboliu eilute isveda i dvi naujas',13,10,'$'
        pran2 db 'kuriu viena sudaryta is mazuju raidziu',13,10,'$'
        pran3 db 'kita sudaryta is didziuju raidziu',13,10,'$'
        pran4 db 'iveskite simboliu eilute',13,10,'$'
        pran5 db 'rezultatas',10,13,'$'
        pran6 db 'pabaiga',13,10,'$'
eilut db 100,?,100 dup(?)
ats1  db 100 DUP(?),13,10,'$'
ats2  db 100 DUP(?),13,10,'$'
count db 0 
sim   dw 0
sim2  dw 0               
duomenys ends  
               
programa segment               
assume cs:programa, ds:duomenys, ss:stekas
               
start:         
mov ax,duomenys
mov ds,ax 
;isvalom ekrana     
mov ax,0002h   
int 10h        
          
mov ah,09h        
lea dx,pran1
int 21h                  
mov ah,09h     
lea dx,pran2   
int 21h              
mov ah,09h
lea dx,pran3
int 21h             
mov ah,09h
lea dx,pran4
int 21h            
mov ah,0ah  
lea dx,eilut
int 21h   
;isvalom ekrana          
mov ax,0002h
int 10h             
;skaitliukas masyvui
mov si,2  
mov di,0  
          
ciklas:   
mov al,00 
mov al,eilut[si]
cmp al,13 
je fin    
cmp al,65 
jl maz ;jei maziau
cmp al,90 
jg  daug ; jei nelyg
jmp net   
loop ciklas
          
daug:     
cmp al,97 
jl maz    
cmp al,122
jg daug1  
jmp net1  
inc si    
jmp ciklas
          
net1:     
mov sim, di
mov di, sim2
mov ats1[di],al
inc di      
mov sim2, di
mov di, sim
inc si      
inc count   
jmp ciklas
          
net:      
mov ats2[di],al
inc si    
inc di    
jmp ciklas
          
maz:      
inc si    
jmp ciklas
          
daug1:    
inc si    
jmp ciklas
          
fin:      
jmp pabaiga
          
pabaiga:  
mov ah,09h
lea dx,pran5
int 21h   
mov ah,09h
lea dx,ats1
int 21h   
mov ah,09h
lea dx,ats2
int 21h   
mov ah,09h
lea dx,pran6
int 21h

mov ah,07h
int 21h
mov ah,4ch
int 21h
programa ends
end start


        
               
               
               
 
        