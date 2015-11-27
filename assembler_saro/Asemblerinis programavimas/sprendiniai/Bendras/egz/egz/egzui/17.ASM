stekas segment stack
db 256 dup (?)  
stekas ends     
;================================
duomenys segment 
eilute db 200,?,200 dup (?)                              
duok_eil db 13,10,13,10,'Iveskite eilute:',13,10,'$' 
as db ' Atliko Dovile Mureikaite II-2/1'       
   db   ' Asamblerio kursinis darbas Nr: 2','$'
taip db 13,10,'TAIP','$'
nel db 13,10,'NE', '$'      
duomenys ends   
;================================               
programa segment                 
assume cs: programa, ds: duomenys, ss:stekas
   start:                                   
   mov ax, duomenys                         
   mov ds, ax                               
                                            
   mov ax, 0002h                            
   int 10h      ; issivalom ekrana            
                                            
   mov ah, 09h                              
   lea dx, as                               
   int 21h                                  
   lea dx, duok_eil
   int 21h           
                     
   mov ah, 0ah       
   lea dx, eilute      
   int 21h       ; ivedam eilute
   
   xor cx, cx    
   mov cl, eilute + 1 ; skaitliukas
   mov bx, cx         ; bx - simboliu skaicius
   lea si, eilute + 2                         
   add bx, si         ; galo adresas
   sub bx, 1          ; paskutinio simbolio adresas              
ciklas:                
   mov dx , si        ; laikinai issisaugom
   mov si, bx         ; eilutes galo adresas
   mov al, [si]       ; pasiimam simboli is kito galo 
   mov si, dx         ; atstatom si  
                       
   cmp al, [si]       ; lyginam pirma ir paskutini
   jne nelygu                                     
                                                  
   dec bx  ; n,n-1,n-2,...1
   inc si  ; 1,2,3,... n  
   loop ciklas         
   jmp lygu            
nelygu:                
   mov ah, 09h         
   lea dx, nel         
   int 21h 
   jmp dosas                      
lygu:           
   mov ah, 09h   
   lea dx, taip 
   int 21h      
dosas:                
   mov ah, 07h   
   int 21h       ; laukiam paspaudimo  
                
   mov ah, 4ch  
   int 21h       ; i dos'a
programa  ends  
end start               
               
               
               
               
   
   