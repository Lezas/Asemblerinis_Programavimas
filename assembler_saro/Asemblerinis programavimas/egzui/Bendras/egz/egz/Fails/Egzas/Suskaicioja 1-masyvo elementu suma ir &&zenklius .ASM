;Kursinio darbo uzduotis Nr. 6
;Atliko: Arunas Ciesiunas, II-1/5
                          
;Uzduotis: "Masyvo elementu suma"
;Masyvo elementai - baitai
                                         
;Steko segmentas                         
stekas segment stack                     
  db 256 dup(0)                          
stekas ends                            
                                       
;Duomenu segmentas                     
duomenys segment                       
  tekstas db "Kursinio darbo uzduotis Nr. 6",10,13
          db "Uzduotis: Masyvo elementu suma",10,13
          db "Atliko: Arunas Ciesiunas, II-1/5",10,13
          db "",10,13,'$'              
 rezult   db "Rezultatas: ",'$'        
        mas db 51,2,13,4,45 ;masyvas is 5 elementu
        rez db 3 dup(0)                
            db '$'                               
        des db 10                                
netelpa db "Atsakymas netelpa"
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
                                                 
;Skaiciu sudejimas cikle                         
  mov cx, 5                                      
  mov ax, 0                                      
  mov bx, 0
                                               
ciklas:                                          
 add al, mas[bx]
 JC perpildymas
 inc bx
loop ciklas                                      
                                           
                             
;Rodome pranesima jei viskas gerai

  mov dx, 0            
  div des          
  mov rez+2, ah    
  add rez+2, 30h   
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov rez+1, ah                                  
  add rez+1, 30h                                 
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov rez, ah                       
  add rez, 30h                      
                       
  mov ah,09h           
  lea dx, rezult       
  int 21h              
                                    
  mov ah, 09h                       
  lea dx, rez                       
  int 21h                           

                                   
;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h                           
                                    
;Programos pabaiga                  
mov ax,4C00h                                               
int 21h                             
                                    
perpildymas:                        
;Jei netelpa - rodome pranesima
mov ah, 09h
lea dx, netelpa
int 21h
                              
;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h        
                 
;Programos pabaiga
mov ax,4C00h                                               
int 21h                                
program ends     
end start