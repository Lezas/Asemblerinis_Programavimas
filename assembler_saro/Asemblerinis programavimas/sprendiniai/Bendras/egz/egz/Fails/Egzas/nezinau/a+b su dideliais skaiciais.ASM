stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
darom db 'antroji programa',13,10
db 'skaiciuosim a+b su dideliais skaiciais',10,13,'$'
ats db 'a+b=','$'
a dw -101
b dw -9     
des dw 10     
c dw ?         
T1 db 4 dup (0),'$'
duomenys ends 
programa segment
assume cs:programa,ds:duomenys,ss:stekas
start: 
mov ax,duomenys
mov ds,ax   
mov ax,02h  
int 10h     
mov ah,09h  
lea dx,darom
int 21h     
mov ah,09h  
lea dx,ats  
int 21h     
mov ax,a    
add ax,b
      
      
mov c,ax          
lea bx,T1+3
mov cx,0 
;nulinam dx,nes ats jame jau sedi
mov dx,0 
cmp ax,0
jge ciklas  ;jge kai daugiau arba lygu uz nuli
neg ax      ;zenklo keitimui
mov cl,'-'
ciklas:
div des 
add dl,30h ;liekada ,kadangi dw naudojam issisaugo dx,konkreciau dl 
mov [bx],dl 
mov dx,0
dec bx 
cmp ax,0 ;tikrina ar sveik dal
jne ciklas   
cmp cl,'-'
jne isvedimas
mov [bx],cl     
;loop ciklas
isvedimas: 
mov ah,09h  
lea dx,T1   
int 21h     
mov ah,07h  
int 21h     
mov ah,4ch  
int 21h     
programa ends
end start