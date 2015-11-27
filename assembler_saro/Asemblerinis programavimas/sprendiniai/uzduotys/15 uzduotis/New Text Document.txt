steck segment stack
       db 256 dup(0)
steck ends
data segment
        uzduotis db 'Paskaiciuoti masyvo suma ir vidurki,',10,13
                 db 'sesto ir devinto elemento sandayuga,',10,13
                 db 'septinto ir dvidesimt trecio elemento skirtuma',10,13
                 db 'Atliko: Evald Stachovic   II-2/5',10,13,'$'
        M db 1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,'$'
        pran1 db 'Suma: ','$'
        pran2 db 10,13, 'Vidurkis: ','$'
        pran3 db 10,13,'6 ir 9 elemento sandayuga: ','$'
        pran4 db 10,13,'7 ir 23 elemento skirtumas: ','$' 
        p db '.','$'
        sum db 0,'$'                           
        s db ?,'$'                             
        l db ?,'$'             
        d db ?,'$'             
        v db ?,'$'             
        v1 db ?,'$'            
        v2 db ?,'$'            
        c db 25,'$'            
        k1 db 100,'$'          
        k2 db 10,'$'                              
data ends                                      
prog segment                                   
assume cs:prog,ds:data,ss:steck                
start:                                         
      mov ax,data                              
      mov ds,ax                                
      mov ax,0002h                              
      int 10h                                  
                                               
      mov ah,09h                               
      lea dx,uzduotis                          
      int 21h                                  
                                               
      mov bh,0                                 
      mov cx,25                                
      mov si,0                                 
F:                             
      add bh,M[si]             
      add si,1                                 
      loop F                   
                               
      mov ah,09h               
      lea dx,pran1             
      int 21h                  
                                                   
      mov ax,00  
      mov sum,bh                              
      mov al,bh                                
      div k1                                   
      mov d,ah      
      mov s,al
              
      mov ah,09h  
              
      add s,30h
      lea dx,s 
      int 21h   
                   
      mov al,d
      mov d,0 
      div k2
      mov d,ah
      mov l,al
      mov ah,09h  
      add l,30h
      lea dx,s 
      int 21h             
      mov ah,09h
      add d,30h
      lea dx,d      
      int 21h   
                
;vidurkis      
      mov bh,0
      mov cx,25                                
      mov si,0                                 
g:    
      add bh,M[si]             
      add si,1                                 
      loop g   
      mov ax,00
      mov al,bh
      div c    
      mov v,al
      mov v2,ah
      mov ax,00
      mov al,v2
      mul k2
      div c
      mov v1,al
      mov v2,ah
      mov ax,00
      mov al,v2
      mul k2
      div c
      mov v2,al
      add v,30h
      add v2,30h
      add v1,30h
      
      mov ah,09h
      lea dx,pran2
      int 21h
      mov ah,09h
      lea dx,v
      int 21h
      mov ah,09h
      lea dx,p
      int 21h
      mov ah,09h
      lea dx,v1
      int 21h
      mov ah,09h
      lea dx,v2
      int 21h                    
      mov ah,07h                               
      int 21h                                  
      mov ah,4ch                               
      int 21h                                  
prog ends                                      
end start                                        
                                               
                                               
      