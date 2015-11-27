;formule (2*a+b^2+3*c)/(14*b)
stekas segment stack                                 
  db 256 dup(0)                                      
stekas ends                                                
                                                           
cr        equ 13                
lf        equ 10                                           
                                                           
duomenys segment                                           
  rez dw 0
  du db 2 
  a db 9
  trys db 3         
  b db 1     
  c db 3     
  keturiolika db 14
ekranas   db 'Spresime lygti: ',cr,lf,7                    
          db '(2*a+b^2+3*c)/(14*b)' ,cr,lf
          db 'Uzduoti atliko: Arunas, Voitech ir Robertukas, Viduto. ',cr,lf
          db 'Spauskite bet koki klavisa',cr,lf,'$'
duomenys ends
program segment                                            
    assume cs:program,ds:duomenys,ss:stekas                
start:                                                     
mov ax,duomenys                                            
mov ds,ax                                                  
;isvalome ekrana                                           
mov ax,0002h                                               
int 10h                                                    
;rodome pranesima                                          
         mov ah,09h
         lea dx,ekranas
         int 21h
                                                           
;laukia klaviso paspaudimo                                 
         mov ah, 07h
         int 21h
 mov AL, du
 mov AH,0
 mul a   
 mov CX, AX
 mov AH, 0
 mov AL, b
 mul b   
 add CX, AX
 mov AH, 0
 mov AL, trys
 mul c    
 add CX, AX
 mov AH, 0
 mov AL, keturiolika
 mul b   
 mov BX, AX
 mov AX, CX
 mov DX, 0
 div BX  
 mov rez, AX
mov ah,4ch          
int 21h             
                                                           
program ends                                               
END start