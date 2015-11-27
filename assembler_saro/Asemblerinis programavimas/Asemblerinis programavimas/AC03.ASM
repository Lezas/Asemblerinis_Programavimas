;Laboratorinis darbas Nr.3
;Atliko: Arunas Ciesiunas, II-1/5
                          
;Uzduotis: "Fromules skaiciavimas: X=a+b+c"
;Priskirtos reiksmes: a=2; b=3; c=5;
                                    
;Steko segmentas                    
stekas segment stack                
  db 256 dup(0)                     
stekas ends                         
                                    
;Duomenu segmentas                  
duomenys segment                    
  tekstas db "Laboratorinis darbas Nr. 3",10,13
          db "Uzduotis: formules skaiciavimas: X=a+b+c",10,13
          db "Atliko: Arunas Ciesiunas, II-1/5",10,13
          db "",10,13
          db "X=2+3+5=",'$'
        a db 2
        b db 3
        c db 5
        rez db 3 dup(0)
            db '$'
        des db 10 
duomenys ends                                         
                                                      
;Programos segmentas                                  
program segment                                       
 assume cs:program, ds:duomenys, ss:stekas            
                                                      
 start:                                               
  mov ax, duomenys                                    
  mov ds, ax                                          
              
;Ekrano isvalymas
  mov ax,0002h
  int 10h     
              
;Rodomas tekstas
  mov ah,09h                                       
  lea dx,tekstas  
  int 21h     
              
  mov ah, 0
  mov al, a      
  add al, b      
  add al, c      
                 
;Rezultato sutvarkymas ir isvedimas i ekrana
  mov dx, 0      
  div des
  mov rez+2, ah
  add rez+2, 30h
  mov ah, 0
  mov dx,0
  div des
  mov rez+1, ah
  add rez+1, 30h
  mov ah, 0
  mov dx, 0
  div des
  mov rez, ah
  add rez, 30h              
  
  mov ah, 09h
  lea dx, rez
  int 21h
                 
;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h        
                 
;Programos pabaiga
mov ax,4C00h                                               
int 21h          
                 
                 
program ends     
end start