;Uzduoti atliko :)
stekas segment stack               
  db 256 dup(0)                    
stekas ends            
cr        equ 13                
lf        equ 10                     
                       
duomenys segment               
  kiek db 20, ?        
  vardas db 20 dup('*'),cr,lf,7,'$' 
  ivedimas db 5,0
  iv db 5 dup(0),cr,lf,7,'$'
  ivedimasb db 5,0
  ekranas   db 'Uzduoti atliko: ',cr,lf,7,'$'
  ivesk db 'Iveskite varda: ',cr,lf,7,'$'
  aived db cr,lf,'Iveskite a: ',cr,lf,7,'$'
  bived db cr,lf,'Iveskite b: ',cr,lf,7,'$'
  ats db 'Atsakymas x=a+b=',cr,lf,7,'$'
  du dw 2              
  des dw 10
  a dw 0,'$'
  b dw 0,'$'         
  rez db 0,'$'
duomenys ends                                  
                                               
programa segment                               
  assume ds:duomenys, ss:stekas, cs:programa   
start:                                         
   mov ax,duomenys                             
   mov ds,ax                                   
   ;isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
                                    
 ;rodome pranesima                  
   mov ah,09h                                  
   lea dx,ivesk                     
   int 21h                                     
                                                           
;vardas:                            
    mov ah,0Ah   
    mov bx,0
    lea dx, kiek 
    int 21h                       
                 
  ;isvalome ekrana                                           
   mov ax,0002h                                               
   int 10h                                                    
                       
 ;rodome pranesima                  
   mov ah,09h                                  
   lea dx,ekranas                              
   int 21h                                     
                 
   lea dx,vardas 
   mov ch,0                            
   mov cl,kiek+1                       
   add cx,1      
                 
   lea bx,vardas 
   add bx,cx     
   mov dl,'$'    
   mov [bx], dl  
   ;rodome pranesima                  
   mov ah,09h    
   lea dx,vardas 
   int 21h                                     
                 
                 
 ;a ivedimas     
   mov ah,09h     
   lea dx, aived  
   int 21h         
   mov ah,0Ah      
   mov bx,0        
   lea dx, ivedimas 
   int 21h         
                   
                   
   lea bx,ivedimas+3
   sub ivedimas+2,30h      
   mov ah,0        
   mov al, ivedimas+2      
   mov a,ax          
   mov ch,0        
   mov cl,ivedimas+1
   dec cl           
      
   cmp cl,0        
   JE baigiama     
                   
   ciklasa:        
   mov ax,a        
   mul des         
   sub BYTE PTR [BX],30h    
   add al,[BX]
   mov ah,0
   mov a, ax       
   inc bx    
             
  loop ciklasa
  baigiama:  
        
  mov sp,a
            
  ;b ivedimas
   mov ah,09h     
   lea dx, bived
   int 21h         
   mov ah,0Ah      
   mov bx,0        
   lea dx, ivedimasb 
   int 21h          
                    
                    
   lea bx,ivedimasb+3
   sub ivedimasb+2,30h      
   mov ah,0         
   mov al, ivedimasb+2      
   mov b,ax
   mov ch,0         
   mov cl,ivedimasb+1
   dec cl           
                   
   cmp cl,0        
                   
   JE baigiamb     
                   
   ciklasb:   
   mov ax,b
   mul des         
   sub BYTE PTR [BX],30h
   add al,[BX]
   mov ah,0 
   mov b, ax
   inc bx    
             
  loop ciklasb
  baigiamb:     
  
  mov bp,b       
            
  mov ax,0
  mov bx,0
            
  add sp,bp 
  mov dx,sp
  mov si,0
          
skaic1:    
div des    
mov ah,0   
cmp al,0   
je sk      
inc si     
jmp skaic1    
sk:        
mov ax,dx  
skaicius:  
div des    
add ah,30h 
mov rez[si],ah
dec si      
mov ah,0    
cmp al,0    
je isvedimas
jmp skaicius
            
isvedimas:  
mov ah,09h  
lea dx,rez  
int 21h     
mov ah,4ch  
int 21h     

               
programa ends
end start