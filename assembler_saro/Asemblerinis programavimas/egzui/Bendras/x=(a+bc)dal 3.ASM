;Steko segmentas     
stekas    segment stack             
          db 256 dup(0)             
stekas    ends          
                        
cr equ 13               
lf equ 10                    
                                                                  
;Duomenu  segmentas                                               
duomenys  segment                                                 
       info db ' Viktorija Briskmanaite, II-04/4 ',cr,lf
            db ' Prad.duomenys:a=4,b=2,c=1',cr,lf
            db ' Formule: (a+b*c)/3',cr,lf,'$'
     pran_1 db '   -> gautas rezultatas! ','$'
     blogai db cr,lf,'Dalyba is nulio negalima','$'
          a db 4                   
          b db 2                   
          c db 1  
        des dw 10                                  
   tarpinis db 0                                   
     dalyba db 3                   
        rez db 0,'$'                               
duomenys  ends                                     
                                                   
;Programos segmentas                                              
programa  segment                                  
          assume cs:programa, ds:duomenys, ss:stekas
                                                   
rezultatas proc                                    
        mov cx, 0                                  
push_sk:                                           
        mov dx, 0                                  
        div des                                    
        add dx, 30h                                
        push dx                                    
        inc cx                                     
        cmp ax, 0                                  
        jne push_sk                                
pop_sk:                                            
        mov ah, 09h                                
        pop dx                                     
        mov rez, dl                                
        lea dx, rez                                
        int 21h                                    
        loop pop_sk                                               
        ret                                        
rezultatas endp                                    
                                                   
skaiciai proc
        push ax
        mov ah, 09h
        int 21h
        pop ax
        ret
skaiciai endp
             
start:    mov ax, duomenys                         
          mov ds, ax                               
                                                   
       	  mov ax, 0002h                            
      	  int 10h                                  
;------------------------------------------------------               	                                   
          mov al, a                                        
          mov tarpinis, al                                 
          mov al, b               
          mul c                                            
          add al, tarpinis        
          div dalyba              
          mov rez, al
                                                          
;Pranesimu ir rezultato spausdinimas                                          
         lea dx, info                                          
         call skaiciai
         call rezultatas
         lea dx, pran_1                                   
             
         mov ah, 09h
         int 21h                                    
                                                          
         mov ah, 07h
         int 21h
                                                   
         mov ah, 4ch
         int 21h
programa  ends                                     
          end start            	                   
