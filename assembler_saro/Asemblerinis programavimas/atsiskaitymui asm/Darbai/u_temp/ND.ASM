stekas segment stack               
        db 256 dup (?)             
stekas ends                        
                                   
duomenys segment                   
        eilute db "SulA",10,13,'$'
        ilgis equ $ - eilute                                
        apv db ilgis dup (?)                                
        ilgis2 equ $ - apv            
duomenys ends                           
programa segment                        
                                        
 assume cs:programa, ds:duomenys, ss:stekas
                                        
 start:  ;programos pradzia                             
        mov ax, duomenys              
        mov ds,ax                     
        ;isvalomas ekranas                              
        mov ax,0002h
        int 10h                    
                                   
                                   
                                   
                                      
        mov cx,ilgis ;nustatomas ciklo skaitliukas                 
        mov ax,0 ;nunulinamas ax registras
        ciklas: ;ciklo zime        
         mov al,eilute[si] ;i al ikeleme reiksme su adresu si           
         push ax ;i steka ikelema ax reiksme
         inc si ;padidinama vienetu si reiksme
        loop ciklas ;ciklo grizimas i pradzia kol cx nelygu 0
                                                             
                                                             
        mov cx,ilgis-1 ;ciklo skaitliukas nustatomas apversti zodziui
        pop bx ;i bx ikelemas $ simbolis
        ;mov ax,0      
                                                             
        ciklas2:                                             
         pop ax  ;istraukiama is steko informacija                                            
                                                             
         mov apv[si],al ;i atminti yrasoma al reiksme                                     
         add si,1       ;padidinamas si vienetu                                     
        loop ciklas2 ;griztama i ciklo pradzia kol cx ne 0
        mov apv[si],bl ;i priskirtos atminties gala irasomas $ simbolis                                      
        ;spausdina pradini simboliu rinkini                                                               
        mov ah,09h                                                     
        lea dx,eilute                                                  
        int 21h                                                        
                                                                       
        ;spausdina apversta simboliu rinkini                                   
        mov ah,09h                          
        lea dx,apv                          
        int 21h                             
        ;laukia knopkes paspaudimo                                    
        mov ah,07h                          
        int 21h                             
        ;baigia programa                                    
       mov ax,4c00h                         
       int 21h                              
 programa ends                              
end start