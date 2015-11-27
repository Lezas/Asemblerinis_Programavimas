;komentarai 
;steko segmentas          
stekas segment stack      
        db 256 dup(?)     
stekas ends               
                          
;duomenu segmentas        
duom segment                        
        pran1 db 'Darba atliko :Zigmas Losunovas II-1/4 gr.',13,10,10,'$'
        pran2 db 'Programa sudaugina 2 skaic ivestus is klaviaturos',13,10,'$'
        ivesk_a db 'iveskite a',13,10,'$'
        ivesk_b db 'iveskite b',13,10,'$'
        rezultatas db 'rezultatas :',13,10,'$'
        ivskab db 4,?,4 dup(?),13,10,'$'                    
        a db 0,13,10,'$'                                            
        b db 0,13,10,'$'
        rezas dw 0
       des db 10                                         
       des1 dw 10                                        
       count dw 0                                         
                
duom ends                           
;----------programos segmentas--------              
programa  segment                                   
        assume cs:programa, ds:duom, ss:stekas
                                                    
start:  mov ax,duom                           
        mov ds,ax                                 
;ekrano valymas                                     
   	mov ax,0002h                              
   	int 10h 
;kursoriaus pozicionavimas  
          mov ah,02         
          mov bh,0          
          mov dh,3         
          mov dl,20
          int 10h                 
;pranesimo 1 isvedimas             
        mov ah,09h                 
        lea dx,pran1               
        int 21h   
;laukia klaviso paspaudimo                          
        mov ah, 07h                               
        int 21h   
;ekrano valymas                                     
       	mov ax,0002h                              
       	int 10h                     
;kursoriaus pozicionavimas  
          mov ah,02         
          mov bh,0          
          mov dh,5         
          mov dl,2
          int 10h 
;pranesimo 2 isvedimas             
        mov ah,09h                 
        lea dx,pran2               
        int 21h   
        ;kursoriaus pozicionavimas  
          mov ah,02         
          mov bh,0          
          mov dh,7         
          mov dl,0
          int 10h                                                          
;ivesk_a isvedimas
        mov ah,09h                                
        lea dx,ivesk_a                            
        int 21h                                      
;skaiciaus a ivedimas naudojant buferi
        lea dx,ivskab                   
        mov ah,0ah                    
        int 21h                    
        add dx,2                   
        mov bx,dx    ;adreso naudojimui per registra
        mov dl,[bx]                                 
        sub dl,30h        
        mov a,dl  ;pirmas skaicius
        mov cl,ivskab+1   
        dec cl                     
        mov ch,0                                    
;tikrinam ar skaicius nera vienzenklis
        mov ah,0                   
        cmp cx,0                   
        je enda                    
;jei skaicius ne vienzenklis vykdom si cikla
        ciklasa:                            
        inc bx                     
        mov dl,[bx]                
        sub dl,30h                 
        mov al,a                   
        mul des           
        add al,dl                                      
        mov a,al                   
        loop ciklasa               
enda:                              
;kursoriaus pozicionavimas  
          mov ah,02         
          mov bh,0          
          mov dh,9         
          mov dl,0
          int 10h 
;ivesk_b isvedimas             
        mov ah,09h                 
        lea dx,ivesk_b         
        int 21h                    
;skaiciaus b ivedimas naudojant buferi
        lea dx,ivskab                   
        mov ah,0ah                    
        int 21h                    
        add dx,2                   
        mov bx,dx    ;adreso naudojimui per registra
        mov dl,[bx]                                 
        sub dl,30h                                  
        mov b,dl  ;pirmas skaicius              
        mov cl,ivskab+1        
        dec cl                 
        mov ch,0               
;tikrinam ar skaicius nera vienzenklis
        mov ah,0               
        cmp cx,0               
        je endb                
;jei skaicius ne vienzenklis vykdom si cikla
        ciklasb:                            
        inc bx                             
        mov dl,[bx]                        
        sub dl,30h                         
        mov al,b                           
        mul des                            
        add al,dl                          
        mov b,al                           
        loop ciklasb                       
endb:                  
;skaiciavimas            
        mov al,a         
        mul b   
        mov rezas,ax
                       
;kursoriaus pozicionavimas  
          mov ah,02         
          mov bh,0          
          mov dh,11         
          mov dl,0    
          int 10h     
;pranesimo rezultatas isvedimas   
        mov ah,09h       
        lea dx,rezultatas     
        int 21h          
;rezultato apdorojimas   
        mov ax,0         
        mov dx,0         
        mov bx,0         
        ciklas:          
        mov bx,rezas     
        mov ax,bx          
        cmp ax,0           
        je isvedimas       
        div des1               
        mov rezas,ax       
        add dl,30h         
        push dx            
        mov dx,0           
        inc count          
        jmp ciklas         
                           
isvedimas:                 
        mov cx,count       
        mov ah,02h         
        ciklas1:           
        pop dx             
        int 21h            
        loop ciklas1       

                           
;laukia klaviso paspaudimo
        mov ah, 07h                               
        int 21h          
                                                    
;-grizhta i DOS                                     
        mov ah, 4ch                                
        int 21h          
                                 
programa  ends                 
          end start    