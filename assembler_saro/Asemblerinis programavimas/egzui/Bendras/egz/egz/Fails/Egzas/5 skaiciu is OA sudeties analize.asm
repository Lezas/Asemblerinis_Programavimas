;Kursinio darbo uzduotis Nr. 4
;Atliko: Arunas Ciesiunas, II-1/5
                          
;Uzduotis: "5 skaiciu is OA sudetis ir rezultato analize"
;Priimame kad skaiciai - baitai be zenklo
                                         
;Steko segmentas                         
stekas segment stack                     
  db 256 dup(0)                          
stekas ends                            
                                       
;Duomenu segmentas                     
duomenys segment                       
  tekstas db "Kursinio darbo uzduotis Nr. 4",10,13
          db "Uzduotis: 5-iu skaiciu is OA sudetis ir analize",10,13
          db "Atliko: Arunas Ciesiunas, II-1/5",10,13
          db "",10,13,'$'              
 netelpa  db "Rezultatas netelpa i baita",10,13,'$'
 telpa    db "Rezultatas telpa i baita",10,13,'$'
 nulis    db "Rezultatas lygus 0",10,13,'$' 
 nenulis  db 10,13,"Rezultatas nelygus 0",10,13,'$'
 rezult   db "Rezultatas: ",'$'        
        a db 5 dup(?)
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
                                                 
;Skaiciu sudejimas cikle                         
  mov cx, 5                                      
  mov ax, 0                                      
                                                 
ciklas:                                          
 add al, a[si]                                   
 JC perpildymas                
loop ciklas                                      
                                           
                               
cmp al,0                       
JNE nul                        
;Lygu nuliui                   
                               
;Rodome pranesima jei viskas gerai
mov ah,09h                     
lea dx, telpa                  
int 21h                        
                               
mov ah,09h                     
lea dx,nulis                   
int 21h                        
;Laukiamas klaviso paspaudimas 
  mov ah, 07h                  
  int 21h                      
                                    
;Programos pabaiga                  
  mov ax,4C00h         
  int 21h              
                                    
nul:                   
;Rezultato sutvarkymas ir isvedimas i ekrana
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
;Rodome kad nenulis 
 mov ah,09h        
 lea dx, nenulis   
 int 21h           
;Rodome kad telpa i baita
 mov ah, 09h
 lea dx, telpa
 int 21h                   
                                    
;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h                           
                                    
;Programos pabaiga                  
mov ax,4C00h                                               
int 21h                             
                                    
perpildymas:                        
;Jei netelpa i baita - rodome pranesima
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