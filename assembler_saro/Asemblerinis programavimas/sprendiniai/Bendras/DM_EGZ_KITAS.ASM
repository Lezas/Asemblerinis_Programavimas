stekas segment stack                                   
db 256 dup (?)                                         
stekas ends                                            
                                                       
duom segment                                           
pran db 'Atliko Igor Borodovskij II-2/2',10,13
     db 'Ekzamino 4 uzduotys', 13,10,'$'                
pran1 db 'Masyvo 30x2 diziausio elemento radimas',10,13,'$'
pran2 db 'Masyvo 1 eilutes didziausias elementas: ','$'
pran3 db 'Masyvo 2 eilutes didziausias elementas: ','$'
                                                   
masyvas1 db 1,2,3,4,5,1,7,8,8,1,2,3,4,5,6,7,8,9,1,20,16,4,5,6,7,8,2,'$'
masyvas2 db 1,2,3,4,5,6,7,8,9,1,2,30,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,'$'
maximum db ?,10,13,'$'                                    
maxi db 3 dup(30h),10,13,'$'                       
testas db 1                                        
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
                                                   
masd:                                              
mov al,0                  
lea si,masyvas2                                    
mov maximum,0                                 
dec testas                                    
jmp ieskom                                         
                                                  
ieskom:                                           
        mov cl,[si]                                    
        cmp cl,'$'  ;tikrina masyvo pabaiga              
        je tvarkymas                                   
        cmp maximum,cl                            
        jle max                                   
        inc si                                    
        jmp ieskom                                
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
                                                                                         
        cmp testas,0                          
        je skipisv               
                                 
        mov ah,09  ;pranesimu spausdinimas
        lea dx, pran             
        int 21h                  
        lea dx, pran1            
        int 21h                  
        lea dx, pran2            
        int 21h                  
        skipisv:                 
                                 
        cmp testas,1                          
        je skipisv2           
                              
        mov ah,09             
        lea dx, pran3         
        int 21h               
 skipisv2:                    
                                        
        mov ah,09                                          
        lea dx,maxi                               
        int 21h                               
        cmp testas,0  
        je endas                              
                                              
        cmp testas,1                          
        je masd                               
                                              
                                                  
                                                  
                                                  
endas:        mov ah,07h;Pause                          
        int 21h                                   
                                                  
        mov ah,4ch;grizimas i OS                  
        int 21h                                   
prog ends                                         
end start                                         
                 