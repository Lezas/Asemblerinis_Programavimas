stekas segment stack               
  db 256 dup(0)                    
stekas ends                       
                                  
duomenys segment                  
 ats db 20 dup (?),'$'
 pran1  db 'Sestas laboratorinis darbas ',10,13,'$'
 pran2 db 'Ivesk skaiciu ','$'    
 pran3 db 10,13, 'Ats: ','$'      
duomenys ends                                                 
                                                              
programa segment                                              
  assume ds:duomenys, ss:stekas, cs:programa                  
start:                                                        
   mov ax,duomenys                
   mov ds,ax                                   
                                            
   mov ax,02h     ;isvalome ekrana                                            
   int 10h                                                    
                                           
   mov ah,09h       ;rodome pranesima                             
   lea dx,pran1                      
   int 21h                           
                                     
   mov ah,09h                        
   lea dx,pran2                      
   int 21h                           
                                     
   mov si,0     ;registra si naudojame masyvo indeksui nurodyti                     
ivedimas:                            
   mov ah,08h                        
   int 21h                           
   cmp al,13                         
   je isvedimas                      
   cmp al,30h                        
   jb ivedimas                       
   cmp al,39h                        
   ja ivedimas                       
                                     
   mov dl, al                        
   mov ah, 02h                       
   int 21h                           
                                     
   mov ats[si],al                 
   inc si       ;si reiksme didnama vientu                  
   jmp ivedimas                           
                                    
isvedimas:                 
   mov ah, 09h
   lea dx,pran3
   int 21h 
                           
   mov ah,09h              
   lea dx,ats              
   int 21h                 
                           
   mov ah,07h              
   int 21h                 
                               
   mov ax,4C00h                                               
   int 21h                 
programa ends              
end start