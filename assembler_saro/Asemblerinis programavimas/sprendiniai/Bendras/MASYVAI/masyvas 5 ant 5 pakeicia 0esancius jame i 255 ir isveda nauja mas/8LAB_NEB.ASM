stekas segment stack
        db 256 dup(?)
stekas ends     
                
duomenys segment
       uzduotis  db 'Programa isveda i ekrana masyva: 5x5',10,13   
                 db 'kuriame yra maziausiai 6 nuliai.',10,13       
                 db 'Programa masyve esancius nulius pakeicia i 255',10,13
                 db 'ir pakeista masyva isveda i ekrana.',10,10,13 
                 db 'Darba atliko : Levaldas Sukovas II-2/3',10,10,10,13,'$'
                                                                   
       Prad_Mas  db 'Pradinis masyvas:',10,13,'$'                  
       Pak_Mas   db 10,10,13,'Pakeistas masyvas:',10,13,'$'        
                                                                   
       mas1  db 9,8,9,0,1,'$'                                      
       mas2  db 5,2,0,9,4,'$'                                      
       mas3  db 1,0,0,1,8,'$'                                      
       mas4  db 0,8,5,6,4,'$'                                      
       mas5  db 2,5,8,7,0,'$'                                      
                                                                   
       keit  db 255
       temp  db ?,'$'
       temp2 db ?,'$'
       tarp  db '  $'
       kite  db 10,13,'$'
       tikr  db ?,'$'
       dal   db 10
                                    
                                                  
duomenys ends                                     
                                                  
programa segment                                  
assume cs:programa, ds:duomenys, ss:stekas 
                      
keist proc            
      mov al,keit
      mov si,1
cikl1:        
      div dal 
      cmp ah,0
      je tol  
      inc si  
      jmp cikl1
tol:          
      mov al,keit
cikl2:           
      mov cx,si  
cikl3:           
      div dal                
      loop cikl3         
      mov temp2,al       
      add temp2,30h      
      mov ah,09h         
      lea dx,temp2       
      int 21h            
      dec si     
      cmp si,0   
      je pab
      mov ax,0000h  
      mov ch,ah
      mov al,ch
      jmp cikl2           
pab:                          
      RET     
keist endp           
                                                       
START:                                            
         mov ax,0002h                                                          
         int 10h                                  
         mov ax,duomenys                                          
         mov ds,ax                                                
         mov ah,09h                                               
         lea dx,uzduotis                                          
         int 21h                                  
                                    
PRADMAS:                            
         mov ah,09h                 
         lea dx,Prad_Mas            
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0  
mas1is:  mov bh,mas1[si]
         add bh,30h
         mov temp,bh     
         mov ah,09h 
         lea dx,temp  
         int 21h   
         mov ah,09h
         lea dx,tarp
         int 21h   
         inc si    
         loop mas1is
         mov ah,09h
         lea dx,kite
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0           
mas2is:  mov bh,mas2[si]
         add bh,30h 
         mov temp,bh     
         mov ah,09h 
         lea dx,temp  
         int 21h    
         mov ah,09h 
         lea dx,tarp
         int 21h    
         inc si     
         loop mas2is
         mov ah,09h
         lea dx,kite
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0           
mas3is:  mov bh,mas3[si]
         add bh,30h
         mov temp,bh     
         mov ah,09h 
         lea dx,temp  
         int 21h   
         mov ah,09h
         lea dx,tarp
         int 21h   
         inc si    
         loop mas3is
         mov ah,09h
         lea dx,kite
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0        
mas4is:  mov bh,mas4[si]
         add bh,30h 
         mov temp,bh     
         mov ah,09h 
         lea dx,temp  
         int 21h    
         mov ah,09h 
         lea dx,tarp
         int 21h    
         inc si     
         loop mas4is
         mov ah,09h 
         lea dx,kite
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0         
mas5is:  mov bh,mas5[si]
         add bh,30h
         mov temp,bh     
         mov ah,09h 
         lea dx,temp  
         int 21h   
         mov ah,09h
         lea dx,tarp
         int 21h   
         inc si    
         loop mas5is
         mov ah,09h
         lea dx,kite
         int 21h   
                   
;PAKMAS            
         mov ah,09h
         lea dx,Pak_Mas
         int 21h                   
                           
         mov bh,0  
         mov cx,5  
         mov si,0  
masp1is: mov bh,mas1[si] 
         cmp bh,0
         je keisti
         jne toliau
keisti:  call keist
         jmp toliaua
toliau:  add bh,30h
         mov temp,bh 
         mov ah,09h
         lea dx,temp  
         int 21h   
toliaua: mov ah,09h
         lea dx,tarp
         int 21h  
         inc si   
         loop masp1is
         mov ah,09h
         lea dx,kite
         int 21h 
         mov bh,0 
         mov cx,5 
         mov si,0           
masp2is: mov bh,mas2[si]
         cmp bh,0
         je keisti2  
         jne toliau2
keisti2:  call keist
         jmp toliaua2
toliau2:  add bh,30h
         mov temp,bh 
         mov ah,09h
         lea dx,temp  
         int 21h   
toliaua2: mov ah,09h
         lea dx,tarp
         int 21h  
         inc si   
         loop masp2is
         mov ah,09h
         lea dx,kite
         int 21h
         mov bh,0 
         mov cx,5 
         mov si,0             
masp3is: mov bh,mas3[si]
         cmp bh,0
         je keisti3
         jne toliau3
keisti3:  call keist
         jmp toliaua3
toliau3:  add bh,30h
         mov temp,bh 
         mov ah,09h
         lea dx,temp  
         int 21h   
toliaua3: mov ah,09h
         lea dx,tarp
         int 21h  
         inc si   
         loop masp3is
         mov ah,09h
         lea dx,kite
         int 21h  
         mov bh,0 
         mov cx,5 
         mov si,0        
masp4is: mov bh,mas4[si]
         cmp bh,0   
         je keisti4
         jne toliau4
keisti4:  call keist
         jmp toliaua4
toliau4:  add bh,30h
         mov temp,bh 
         mov ah,09h
         lea dx,temp  
         int 21h   
toliaua4: mov ah,09h
         lea dx,tarp
         int 21h  
         inc si   
         loop masp4is
         mov ah,09h
         lea dx,kite
         int 21h   
         mov bh,0  
         mov cx,5  
         mov si,0         
masp5is: mov bh,mas5[si]
         cmp bh,0   
         je keisti5
         jne toliau5
keisti5:  call keist
         jmp toliaua5
toliau5:  add bh,30h
         mov temp,bh 
         mov ah,09h
         lea dx,temp  
         int 21h   
toliaua5: mov ah,09h
         lea dx,tarp
         int 21h  
         inc si   
         loop masp5is
         mov ah,09h
         lea dx,kite
         int 21h                   
;pabaiga 
        mov ah,07h                                                           
        int 21h                                                              
        mov ah,4ch        
        int 21h    
                
programa ends
end start  
