stekas segment stack 
db 256  dup (?)  
stekas ends      
duom segment
klai db 'hhhhhh',10,13,'$'
t1 db 'ivesk skaiciu a',10,13,'$'
t2 db 'ivesk skaiciub'    ,10,13, '$'       
t3 db ' a+b=',10,13, '$'
d db 10    
skaic1 db 3,?,3 dup ( 0) ,10,13, '$'
skaic2 db 3,?,3 dup (0)  ,10,13,'$'
a db 0     
b db 0     
rez db 0   
ats db 3 dup (0), '$'
duom ends  
                     
prog segment         
assume ss:stekas, ds:duom, cs:prog
eiga:                
mov ax, duom         
mov ds, ax           
mov ax, 02h          
int 10h              
           
mov ah, 09h          
lea dx, t1           
int 21h    
             
                 
mov ah, 0ah
lea dx,skaic1
 int 21h   
mov ax, 02h
int 10h     
 mov dx, 0    
 mov ah, 09h
lea dx, t2 
int 21h    
           
            
mov ah, 0ah 
lea dx, skaic2
int 21h 

; vet buten cia iesko ar a nera kokios raides:)
   
mov bx,1   
mov si,1   
ciklas_n:           
sub si,1   
add bx,1   
mov al,skaic1[bx]
cmp al,30h 
jl ciklas_n 
cmp al,39h 
jg ciklas_n
cmp si,0
je tes  
mov ah,09h
lea dx,klai
int 21h 
jmp eik_1   

; vet cia paieska baigta:)
;ir toliau viskas zaprasta:)
tes:        
 ; vertimas
mov ch, 0
mov cl, skaic1+1
dec cl  
lea si, skaic1+2
mov al, [si]
mov ah, 0
sub al, 30h
mov a, al       
cmp cl,0        
je ciklas1      
                
                
ciklas:         
inc si          
mov al, a       
mul d           
mov bl, [si]
sub bl,30h      
add al, bl      
mov a, al       
loop ciklas     
                
                
jmp suolis
 eik_1:
jmp eik
suolis:


ciklas1: ; cia sisip
                
mov ch,0        
mov cl,0        
mov cl, skaic2+1
dec cl          
mov si, 0       
lea si, skaic2+2
mov al, 0       
mov ah, 0       
mov al, [si]    
sub al,30h      
mov b,al        
cmp cl,0        
je skaiciuok    
                
ciklas2:        
   inc si       
   mov al, b    
   mul d
   mov bl,[si]  
   sub bl,30h   
   add al, bl   
   mov b, al    
   loop ciklas2 
                
   skaiciuok:   
   mov al,0      
   mov bh, 0    
   mov bl,0     
   mov ah, 0     
                 
       mov al, a 
       mov bl, b 
       add al, bl
       mov rez, al
   mov al,0      
   mov bh, 0    
   mov bl,0     
   mov ah, 0              
                 
   lea bx, ats+2
   mov cl,3     
   mov ch,0     
   mov al, rez  
   cik:         
                
   div d        
   add ah,30h   
   mov [bx], ah 
   mov ah,0 
   dec bx   
   loop cik 
            
   mov ah , 09h
   lea dx, ats
   int 21h 
   jmp eik 
  
       eik:        
   mov ah, 07h
   int 21h  
   mov ah, 4ch
   int 21h  
   
   prog ends
   end eiga 
            
