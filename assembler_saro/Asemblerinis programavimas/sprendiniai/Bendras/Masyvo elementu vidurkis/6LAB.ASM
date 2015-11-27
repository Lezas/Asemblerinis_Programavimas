stekas    segment stack
          db 256 dup(0)      
stekas    ends               

duomenys  segment                       
                                        
pran      db 'Laboratorinis darbas Nr.6 ',10,13
          db 'Uzduotis apie vienmati masyva ',10,13
          db 'Atliko: ',10,13
          db 'Algimantas Verdingovas is II-2/3 grupes',10,13
          db '',10,13,'$'                                             
  suma db '','$'                                                         
  masyvas db 9,2,3,4,5,1,7,8,9,6,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,'$'
        a db ?,'$'                                          
        sk db '','$'                                        
        sim db 100                                          
        des db 10                                           
        rez db ?,'$'                                        
        dpenki db 25,'$'                                    
        tmp  db ?,'$'                                       
        liek db ?,'$'                                       
        padal db ?,'$'                                      
        lll db 2 dup(' '),'$'                               
        vid db ?,'$'                                        
rezsuma db 'Masyvo elementu suma yra: ','$'                 
vidurkis db 'Masyvo elementu vidurkis yra: ','$'            
daugyba db '6 ir 9 elementu sandauga yra lygi: ','$'        
skirtumas db '7 ir 23 elementu skirtumas yra lygus: ','$'   
liekana db ' liekana ','$'                                  
eilute db ,10,13,'$'                                        
duomenys  ends                                                     
                                                                   
                                                               
programa  segment                                           
          assume cs:programa, ds:duomenys, ss:stekas        
vidsk proc                                                  
      mov bh,sk                                             
      mov bl,25                                             
      div bl                                                
 ret                                                        
vidsk endp                                                  
                                                            
                                                            
start:                                                      
;Duomenu inicializavimas                                    
          mov ax, duomenys                                  
          mov ds,ax                                         
;Ekrano isvalymas                                           
          mov ax,0002h                                      
          int 10h                                           
; Pranesimo isvedimas                                                         
        mov ah,09h                                          
        lea dx,pran                                            
        int 21h                                             
                                                            
        mov ah, 09h                                         
        lea dx, rezsuma                                     
        int 21h                                             
                                                                             
       	mov ah,00                                           
       	mov cx,25                                           
       	mov si,0                                            
                                                            
      	ciklas:                                             
      	        add bh,masyvas[si]                          
  	        inc si                                      
 	loop ciklas                                         
 	        mov sk,bh                                   
     	        mov al,sk                                   
                          	                            
; rezultato formavimas                                      
       cmp al,sim                                              
       jb desimt                                            
       div sim                                              
       mov liek, ah                                         
       mov tmp, al                                          
       add tmp, 30h                                         
                                                            
       mov ah,09h                                           
       lea dx, tmp                                          
       int 21h                                              
       mov ah, 00                                           
       mov al, liek                                         
                                                            
    desimt:                                    
        cmp al, des                            
        jb vienas                              
        div des                                
        mov liek, ah                           
        mov tmp, al                              
        add tmp, 30h                           
        mov ah, 09h                                            
        lea dx, tmp                            
        int 21h                                
        jmp likes                              
                                               
    vienas:                                    
        mov liek, al                           
    likes:                                     
        add liek, 30h                          
        mov ah, 09h                            
        lea dx, liek                           
        int 21h                                       
                                      
        mov ah,09h                              
        lea dx, eilute                
        int 21h                       
                                      
        mov ah,09h                    
        lea dx,vidurkis                          
        int 21h                       
                                                               
        mov ah,00                     
                                      
        mov al,sk                     
        mov bl,25                     
        div bl                        
                                      
        mov liek,ah                   
        mov tmp,al                    
                                      
                                      
        add tmp,30h                   
        mov ah,09h                    
        lea dx,tmp                    
        int 21h                       
                                      
        mov ah,09h                    
        lea dx, liekana               
        int 21h                                  
                                      
        add liek,30h                                           
        mov ah,09h                    
        lea dx,liek                   
        int 21h                       
                             	      	                       
        mov ah,09h                                             
        lea dx,eilute                                          
        int 21h                                                
                                                               
        mov ah,09h                                             
        lea dx,daugyba                                         
        int 21h                                                
                                                               
        mov al,masyvas[5]                                      
        mul masyvas[8]                                         
        add al,30h                                             
        mov tmp,al                                             
                                                               
        mov ah,09h                                             
        lea dx,tmp                                             
        int 21h                                                
                  
        mov ah,09h
        lea dx,eilute
        int 21h      
                  
        mov ah,09h
        lea dx,skirtumas
        int 21h   
                  
        mov al,masyvas[6]
        sub al,masyvas[22]
        add al,30h
        mov tmp,al
                                                                               
        mov ah,09h                                             
        lea dx,tmp                                             
        int 21h                                                
;laukia klaviso paspaudimo                                     
          mov ah, 07h                                          
          int 21h                                              
                                                               
;grizhta i DOS                                                 
          mov ah,4ch                                           
          int 21h                                              
programa  ends                                                 
          end start                                            
