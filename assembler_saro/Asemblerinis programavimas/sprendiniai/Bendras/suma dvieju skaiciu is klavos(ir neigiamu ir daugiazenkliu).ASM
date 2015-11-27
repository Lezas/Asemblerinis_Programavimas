; 11 10
;II-3/5 Dainiaus Stasiuno
;Teksta isvesti per ekrano viduri
;ivedimas is klaviaturos, a+b (ir neigiamu) skaiciavimas   


stekas segment stack             
        db 256 dup (?)           
stekas ends                      
                                 
duomenys segment                 
      Ivedimas db 20,?,20 dup (0),'$'
      PavIved db 15,?,15 dup (0)
      du db 2                   
      a db 0                    
      c db 255                             
      tarp db 0              
      des db 10              
      x db 0                             
      zenklas db 0           
      ats db 4 dup (?),'$'   
                             
   pran1 db 'Laboratorinis darbas nr.8',10,13
         db 'Uzduotis: ivedimas is klaviaturos, a+b (ir neigiamu) skaiciavimas,',10,13
         db 'vaizdo isvedimas ekrano centre.',10,13
         db 'Atliko: Dainius Stasiunas II-3/5',13,10
         db 'Noredami testi toliau spauskite betka',13,10,'$'
                                                  
   pran3 db 'Iveskite skaiciu nuo -127 iki 128: ',13,10,'$'
   pran4 db 'Iveskite skaiciu nuo -127 iki 128: ',13,10,'$'      
   pran2 db 'Iveskite savo pavarde: ',13,10,'$'                  
   pran5 db 'Ivyko perpildymas, spauskite enter ir iveskite skaicius isnaujo',13,10,'$'
   t1 db 'Atliko: ','$'                                                    
   dol db '$'                                                              
   min db ' -','$'
duomenys ends                                                              
                                                                           
programa segment                                                           
assume cs:programa, ds:duomenys, ss: stekas                                
;**************************************Paprogrames
Init Proc                    
mov ax, duomenys                                                           
mov ds, ax                                                                 
                                                                           
mov ax, 0002h                                                              
int 10h                                                                    
ret                          
Endp                         
                             
perpild Proc                 
mov ax, 0002h                            
int 10h                      
                             
mov ah, 09h                              
lea dx, pran5                            
int 21h                                         
mov a,0                       
ret                          
Endp                         
                             
Pavarde Proc                 
;Pavardes paemimas                       
mov AH,0Ah                               
LEA DX,PavIved                           
int 21h                                  
                                         
Lea Bx,PavIved+2                         
Sub Cx,0                                 
Mov Cl,PavIved+1                         
add Bx,Cx                                
Mov Ch,Dol                               
mov [Bx],Ch                              
                                                                           
mov ah, 02h                              
mov bh, 00                               
mov dh, 12                               
mov dl, 25                               
int 10h                                  
                                         
;isvedimas                               
mov ah, 09h                              
lea dx, t1                               
int 21h                                  
lea dx, PavIved+2                        
int 21h                      
ret                          
endp                         
                             
Imtiskait Proc               
                             
mov AH,0Ah  ; skaicio paemimas                                                               
LEA DX,Ivedimas                                                            
int 21h                                                                    
                                                                           
lea BX,Ivedimas+2                                                          
MOv CX,0                                                                  
mov cl,Ivedimas+1                                                          
dec cl                       
                             
MOV AL,[BX]                                                                
cmp Al,2Dh                    
jne tol1                     
inc zenklas                  
inc BX                       
dec cl                       
MOV Al,Ivedimas[BX]                             
tol1:                        
cmp Ivedimas[BX],30h
jl perpild1   
cmp Ivedimas[bx],39h
jg perpild1   
              
SUB AL,30h                                                                 
MOV a,AL                                                                   
                                                                           
cmp cl,0                                                                   
JE APEINAMCIKLA                                                            
                                                                           
ciklas:                                                                    
INC BX      
cmp a,12                     
ja perpild1                  
cmp Ivedimas[BX],30h
jl perpild1 
cmp Ivedimas[bx],39h
jg perpild1 
MUL Des;                     
Mov Si,30h                                                                 
SUB [BX],Si                                                                
Add al,[BX]                                                                
MOV a, al                    
cmp a,129                    
je perpild1                  
Loop ciklas                                                                
jmp APEINAMCIKLA                       
                                       
perpild1:                              
call perpild                           
jmp grizt                              
                                       
APEINAMCIKLA:                                                              
MOV a,al                     
ret            
endp        
;******** programa*****************                                                                           

start:                                                                                          
call Init          
                   
mov ah, 09h                                                                
lea dx, pran1                                                              
int 21h                                                                    
                                                                           
grizt:                          
mov ah, 07h ;Laukia enter paspaudimo                                       
int 21h                                                                    
                                                                           
mov ax, 0002h ;Ekrano valymas                                              
int 10h                      
                       
;Pries 1skc paemima          
mov ah, 09h                                                                
lea dx, pran3                                                              
int 21h                
                       
call Imtiskait                   
MOV al,a    
Mov x,Al               
                       
;tikrininimas koks skaicius ir ar geras            
cmp zenklas,1                          
jne toliau                             
cmp x,127                              
jg perpild1                            
neg x       
;***********************                                                   
                                       
toliau:                                
MOV zenklas,0
             
mov ax, 0002h                                                              
int 10h                                                                    
                                                                           
mov ah, 09h                                                                
lea dx, pran4                                                              
int 21h                                                                    
;***********************
;2 paemimas                                                                
            
call Imtiskait
mov tarp, al
            
cmp zenklas,1     
jne toliau2         
cmp tarp,127
ja perpild2 
neg tarp    
MOV al,tarp           
toliau2:    
MOV zenklas,0
            
;********* skaiciavimas
                 
Add x,al         
jo perpild2 ;reaguoja kai buna perpildymas (o=1) 
Mov al,x                                 
Mov ah,0                                 
            
;cmp al,128 
;ja perpild2
                 
cmp x,0      
jge teigiamas    
neg x        
inc zenklas      
                                
;*************************               
teigiamas:           
MOv al,x                                 
mov cx,3                                 
mov Bx,3
;skaiciaus suvedimas i masyva            
ciklasgalutinis:                            
div des ;al/10 -> ah liekana -> al sveikoji dalis
 add ah,30h                              
 mov Ats[BX],ah  ;issaugom liekana       
 dec BX ;mazina masyvo indeksa                             
 mov ah,0                                
 cmp al,0                                
je pabaiga                               
loop ciklasgalutinis                        
;*****************************           
perpild2:                                
call perpild                             
jmp grizt                                
              
pabaiga: ;*******Pavardes ivedimas                
mov ax, 0002h                            
int 10h                                  
                                         
mov ah, 09h                              
lea dx, pran2                            
int 21h                                  
              
call Pavarde                                         
              
;Tikrina ar yra neigiamas     
cmp zenklas,1 
je zenklidek  
jmp tzenkl    
              
zenklidek:    
mov ah,09h         
lea dx,min    
int 21h       
              
tzenkl:       
lea dx, Ats                              
int 21h       
                                  
mov ah, 07h                              
int 21h                                  
                                         
mov ah, 4ch                              
int 21h                                  
                                         
programa ends                            
end start     