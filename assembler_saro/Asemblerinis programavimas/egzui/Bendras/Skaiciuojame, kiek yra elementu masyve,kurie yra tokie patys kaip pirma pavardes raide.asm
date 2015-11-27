


;Skaiciuojame, kiek yra elementu masyve,kurie yra tokie patys kaip 
;pavardes pirma raide
stekas segment stack                                                          
       db 256 dup (0)                                                         
ends stekas                                                                   
d equ 10                                                                      
t equ 13                                                                      
duomenys segment                                                              
         a db 'p','a','c','d','b','a','a','a','a','p'
           db 'p','a','a','a','a','a','a','a','a','a' 
           db 'c','a','e','e','c','c','a','a','p','a' 
           db 'd','a','d','a','d','a','a','a','a','a' 
           db 'a','a','c','a','a','a','a','a','a','a'
  pran1 db 'Skaicius elementu, kurie lygus pavardes pirmai raidei',t,d, '$'
         sk db 0,'$'                                                               
                                                                                   
 pran2 db t,d, 'Iveskite savo pavarde',t,d,'$'                   
 doleris db '$'                                                                     
 pavarde db 20                                                   
        db ?                                                     
        db 20 dup ('*'), '$'                                     
                                                                 
ends duomenys                                                    
                                                                 
programa segment                                                 
         assume ds:duomenys, cs:programa, ss:stekas              
  start: mov ax,duomenys                                         
         mov ds,ax                                               
                                                                 
         ;ekrano valymas                                         
         mov ax,0002h                                            
         int 10h                                                 
                                                                 
;pavardes pranesimo isvedimas                                    
  mov ah,09h                                                     
  lea dx,pran2                                                   
  int 21h                                                        
                                                                 
;pavardes ivedimas is klaviaturos                                
  mov ah, 0Ah                                                    
  lea dx,pavarde                                                 
  int 21h                                                        
                                                                 
    mov al,0 ;skaitliukas uznulinamas                            
    mov cx,50 ;50 kartus suksime cikla
    mov bx,0                                                     
                                                                 
      mov ah,pavarde[2];issaugomas pirma pavardes raide          

ciklas:                                                          
      cmp a[bx],ah
          jne BG                                                 
          inc al                                                 
      BG:                                                        
      inc bx 
loop ciklas ; 50 kartus                                           
                                                                 
add al,30h                                                       
mov sk,al                                                        
                                                                 
;pranesimo spausdinimas                                          
mov ah,09h                                                       
lea dx,pran1                                                     
int 21h                                                          
                                                                 
mov ah,02                                                        
mov bh,00                                                        
mov dh,5                                                         
mov dl,5                                                         
int 10h                                                          
                                                                 
;spausdiname ats                                                 
mov ah,09h                                                       
lea dx,sk                                                        
int 21h                                                          
                                                                 
;laukiame klaviso paspaudimo                                     
mov ah,07h                                                       
int 21h                                                          
                                                                 
 mov ah,4ch                                                      
 int 21h                                                         
programa ends                                                    
 end start                                                       
     