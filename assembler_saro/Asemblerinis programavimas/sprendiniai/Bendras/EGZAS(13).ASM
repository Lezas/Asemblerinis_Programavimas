 ;Uzduotis: "paskaiciuoja penkiu skaiciu vidurki aprasyta duomenu segmente"
;Priskirtos reiksmes: a=2; b=3; c=5; d=1; e=2;
                                            
;Steko segmentas                            
stekas segment stack                        
  db 256 dup(0)                             
stekas ends                                 
                                            
;Duomenu segmentas                          
duomenys segment                            
  tekstas DB "uzduotis:vidurkio skaiciavimas: X=(a+b+c+d+e)/5",10,13
          db "Atliko: jevgenij bobrovic",10,13        
          db "",10,13                   
          db "X=2+3+5+1+2=",'$'             
        a db 1                          
        b db 2                          
        c db 3           
        d db 1   
        e db 2     
        rez db 3 dup(0)
            db '$'
        liek db 3 dup(0)
             db '$'
        des db 10       
        penk db 5       
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
  add al, d             
  add al, e             
  div penk              
  ;mov ah,09h           
  ;lea dx,al            
  ;int 21h              
                        
;Rezultato sutvarkymas ir isvedimas i ekrana
    mov dx, 0           
  div des               
  mov rez+2, ah         
  add rez+2, 30h 
  mov liek+2,al
  add liek+2,31h
  mov ah, 0             
  mov al,0
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
  mov ah,09h
  lea dx,liek
  int 21h       
                
                
                 
;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h        
                 
;Programos pabaiga
mov ax,4C00h                                               
int 21h          
                 
                 
program ends     
end start