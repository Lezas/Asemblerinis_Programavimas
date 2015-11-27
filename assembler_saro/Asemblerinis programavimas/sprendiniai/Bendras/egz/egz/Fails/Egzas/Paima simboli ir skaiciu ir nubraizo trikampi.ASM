stekas segment stack                                                        
        db 256 dup (?)                                                      
stekas ends                                                                 
                                                                            
duom segment                                                                
                                                                            
pran1   db 'Kursinis Darbas',10,13                                          
        db 'Aleksandr Kovaliov II-2/2',10,13                                
        db 'Variantas Nr13',10,13                                           
        db 'Programa praso vartotoja ivesti skaiciu bei viena simboli, ',10,13
        db 'ir is ivesto simbolio ekrane suformuoja tusciaviduri trikampi,',10,13
        db 'kurio krastines ilgis lygus ivestam skaiciui.',10,13            
        db 10,13                                                            
        db 'Spauskyte bet kokia klavisa.$',10,13                            
                                                                            
pran2   db 'Iveskyte Simboli kurio pagalba braizisim trikampio kontura.$',10,13
                                                                            
;Ivedam simboli kurio pagalba braizisim rikampio kontura.                   
simb    db 3,?,3 dup (?)                                                    
x       db 1 dup (?),'$'                                                    
i       dw 0                                                                
tarpas  db ' ','$'                                                          
pran3   db 'iveskite skaiciu nuo 2 iki 9: $'                                
skaic   db 3,?,3 dup (?),'$'
Jenter db '',10,13,'$'                                                      
duom ends                                                                   
prog segment                                                                
assume cs: prog,ds: duom, ss:stekas                                         
                                                                            
start:                                                                      
mov AX, duom                                                                
mov DS, ax                                                                  
                                                                            
mov ax,2      	   	;isvalom ekrana                                     
int 10h                                                                     
                                                                            
mov ah,09h   		;isvedam 1 pranesima                                
lea dx, pran1                                                               
int 21h                                                                     
                                                                            
mov ah,07h      	;laukia klaviso paspaudimo                               
int 21h                                                                     
                                                                            
mov ax,2     		;isvalom ekrana                                     
int 10h                                                                     
                                                                            
mov ah,09h              ;isvedam 2 pranesima                                
lea dx,pran2                                                                
int 21h                                                                     
                                                                            
mov ah,0Ah              ;ivedan simboli is kurio braizysim trikampio kontura                                  
lea dx,simb                                                                 
int 21h                                                                     
                                                                            
mov ax,2     	  	;isvalom ekrana                                     
int 10h           
                                                                            
mov ah,09h 		;isvedam 3 pranesima                                
lea dx, pran3                                                               
int 21h                                                                     
                                                                            
mov ah,0Ah   		;ivedam skaiciu = trikampio krashtines ilgis
lea dx,skaic                                                                
int 21h                                                                     
                                                                            
mov ax,2    		;isvalom ekrana                                 
int 10h                                                                 
                                                                        
lea SI,simb+2                                             
mov ah,skaic+2                                            
mov skaic,ah                                              
sub skaic,30h                                             
                                                          
dec skaic                                                 
dec skaic                               
dec skaic                                                 
                                                          
mov ah,[si]                                               
mov x,ah                                                  
                                        
mov ah,09h              ;isveda virsutini trikampio simboli
lea dx,x                                                  
int 21h                                                   
mov ah,09h                                                
lea dx,jenter                                             
int 21h                                 
                                        
mov ah,09h              ;isveda 2-oj eilutej du simbolius
lea dx,x                                                  
int 21h                                 
mov ah,09h                              
                                        
lea dx,x                                                  
int 21h                                                   
mov ah,09h                                                
lea dx,jenter                                             
int 21h                                                 
toliau:                                                   
        cmp skaic,0                                       
        je pab                                            
        add i,1                                           
        ;inc i                                            
        dec skaic                                         
        mov cx,i                                          
                                                          
        mov ah,09h      ;piesia pirma eilutes simboli     
        lea dx,x                                          
        int 21h                                           
ciklas:        	    	;uzpildo eilute ivestu simboliu   
        mov ah,09h                                        
        lea dx,tarpas                                     
        int 21h                                           
loop ciklas                                               
        mov ah,09h      ;piesia paskutini eilutes simboli                                   
        lea dx,x                                          
        int 21h                                           
                                                          
        lea dx,Jenter 	;Enter.                           
        int 21h                                           
        jmp toliau                                        
pab:                                    
        add i,3                         
        mov cx,i                        
ciklas2:       	   	;uzpildo eilute ivestu simboliu   
        mov ah,09h                                        
        lea dx,x                                          
        int 21h                                           
loop ciklas2                                                          
                
        mov ah,07h 	;laukia klaviso paspaudimo                               
        int 21h                                           
                                                          
        mov ah, 4ch                                       
        int 21h                                           
prog ends                                                 
end start