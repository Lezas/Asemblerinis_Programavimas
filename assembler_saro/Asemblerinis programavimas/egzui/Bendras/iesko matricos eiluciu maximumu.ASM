stekas segment stack                                   
db 256 dup (?)                                         
stekas ends                                            
                                                       
duom segment                                           
pran db 'Darius Misiukevicius II-2/2',10,13   
     db 'Bilietas 17', 13,10,'$'              
pran1 db 'Rasti didziausius masyvo (30x2) eiluciu elementus',10,13,'$'
pran2 db 'Pirmos eilutes MAX elementas: ','$' 
pran3 db 'Antros eilutes MAX elementas: ','$' 
                                              
masyvas1 db 1,2,3,4,5,1,7,8,8,1,2,3,4,5,16,7,8,9,1,10,16,4,5,6,7,8,13,'$'
masyvas2 db 1,2,3,4,5,6,7,8,5,1,2,3,4,5,6,7,18,9,1,2,3,4,5,6,7,8,14,'$'
maximum db ?,10,13,'$'                                            
maxi  db 3 dup(30h),10,13,'$'                                      
maxii db 3 dup(30h),10,13,'$'                                    
de db 10                                                          
duom ends                                                         
                                                                  
                                                                  
;programos segmentas                                              
prog segment                                                      
assume cs: prog, ds:duom, ss:stekas                               
                                                                  
start:                                                            
mov ax, duom                                                      
mov ds, ax                                                        
                                                                  
mov al,0                                                          
lea si,masyvas1                                                   
mov maximum,0                                                     
ieskom:                                                           
        mov cl,[si]  
         
        cmp maximum,cl                                            
        jl max
       
        cmp cl,'$'  ;tikrina masyvo pabaiga         
        jge tvarkymas
;        cmp maximum,cl                                            
 ;       jle max
        max:                                                      
        mov maximum,cl                                            
        inc si                                                    
        jmp ieskom                                                
                                                                  
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
                                                                                         
                                                                  
        mov ax,02h ;ekrano isvalymas                              
        int 10h                                                   
                                                                  
        mov ah,09  ;pranesimu spausdinimas                        
        lea dx, pran                                              
        int 21h                                                   
                                                                  
        lea dx, pran1                                             
        int 21h                                                   
                                                                  
        lea dx, pran2                                             
        int 21h                                                   
                                                                  
        lea dx,maxi                                               
        int 21h                                                   
                                                                  
;        mov ah,07h;Pause                                         
 ;       int 21h                                                  
  ;                                                               
   ;     mov ah,4ch;grizimas i OS                                 
    ;    int 21h                                                  
     ;                                                            
                                                                  
mov al,0                                                          
lea si,masyvas2                                                   
mov maximum,0                                                     
;mov maxi,0                                                       
ieskom1:                                                          
        mov cl,[si]                                               
       cmp cl,'$'  ;tikrina masyvo pabaiga
       je tvarkymas1
        cmp maximum,cl
        jle maxx                                                  
        maxx:                                                     
        mov maximum,cl                                            
        inc si                                                    
        jmp ieskom1                                               
tvarkymas1:         ;maximumo vertimas i desimtaine sistema       
        mov ah,0                                                  
        mov al,maximum                                            
        div de                                                    
        add maxii+2,ah                        
        mov ah,0                                                  
        div de                                                    
        add maxii+1,ah                        
        mov ah,0                                                  
        div de                                                    
        add maxii,ah                          
                                                                                         
                                                                  
;        mov ax,02h ;ekrano isvalymas                             
;        int 10h                                                  
                                                                  
        mov ah,09  ;pranesimu spausdinimas                                                 
                                                                  
        lea dx, pran3
        int 21h                                                   
                                                                  
        lea dx,maxii
        int 21h                                                   
                                                                  
        mov ah,07h;Pause                                          
        int 21h                                                   
                                                                  
        mov ah,4ch;grizimas i OS                                  
        int 21h                                                   
                                                                  
                                                                  
prog ends                                                         
end start                                                         
                 