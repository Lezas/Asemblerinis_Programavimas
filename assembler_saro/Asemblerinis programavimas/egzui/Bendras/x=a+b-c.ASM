stekas segment stack
        db 256 dup (?)
stekas ends

duomenys segment
        t0 db 10,13, 'Programa skaiciuoja a+b-c', '$'
        t1 db 10,13, 'Iveskite skaiciu a:','$'
        t2 db 10,13, 'Iveskite skaiciu b:','$'
        t3 db 10,13, 'Iveskite skaiciu c:','$'
        t4 db 10,13, 'a*b*c= ','$'
        aukstis db 5,?,5 dup (0)
        ilgis db 5,?,5 dup (0)
        plotis db 5,?,5 dup (0)
        a db 0   
        b db 0 
        c db 0 
        des db 10
        rez db 0
        rez1 db 4 dup (0), '$', 10,13
duomenys ends

programa segment
assume ss:stekas, ds:duomenys, cs:programa
start:
mov ax, duomenys
mov ds, ax

;ekrano valymas
mov ax, 02h
int 10h

;aukscio ivedimas is klavos
mov dx, 00
mov ah, 09h
lea dx, t1      ;isveda t1 pranesima
int 21h

mov ah, 0ah     ;ivedamas aukstis is klavos
lea dx, aukstis
int 21h
      
;ekrano valymas
mov ax, 02h
int 10h
      
;ilgio ivedimas is klavos
mov dx,  00
mov ah, 09h
lea dx, t2      ;isveda t2 pranesima
int 21h
      
mov ah, 0ah     ;ivedamas ilgis is klavos
lea dx, ilgis
int 21h
      
;ekrano valymas
mov ax, 02h
int 10h
      
;plocio ivedimas is klavos
mov dx, 00
mov ah, 09h
lea dx, t3      ;isveda t3 pranesima
int 21h        
      
mov ah,0ah
lea dx, plotis
int 21h
      
;aukscio isvedimas 
lea si, aukstis+2
mov cl, aukstis+1       ;skaitliukas(pirmam baite-skaiciaus ilgis)
mov ch, 0
dec cl                  ;cl skaitliukas mazinamas 1
mov al, [si]
mov ah, 0
sub al, 30h
mov a, al
cmp cl, 0               ;lygina cl skaitliuka su 0
je ilgis1                ;jei cl=0, eik i ilgis
      
ciklas1:
inc si                  ;si didinamas 1
mov al, a
mul des                 ;al dauginama is 10
mov bx, 30h             
sub [si], bx            
add al, [si]            
mov a, al
loop ciklas1            
                        
;ilgio isvedimas        
ilgis1:                 
lea si, ilgis+2         
mov cl, ilgis+1         
mov ch, 0               
dec cl                  
mov al, [si]            
mov ah, 0
sub al, 30h             
mov b, al               
cmp cl, 0               
je plotis1              
                        
ciklas2:                
inc si                  
mov al, b               
mul des                 
mov bx, 30h             
sub [si], bx            
add al, [si]            
mov b, al
loop ciklas2            
                        
;plocio isvedimas       
plotis1:                
;mov si, 0              
;mov cx, 0              
;mov ax, 0              
lea si, plotis+2        
mov cl, plotis+1        
mov ch, 0               
dec cl                  
mov al, [si]            
;mov ah, 0               
sub al, 30h             
mov c, al
cmp cl, 0               
je skaiciavimas         
                        
ciklas3:                
inc si                  
mov al, c               
mul des                 
mov bx, 30h             
sub [si], bx            
add al, [si]            
mov c, al
loop ciklas3            
                        
skaiciavimas:           
mov al, a
imul b                   
imul c                   
mov rez, al             
                        
mov cl, 3              
;mov ch, 0               
lea bx, rez1+3          
mov al, rez             
                        
ciklas4:                
mov ah, 0
div des
add ah, 30h
mov [bx], ah
mov ah, 0   
dec bx
loop ciklas4
      
spauzdinimas1:
;rezultatu isvedimas
;ekrano valymas
mov ax, 02h
int 10h

;kursoriaus nustatymas per viduri
;mov ah, 02h
;mov bh, 0       ;ikeliamas ekrano nr(turi buti 0)
;mov dh, 12      ;ikeliamas ekrano eilutes nr.
;mov dl, 15      ;ikeliamas ekrano stulpelio nr.
;int 10h

;panesimo t4 spauzdinimas
mov ah, 09h
lea dx, t4
int 21h

;rezultato spauzdinimas
mov ah, 09h
lea dx, rez1
int 21h

;ekrano uzlaikymas
mov ah, 07h
int 21h

;grizimas i DOS'a
mov ah, 4ch
int 21h

programa ends
end start
