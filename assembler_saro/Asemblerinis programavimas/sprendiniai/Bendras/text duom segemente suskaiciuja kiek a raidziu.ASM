;programa is duoto teksto isveda a raidziu kieki                         
                        
stekas segment stack                                        
db 256 dup(?)                                               
stekas ends                                                 
                                                            
        duomenys segment                                    
        pranesimas db 'a raidziu kiekis:',10,13,'$'
        rez db 'rezultatas:',10,13,'$'   
        masyvas db 'aaaA',10,13,'$'
        ats db ?, '$'                         
        kiek db 0
        enteris db 10,13,'$'                        
        duomenys ends                                       
                                                            
        programa segment                                    
        ASSUME cs: programa, ds: duomenys, ss: stekas       
                                                            
                                                            
                                                            
        start:                                              
                                                            
                 mov ax,duomenys                            
                 mov ds,ax                                  
                                                            
                 mov ax,0002h ;ekrano isvalymas             
                 int 10h                                    
                                                            
                 mov ah,02h           ;kursoriaus nustatymas
                 mov dh,1             ;eilutes nr
                 mov dl,20            ; stulpelio nr
                 int 10h                  
                                          
                 mov ah, 09h              
                 lea dx,pranesimas        
                 int 21h                  
                 
                 mov ah,09h
                 lea dx,enteris
                 int 21h
                 
       
mov ah,09h
lea dx,rez
int 21h

     mov cx,16
     mov si,0    
                  
;pirmas ciklas mazosiom a  
                                  
ciklas:                                   
          xor ax,ax                                                               
                              
             MOV al,masyvas[SI]                              

    cmp al,41h
    jne persokt
    
   inc kiek
    
    persokt:
    
    add si,1
  dec cx
  cmp cx,0
  jne ciklas                                 
 
;antras ciklas didziosiom A
      
     mov cx,16
     mov si,0                      
                                    
ciklas2:                                   
          xor ax,ax                                                               
                              
             MOV al,masyvas[SI] 
             
                              
    cmp al,61h
    jne persokt2
    
   inc kiek
    
    persokt2:
    
    add si,1
  dec cx
  cmp cx,0
  jne ciklas2                         
              
                     
                 mov bl,kiek
                 add bl,30h
                 mov ats,bl
                 
                 mov ah,09h
                 lea dx,ats
                 int 21h
                                        
                 mov ah, 07h              
                 int 21h                  
                                        
                 mov ah, 4ch            
                 int 21h                
                                        
        programa ends                   
        end start 