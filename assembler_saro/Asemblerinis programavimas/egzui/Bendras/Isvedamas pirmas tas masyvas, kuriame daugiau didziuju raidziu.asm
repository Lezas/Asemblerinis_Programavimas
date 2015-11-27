 stekas segment stack
        db 256 dup (?)
                      
stekas ends           
                      
duom segment          
        mas db '1msWJJEvvnb54 ',10,13,'$'
        mas1 db 'dSfsHdfLgg',10,13,'$'
        rez1 db 15,?,15 dup(?),10,13,'$'                                            
        rez2 db 15,?,15 dup(?),10,13,'$'                                            
        pr db 'Atliko Marius Kazlauskas II-2/2',10,13                               
     
        db 'Isvedamas pirmas tas masyvas, kuriame daugiau didziuju raidziu',10,13,'$'
        lygu db 'Dizdiuju raidziu skaicius masyvuose vienodas!',10,13,'$'       
        d db 'Didziuju raidziu daugiau masyve: ','$'                            
        m db 'Didziuju raidziu maziau masyve: ','$'                             
        ner db 'Nei vienam masybe nebuvo rasta didziuju raidziu!',10,13,'$'     
        raid db 'Abiejuose masyvuose yra po: ','$'                              
        raide db ' didz. raid.!',10,13,'$'                                      
        i1 dw 0,'$'                                                             
        i2 dw 0,10,13,'$'                                                       
        i3 dw 0,10,13,'$'                                                       
        i4 dw 0,10,13,'$'                                                       
        i5 dw 0,10,13,'$'                                                       
        pab db 'pabaiga',10,13,'$'                                              
        e db '',10,13,'$'                                                       
duom ends                                                                       
                                                                                
                                                                                
;programos segmentas                                                            
prog segment                                                                    
        assume cs: prog,ds: duom, ss:stekas                                     
start:                                                                          
mov AX, duom                                                                    
mov DS, ax                                                                      
                                                                                
mov ax,2 ;isvalom ekrana                                                        
int 10h                                                                         
mov ah,09h
lea dx,pr
int 21h
                                                                                
lea SI,mas                                                                      
jmp toliau                                                                      
kitas:                                                        
add i1,30h                                                    
cmp i2,1                                                      
je pabaiga                                                    
add i2,1                                                      
mov ax,i1                                                     
add i3,ax                                                     
mov i1,0                                                      
lea SI,mas1                                                  
toliau:                                                       
        mov AH,[SI]                                          
        cmp ah,'$'                                           
        je kitas                                              
        cmp ah,41h                                                         
        jl next                                              
        cmp ah,5ah                                           
        jg next                                              
        inc i1                                               
        next:                                                
        inc si                                               
        jmp toliau                                            
pabaiga:                                                      
        mov ax,i3                                             
        cmp i1,ax                                             
        je l                                                  
                
        mov ah,09h
        lea dx,d                                             
        int 21h 
        jl pir  
        jg ant                                                
                                                              
pir:    cmp i5,1                                              
        je pa        
        mov ah,09h                                            
        lea dx,mas                                           
        int 21h                                              
        lea dx,e                                             
        int 21h                                               
        add i5,1                                              
        cmp i4,1                                              
        je ant                                                
        pir1:                                                 
        mov ah,09h                                            
        lea dx,m                                              
        int 21h                                               
        jmp ant                                               
                                                                           
ant:    cmp i4,1                                              
        je pa                                                  
        mov ah,09h                                            
        lea dx,mas1                                          
        int 21h                                              
        lea dx,e                                             
        int 21h                                               
        add i4,1                                              
        cmp i5,1                                              
        je pir                                                
        ant1:                                                 
        mov ah,09h                                            
        lea dx,m                                              
        int 21h                                               
        jmp pir                                               
                                                             
        l:         
        mov ah,09h                                                         
        lea dx,lygu
        int 21h
                
        lea dx,raid
        int 21h               
        lea dx,i1
        int 21h                                              
        lea dx,raide
        int 21h 
        jmp pa     
pa:                                                              
        lea dx, pab                  
        int 21h   
        mov ah,07h
        int 21h                                                           
        mov ah, 4ch                                           
        int 21h                                               
prog ends                                                     
                                                
end start                                       
