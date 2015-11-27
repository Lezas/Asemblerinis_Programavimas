;Kursinio darbo uzduotis Nr. 2
;Atliko: Jaroslav Jakubovskij ii-2/2
                          
;Uzduotis: "Fromules skaiciavimas: (a^2+b^2)*grNr"
;Priskirtos reiksmes: a=4; b=3; grNr=2;
                                    
;Steko segmentas                    
stekas segment stack                
  db 256 dup(0)                     
stekas ends                         
                                    
;Duomenu segmentas                  
duomenys segment                    
  tekstas db "Kursinio darbo uzduotis Nr. 2",10,13
          db "Uzduotis: Fromules skaiciavimas: (a^2+b^2)*grNr",10,13
          db "Jaroslav Jakubovskij ii-2/2",10,13
          db "",10,13
          db "X=(4^2+3^2)*2=",'$'
        a db 4
        b db 3
        grNr db 2
        rez db 2 dup(0)
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
  mul a 
  mov bx, ax
            
  mov ah, 0 
  mov al, b
  mul b     
  add al, bl
            
  mul grNr  
                 
;Rezultato sutvarkymas ir isvedimas i ekrana
  mov dx, 0      
  div des
  mov rez+1, ah
  add rez+1, 30h
  mov ah, 0
  mov dx,0
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