;paskaiciuoja studentu pazymiu vidurkius ir bendra vidurki, kai studentu skaicius nezinomas
stekas segment stack                
        db 256 dup (0)            
stekas ends                                   
duom segment                                                     
        stsar db ' mat: ','$'
        mas   db   8,9,7,6,8,6,7,8,8,10,0
              db   10,10,10,10,10,10,10,10,10,10,0
              db  8,6,7,8,6,9,9,5,5,10,0
              db  8,5,9,6,9,8,8,10,9,7,0
              db  7,9,9,9,8,9,7,6,6,9,0
              db  8,9,9,6,8,6,9,6,9,10,0
             db '***'                                            
        kte  db 10,13,'$'                                        
        stvid db ' vidurkiai ','$'
        linija db 10,13,'-------------------------------------------',10,13,'$'
        isvats db ' Bendras  vidurkis: ','$'
        ats db '   .    ','$'                                    
        d db 10                                                  
duom ends                                                        
programa segment                                   
assume cs:programa,ds:duom ,ss:stekas                        
start:                                          
mov ax,duom                             
mov ds,ax
                                              
mov ax,0002h      ;ekrano valymas
int 10h
                                       
mov ah,09h       ;pranesimu isvedimas 
lea dx,kte
int 21h
lea dx,kte
int 21h
lea dx,stsar
int 21h
lea dx,linija
int 21h
                          
xor di,di
isv:                                            
cmp mas[si],'*' ;tikrina ar ne pabaiga
jne tol
inc si
cmp mas[si],'*'
jne tol
inc si
cmp mas[si],'*'
jne tol
push dx
mov ah,09h
lea dx,linija
int 21h
lea dx,stvid
int 21h
pop dx
xor ax,ax
jmp pradsk      ;persoka i vidurkiu skaiciavima
tol:                                                    
cmp mas[si],0  ;ziuri ar ne iraso pabaiga
jne tolx
inc di         ;padidina studentu skaiciu
mov ah,09h
lea dx,kte      ;tuscia eilute
int 21h
tolx:
cmp mas[si],1  ;ziuri ar turime skaiciu
jb xx          ;jei maziau uz 1
cmp mas[si],10
ja xx
cmp mas[si],10  ;jei tai ne 10 persoka
jne bedes
mov ah,02h      ;isveda desimt
mov dl,31h
int 21h
mov dl,30h
int 21h
mov dl,' '     ;bei isveda tarpa
int 21h
inc si
jmp isv
bedes:
mov dl,mas[si]  ;isveda skaiciu
add dl,30h
mov ah,02h
int 21h
mov dl,' '      ;bei isveda tarpa
int 21h
inc si
jmp isv
xx:                                             
mov ah,02h
mov dl,mas[si]                     	
int 21h
inc si
jmp isv
pradsk:            ;skaiciavimas
mov si,0
push di    ;isimena studentu skaiciu
mov cx,di  ;ciklas bus vygdomas di kartu ---
pralvard:          ; praleidzia vardus ir pavardes                   
cmp mas[si],1
jb pral
cmp mas[si],10
ja pral
jmp vid
pral:
inc si
jmp pralvard
vid:
push cx
mov cx,10
xor bx,bx
cikl:                  ;ciklas bus vydomas 10 kartu                                               
add bl,mas[si] ;ciklui pasibaigus bl bus pazymiu suma
inc si
loop cikl
kikvpazsuma:                                                           
push ax
push dx
mov mas[si],bl ;vietoj elemento "nulis" bl
mov ah,09h
lea dx,kte
int 21h
mov ah,02h
mov dl,' '
int 21h
xor ax,ax
cmp bl,100 ;paziuri ar musu vidurkis bus 10
je desbalu
mov al,bl
div d
add al,30h
mov dh,ah     ;isimena liekana
mov dl,al
mov ah,02h
int 21h
mov dl,'.'
int 21h
add dh,30h
mov dl,dh
int 21h
jmp galas
desbalu:
mov ah,02h
mov dl,'1'
int 21h
mov dl,'0'
int 21h
mov dl,'.'
int 21h
mov dl,'0'
int 21h
galas:
pop dx
pop ax
jmp suma
suma:
add ax,bx ;visu studentu pazymiu suma
inc si
pop cx
loop pralvard   ;---
pop di  ;studentu kiekis
xor bx,bx
xor dx,dx
mov bx,ax
mov ax,di
mul d     ;di*d pazymiu kiekis
mov dl,al ;di*d perkelia i dl
mov ax,bx ;i ax grazina suma
;div dl    ;sum/N
xor bx,bx
mov bh,ah ;isimena liekana
xor ah,ah
mov si,2
des:                              
div d
add ah,30h
mov ats[si],ah
cmp al,0
je liek
dec si
xor ah,ah
jmp des
liek:
mov si,4
xor ax,ax
mov al,bh
vpokab:
mul d
div dl
xor ah,ah ;kadangi reikia tik vieno skaitmens po kablelio
add al,30h
mov ats[si],al
rez:
mov ah,09h
lea dx,linija
int 21h
lea dx,isvats
int 21h
lea dx,ats
int 21h
dos:   	
mov ah,07h
int 21h                 	
mov ah,4ch            
int 21h
                                  
programa ends         
end start	