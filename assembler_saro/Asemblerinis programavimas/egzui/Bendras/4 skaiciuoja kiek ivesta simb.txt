stekas segment stack ;aprasomas stekas
db 256 dup (0)    
stekas ends
duomenys segment ;aprasomi duomenys
pran db  'Iveskite simbolius:',10,13,'$'
ats db 'Ivasta simboliu:','$'
simb db 255, ?, 255 dup (0),'$'
kiek db 3 dup (0),'$'
desimt db 10
duomenys ends        
programa segment               
assume cs:programa, ds: duomenys, ss: stekas
start: ;programos pradzia
mov ax,duomenys      
mov ds,ax            
;isvalom ekrana      
mov ax,02h           
int 10h;pertarukimas per BIOS
;isvedam pranesima su prasymu ivesti simbolius                          
     mov ah, 09h             
     lea dx, pran            
     int 21h ;Pertraukimas per DOS
     ;nuskaitom simbolius is klaviaturos
mov ah,0ah                   
lea dx,simb;i dx nurodomas adresas kur kelti nurodytus simbolius
int 21h              
                     
mov ax,0;isvalm registra ax
;ivestu simboliu sk perkeliam i al
mov al,simb[1]  ;simb antras elementas bus skaicius kiek ivesta simboliu,simb[0] bus 255                   
;ivestu simboliu skaiciu paverciam i simboliui(to reikia isvedimui)
mov si,2
ciklas:                    
div desimt
add ah,30h  
mov kiek[si],ah
mov ah,0
dec si
cmp al,0
jg ciklas                  
;isvalom ekrana               
mov ax,02h                 
int 10h              
;isvedam i ekrana pranesima ' Atsakymas:'                     
mov ah,09h                 
lea dx,ats                 
int 21h              
;isvedam i ekrana pati atsakyma(simboliu skaiciu)                    
mov ah,09h                                       
lea dx,kiek                                      
int 21h                                          
  mov ah, 07h     ;sulaiko ekrana                
   int 21h                                       
; paskutines dvi eilutes privalomas dalykas kiekvienoje programoje                                         
     mov ah, 4ch       ;uzbaigia programa                               
     int 21h                                          
     programa ends                                    
     end start     ;programos pabaiga                                   
