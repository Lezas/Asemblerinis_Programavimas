stekas segment stack                              
       db 256 dup (?)                             
stekas ends                                       
                                                  
duom segment                                           
        pran0 db 'Atliko: Viktorija Briskmanaite, II-04/4',10,13
        db 'Uzduotis: Ivedus du skaicius ',10,13       
        db 'pirma atspausdina pirmo skaiciaus pirma skaitmeni,',10,13
        db 'paskui antro skaiciaus pirma skaitmeni ir t.t.',10,13
        db 'Iveskite pirma sk (MAX 5 simboliai): ','$'
        prn db 'Iveskite antra sk (MAX 5simboliai): ','$'
        prn1 db 'Gautas rezultatas:',10,13,'$'    
        kl db 'KLAIDA: ivestu simboliu skaicius nesutampa!!','$'
        kl2 db 'KLAIDA: nieko neivedete!!','$'
        sk1 db 6,?,6 dup(?)                
        sk2 db 6,?,6 dup(?)                
        x db 1 dup (?),'$'                          
        x1 db ?                                     
        x2 db ?                                     
duom ends                                                    
                                                             
;programos segmentas                                         
prog segment                                                 
        assume cs: prog,ds: duom, ss:stekas                  
                                                             
start:                                                       
mov AX, duom                                                 
mov DS, ax                                          
                                                    
mov ax,2 ;ekrano isvalymas                          
int 10h                                                   
                                                    
mov ah,09h ;pranesimu spausdinimas                  
lea dx,pran0                                                    
int 21h                                             
                                                    
mov ah,0Ah ;pirmo sk ivedimas                       
lea dx,sk1                                          
int 21h                                             
                                                    
lea SI,sk1+2                               
                                           
mov ax,2 ;ekrano isvalymas                          
int 10h                                             
                                           
mov ah,sk1+1                               
cmp ah,0                                   
je klaida2                                 
                                                    
mov ah,09h ;pranesimo spausdinimas                  
lea dx,prn                                          
int 21h                                             
                                                    
mov ah,0Ah ;antro sk ivedimas                       
lea dx,sk2                                          
int 21h                                             
                                                    
lea DI,sk2+2                                                    
                                                    
mov ax,2 ;ekrano isvalymas                          
int 10h                                    
                                           
mov ah,sk2+1                               
cmp ah,0                                   
je klaida2                                 
                                                    
;ivestu siboliu ilgiu tikrinimas                    
mov ah,sk1+1                                        
mov x1,ah                                           
mov ah,sk2+1                                        
cmp x1,ah                                           
je t                                                
jmp klaida                                          
                                           
t:                                         
        mov ah,09h ;pranesimo spausdinimas                
        lea dx,prn1                             
        int 21h                                 
toliau:                                                  
        mov AH,[SI]                                      
        cmp AH,0Dh                         
        je pab                             
        mov x,ah                           
                                                                
        mov ah,09h                         
        lea dx,x                           
        int 21h                            
                                           
        mov AH,[DI]                        
        cmp ah,0Dh                         
        je pab                             
        mov x,ah                           
                                           
        mov ah,09h                         
        lea dx,x                           
        int 21h                            
                                           
        inc si                             
        inc di                             
        mov x,0                            
        jmp toliau                         
klaida:                                    
        mov ah,09h                                                      
        lea dx,kl                                                       
        int 21h                            
        jmp pab                            

klaida2:                                   
        mov ah,09h                         
        lea dx,kl2                         
        int 21h                            
pab:                                       
        mov ah,07h                         
        int 21h                            
        mov ah, 4ch                        
        int 21h                            
prog ends                                  
end start