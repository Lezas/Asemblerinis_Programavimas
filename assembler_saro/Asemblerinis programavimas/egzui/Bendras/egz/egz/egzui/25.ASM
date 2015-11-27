stekas segment stack            
db 256 dup (?)
stekas ends 
            
duom segment
crlf equ 10,13
txt1 db ' Kursinis darbas var. 5',crlf                       
     db ' Programa parashe Raimondas Rimkevicius ish II-2/3',crlf,crlf
     db ' Programa papasho vartotoja ivesti simboliu eilute ir viena skaiciu',crlf
     db '(tarkime, n), sudaro nauja eilute, imdama ivestos eilutes n-aji,',crlf
     db '2n-aji, 3n-aji ir t.t. simbolius, bei isveda i ekrana shios naujos',crlf
     db 'eilutes zodzius ir ju skaiciu (zodziu atskyrejas yra tarpas).',crlf,crlf
     db '$' 
txt2 db 'Iveskite zodi: $'
txt3 db 'Iveskite skaiciu: $'
txt4 db 'Zodziu skaicius naujoje eiluteje: $'
txt5 db 'Nauja eilute: $'
nl db crlf,'$'         
text db 129 dup (0),13,'$'
count dw ?, '$'        
praide db ?,'$'
n db ?,'$'  
zsk db ?,'$'
ten db 10
duom ends                        
                                 
program segment                  
assume cs:program, ds:duom, ss:stekas
start:                           
        ;ikelia duomenys         
        mov ax, duom             
        mov ds, ax                       
        ;ishvalo ekrana          
        mov ax,0002h             
        int 10h                                    
        ;ishveda startini praneshima               
        mov ah,09h                                 
        lea dx,txt1                                
        int 21h                                    
        ;ishveda praneshima prashanti ivesti teksta
        mov ah,09h                                 
        lea dx,txt2    
        int 21h                                    
        ;teksto ivedimas                           
        mov bx, 0        
        mov ah, 3fh                                
        mov cx,129       
        lea dx,text                                
        int 21h          
        mov count, 0h    
        mov si, 0h       
        ;skaiciaus ivedimas
        mov ah, 09h      
        lea dx, txt3
        int 21h     
ski:    mov ah, 08h
        int 21h  
        mov n, al 
        cmp n, 30h
        jl peep  
        cmp n, 39h
        jg peep  
        mov ah, 09h
        lea dx, n  
        int 21h  
        sub n, 30h
        jmp sk   
                                  
peep:   mov n, 07h                
        mov ah, 09h               
        lea dx, n                 
        int 21h                   
        jmp ski                   
                                  
        ;teksto ilgio skaiciavimas    
sk:                               
        mov ah, text[si]          
        inc count                 
        inc si                    
        cmp ah, 31
        jg sk          
        sub count, 1   
                  
        ;ishveda ivesta informacija
        mov ah,09h
        lea dx,nl            
        int 21h              
        mov ah,09h           
        lea dx,nl            
        int 21h              
        mov ah,09h              
        lea dx,txt5             
        int 21h        
        mov ah,09h               
        lea dx,nl                
        int 21h            
                       
        ;spausdina nauja teksta
        mov bx, 0 
        mov bl, n    
        mov di, bx
        mov si, 0
        mov zsk, 1
print:            
        cmp si, di
        je pr2    
        inc si    
        cmp si, count
        jg ats    
        jmp print  
                   
pr2:    sub di, 1  
        mov ah, text[di]
        cmp text[di], 32 
        je pr4     
pr3:    add di, 1  
        mov praide, ah 
        mov ah,09h           
        lea dx,praide            
        int 21h    
        mov bx, 0  
        mov bl, n            
        add di, bx 
        jmp print  
                   
pr4:    inc zsk    
        jmp pr3    
                   
ats:    mov al, zsk
        mov ah,09h 
        lea dx,nl            
        int 21h    
        mov ah,09h 
        lea dx,nl            
        int 21h              
                   
        mov ah, 09h
        lea dx, txt4
        int 21h    
        mov ah,09h           
        lea dx,nl            
        int 21h              
                 
        mov ax, 0
        mov al, zsk
        mov si, 0
        mov praide, 32
pl:     div ten       
        mov cl, al        
        inc si    
        mov ah, 09h
        lea dx, praide
        int 21h
        mov ax, 0 
        mov al, cl    
        cmp al, 0     
        jg pl  
        
        call atgal
                                    
        mov ax, 0  
        mov al, zsk
p4:     div ten  
        mov cl, al 
        mov ch, ah
        mov praide, ah
        add praide, 30h
        mov ah, 09h
        lea dx, praide
        int 21h
        call atgal
        call atgal
        mov ax, 0  
        mov al, cl 
        cmp cl, 0
        jg p4    
          
        mov ah, 0fh ;gauna aktyvu ekrana
        int 10h
        mov ah, 3   ;kursoriaus pozicijas paima
        int 10h     ;y ishsaugomas dl'e buna
        mov cx, si
        mov dl, cl
        mov ah, 02h
        int 10h
                                 
        ;pabaiga                
pabaiga: mov ah,07h          
         int 21h                 
        mov ah,4ch              
        int 21h              
          
 atgal proc near
   mov praide, 08h
   mov ah, 09h
   lea dx, praide
   int 21h
   ret    
 atgal endp
                                                     
 program ends                                     
 end start