;Laboratorinio darbo uzduotis Nr. 10
;Atliko: Arunas Ciesiunas, II-1/5
stekas segment stack
       db 256 dup(?)
       ends stekas
                  
duomenys segment     
       mas db 11,2,0,2
           db 56,9,56,0
           db 5,5,5,5
           db 1,2,3,4
         kiek db 0   
         c db 0      
                     
tekstas db "Laboratorinio darbo uzduotis Nr. 10",10,13
        db "Uzduotis: Masyvo eiluciu, kuriu 1-as elementas pasikartoja, suma",10,13
        db "Atliko: Arunas Ciesiunas, II-1/5",10,13,'$'
   pran db 13,10,'Eiluciu, kuriu 1-asis elementas pasikartoja yra: ',13,10,'$'
duomenys ends        
                                                      
programa segment                                      
         assume ds:duomenys,ss:stekas,cs:programa     
start: mov ax,duomenys                                
       mov ds,ax                                      
                     
;Ekrano isvalymas    
  mov ax,0002h       
  int 10h            
;Rodome pranesima    
 mov ah,09h          
 lea dx,tekstas      
 int 21h                                   
                                                      
 mov ax,0            
 mov bx,0            
 mov dx,0            
 mov ch,0            
 mov cl,4            
 mov c,cl            
                     
;Ejimas per stulpelius
stulpelis: mov al,mas+[bx]
           mov si,0      
           mov cx,0      
           mov cl,4      
;Eilutes             
eilute: inc si                                         
        mov dl,mas+[si]+[bx]
        cmp ax,dx     
        je radom      
        loop eilute
                     
tesiam: add bl,4      
        mov cl,c      
        dec c         
        loop stulpelis
        jmp pabaiga   
                                                      
;Padidinam kiek    
radom: add kiek,1  
       jmp tesiam
                   
;Rodome rezultatus                  
pabaiga: mov dx,0             
         mov ah,09h                                     
         lea dx,pran                                    
         int 21h              
                            
;Isvedame i ekrana rezultata
  mov dx,0
  mov dl,kiek
  add dl,30h
  mov ah,02h
  int 21h
        
;Programos pabaiga                             
  mov ah,4ch            
  int 21h
programa ends                
end start