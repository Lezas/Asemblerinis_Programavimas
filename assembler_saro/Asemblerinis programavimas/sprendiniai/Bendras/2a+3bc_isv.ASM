stekas segment stack
       db 256 dup (?)
stekas ends         
                             
Duomenys segment             
       a db 4                
       b db 3                
       c db 2                
       temp   db 0       
       ten    db 10      
       rezult db 3 dup(?)
       smsme  db 'Dimitrianas Kondrasovas II - 1/3',13,10,'$'
       smsuzd db 'a*2 + 3*b*c',13,10, '$'
       smsrez db 'Rezultatas: $'   
Duomenys ends                                                 
                                                              
Programa segment                                              
assume cs:programa, ds:duomenys, ss:stekas                    
start:                                                
      mov ax, duomenys                                
      mov ds, ax                                      
                                                      
      mov ax, 0002h            
      int 10h                  
      mov ah, 09h                                     
      lea dx,smsme             
      int 21h                  
      mov ah, 09h              
      lea dx, smsuzd           
      int 21h                  
      mov ah, 09h
      lea dx, smsrez
      int 21h                  
skaiciuoju:                        
      mov ax, 2                
      mul a                    
      mov bx,ax                
      mov ax,3                 
      mul b                    
      mul c                    
      add ax,bx     
      mov temp, al  
                        
      mov si, 0     
      ciklas:           
             mov ax, 0
             mov al, temp
             inc si      
             mov di, si          
             div ten     
             mov rezult[si], ah
             mov temp, al
             cmp al, 0   
             je asci   
      jmp ciklas           
      asci:                
             add rezult[si], 30h
             dec si        
             cmp si, 0     
             je output
      jmp asci
      Output:              
             mov ah, 02h   
             mov dl, rezult[di]
             int 21h
             dec di 
             cmp di,0
             je exit
      jmp output                 
  exit:       
     mov ah, 07h               
     int 21h                   
     mov ah, 4ch               
     int 21h                   
programa ends           
end start 