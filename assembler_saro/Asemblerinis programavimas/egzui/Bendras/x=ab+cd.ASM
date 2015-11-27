stekas segment stack
db 256 dup(0)
stekas ends
duomenys segment                        
uzduotis db 'Programa padare Renaldas Buga ii-2/3',10,13
         db 'Parasyti programa,skaiciuojancia reiskini ab+cd ',10,13
         db 'atsakymas turi buti dvizenklis skaicius   ',10,13 ,'$'
             
             
   a db 10
   b db 5    
   c db 20    
   e db 2    
   d db ?,'$' 
   f db ?,'$'    
   g db 10,'$'
    plius db 'ab+cd=','$',10,13
       
                                 
duomenys ends                    
programa  segment                
assume cs:programa,ds:duomenys,ss:stekas
start:                           
     mov ax,0002h                
     int 10h                     
     mov ax,duomenys             
     mov ds,ax                   
     mov ah,09h                  
     lea dx,uzduotis                                                 
     int 21h                     
;skaiciuojam ab+cd
     mov al,a                    
     mul b   
     mov d,al
     mov al,c 
     mul e    
     add d, al                      
                                    
     mov al,d
     div g   
     mov d,al
     mov f,ah
             
             
;ishvedimas i ekrana             
    mov ah,09h                   
    lea dx,plius                 
    int 21h                      
                                 
     add d,30h                   
     mov ah,09h                  
     lea dx,d 
     int 21h 
        
     add f,30h
     mov ah,09h                  
     lea dx,f
     int 21h
                                   
     mov ah,09h                   
     lea dx,g                     
     int 21h                      
                                                                   
 ;pabaiga                         
     mov ah,07h                   
     int 21h                      
     mov ah,4ch               
     int 21h                  
                  
     programa ends
     end start    
             
       