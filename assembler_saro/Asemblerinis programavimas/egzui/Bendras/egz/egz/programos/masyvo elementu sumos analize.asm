 ;Kursinio darbo uzduotis Nr.4
;Masyvo elementu sumos analize
;Atliko Audrius Burkauskas II-1/3
pran1 macro prn  
       mov ah,09h      
       lea dx,prn 
       int 21h  
endm              
pran macro prn                                                
       pran1 prn                                              
       jmp pabaiga
endm       
  
  
stekas segment stack                      
 db 256 dup(?)                            
stekas ends                               
                                          
duomenys segment                          
      
      uzduotis db 10,13,'Uzduotis Nr.4','$'
      vardas db 10,13,'Atliko Audrius Burkauskas II-1/3','$'         
      error  db 10,13,'Skaicius netelpa i viena baita','$'        
      Pran_0 db 10,13,'Gautas rezultatas lygus 0 ','$'
      Pran_Dg db 10,13,'Gautas rezultatas daugiau uz 0 ','$'               
      Pran_Mz db 10,13,'Gautas rezultatas maziau uz 0 ','$'
      telpa db 10,13,'Gautas rezultats telpa i baita ','$'        
      oa db 100,0,7,-100,7
            temp db (?)                                  
                                                              
 duomenys ends                                     
                                                   
programa segment                                   
 assume cs:programa, ds:duomenys, ss:stekas                   
start:                                                        
      mov ax,duomenys                                         
      mov ds,ax                                               
                                          
      mov ax, 0002h                  
      int 10h                                   
                                     
pran1 uzduotis                 
                               
pran1 vardas               
                                                              
xor bx,bx                       
xor cl,cl                       
ciklas:                                                       
add cl, oa[bx]                  
jo  klaida                      ;jeigu flagas "o" - perpildymas -  lygus vienetui einu i klaida:                              
                           
inc bx                          
cmp bx, 5                       ;kol maziau uz 5
jb ciklas                       
                                                              
pran1 telpa                     
                                                              
cmp cl,0                        ;lyginu su nuliu
jl maziau                       ;jeigu maziau uz nuli isveda maziau
                        
je nulis                        ;jei lygu nuliui einu i nulis 
                       
jg daugiau                      ;jei daugiau einu i daugiau
                                                             
pabaiga:                                                      
        mov ah,07h                                            
        int 21h                                               
        mov ah,04Ch                                           
        int 21h                                               
                                                              
klaida:                                                       
pran error
                                                              
nulis:                                                        
pran Pran_0
    
daugiau:                                                   
pran Pran_Dg
                                                           
maziau:                                                    
pran Pran_Mz                                            
    
programa ends                                              
end start