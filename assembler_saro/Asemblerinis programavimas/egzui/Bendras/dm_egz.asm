stekas segment stack                                   
   db 256 dup (?)                                         
stekas ends                                            
                                                       
duom segment                                           
    pran db 'Darius Misiukevicius ii-2/5',10,13,'$'
   pran1 db 'Didziausiu eiluciu elementu radimas',10,13,'$'
   pran2 db 'Pirmos eilutes MAX elementas: ','$'
   pran3 db 'Antros eilutes MAX elementas: ','$'
                                                   
masyvas1 db 1,2,3,4,5,1,7,8,8,1,2,3,4,5,6,7,8,9,1,9,16,4,5,6,7,8,2,'$'
masyvas2 db 1,2,3,4,5,6,7,8,9,1,2,25,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,'$'
 maximum db ?,10,13,'$'                                    
    max2 db ?,10,13,'$'                                 
    maxi db 3 dup(30h),10,13,'$'                        
     min db 3 dup(30h),10,13,'$'
      de db 10                                               
duom ends                                              
                                                       
                                                       
;programos segmentas                                   
prog segment                                           
   assume cs: prog, ds:duom, ss:stekas                 
                                                       
start:                                                 
        mov ax, duom                                           
        mov ds, ax                                             
                                                    
        mov ax,02h ;ekrano isvalymas                        
        int 10h                                             
                                                    
        mov al,0                                            
        lea si,masyvas1                                     
        mov maximum,0                                       
        jmp ieskom                                          
                                                                                                
ieskom:                                             
        mov cl,[si]                                    
        cmp cl,'$'  ;tikrina masyvo pabaiga              
        je start3                                   
        cmp maximum,cl                              
        jle max                                     
        inc si                                      
        jmp ieskom                                  
max:
        mov maximum,cl                              
        inc si
        jmp ieskom                                
                                                       
start3:                                                
        mov al,0                                           
        lea si,masyvas2                                    
        mov max2,0                                 
        jmp ieskom2                                         
                                                                                             
ieskom2:                                           
        mov cl,[si]                                    
        cmp cl,'$'  ;tikrina masyvo pabaiga              
        je tvarkymas                                   
        cmp max2,cl                                
        jle minxi2                                 
        inc si                                     
        jmp ieskom2                                
minxi2:                         
        mov max2,cl             
        inc si                                    
        jmp ieskom2             
                                
        mov ax,0900h            
        lea dx,max2             
        int 21h                 
                                
tvarkymas:         ;maximumo vertimas i desimtaine sistema
        mov ah,0                                       
        mov al,maximum                            
        div de                                         
        add maxi+2,ah                             
        mov ah,0                                       
        div de                                         
        add maxi+1,ah                                   
        mov ah,0                                       
        div de                                         
        add maxi,ah                                     
                                                                                         
        mov ah,09  ;pranesimu spausdinimas
        lea dx, pran            
        int 21h                 
        lea dx, pran1           
        int 21h                  
        lea dx, pran2           
        int 21h                 
        lea dx,maxi             
        int 21h                 
                                
        mov ah,0                
        mov al,max2             
        div de                                         
        add min+2,ah            
        mov ah,0                                       
        div de                                         
        add min+1,ah            
         mov ah,0               
        div de                                         
        add min,ah              
                                                                                         
        mov ax,0900h                                   
        lea dx,pran3            
        int 21h                 
        lea dx,min              
        int 21h                 
                                              
                                        
                                                  
                                                  
endas:
        mov ah,07h;Pause                          
        int 21h                                   
                                                  
        mov ah,4ch;grizimas i OS                  
        int 21h                                   
prog ends                                         
end start                                         
                

