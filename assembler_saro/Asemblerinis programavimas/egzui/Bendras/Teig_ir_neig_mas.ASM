stekas segment stack                     
db 256 dup(0)
stekas ends                                                                  
;Duomenu segmentas                     
duomenys segment  
minus db 0
teig db  0                 
  tekstas db "Skaiciuojama teigiami ir neigiami",10,13
          db "Masyvo elementai",10,13
          db "",10,13,'$'
 rezult   db "Teigiami skaiciai: ",'$'
 rezultn  DB 'Neigiami skaiciai: ','$'
       
        mas db 1,2,-3,4,5 ;masyvas is 5 elementu
       
       
        rez db 3 dup(?),10,13,'$'
        rezn db 3 dup(?),10,13,'$'         
            
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
 mov al, mas[bx]
 cmp al, 0
 jl maziau
 jg daugiau
 jmp toliau
       
 maziau:   
 add minus,1
 jmp toliau
 daugiau:  
 add teig,1
 ;cmp al,'9'
 ;jae neig
 toliau:
 inc bx 
 loop ciklas                                      

                             
;Rodome pranesima jei viskas gerai 
  mov ax,0
  mov al,teig
  
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
;neigiami skaiciai   
  mov ax,0
  mov al,minus
  
  mov dx, 0            
  div des          
  mov rezn+2, ah    
  add rezn+2, 30h   
  mov ah, 0        
  mov dx, 0        
  div des                                        
  mov rezn+1, ah                                  
  add rezn+1, 30h                                 
  mov ah, 0                                
  mov dx,0                                 
  div des                                  
  mov rezn, ah                       
  add rezn, 30h    
  mov ah,09h           
 lea dx, rezultn  
  int 21h              
                                    
mov ah,09h
lea dx,rezn
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