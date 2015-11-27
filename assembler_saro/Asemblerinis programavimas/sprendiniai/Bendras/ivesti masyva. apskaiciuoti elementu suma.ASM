;*** steko segmentas ***    
stekas segment stack                                            
        db 256 dup (?)      
stekas ends                                          
;*** duomenu segmentas ***        
duomenys segment                  
        a db 10                   
        pran db 'Iveskite masyvo elementus: ','$'
        atsakymas db 10,13,'Atsakymas: ','$'
        mas db 10 dup (?)         
        ats db 4 dup (?),'$'
duomenys ends                                                            
;*** programos segmentas ***      
programa segment                                                         
        assume cs:programa, ds:duomenys, ss:stekas                                                                         
start:                                                                   
        mov ax,duomenys                                                  
        mov ds,ax                                 
;*** ekrano valymas ***           
        mov ax,02h                              
    	  int 10h                                        
;*** ekrano valymas baigtas ***                      
        mov ah,09h                                   
        mov dx,offset pran   ;pirmu dvieju raidziu adresa i dx                        
        int 21h                                               
        mov si,1             ;si=1                                 
        xor ax,ax                                 
        xor bx,bx              
        CALL masyvas               
        xor ax,ax                               
        mov al,bl           
        mov ats,0000h        ;ats=0000h                           
        jmp desimtaine        
masyvas:                                     
        mov ah,01h                           
        int 21h                              
        cmp al,0dh                          
        je suma                                          
        cmp al,20h                                             
        je masyvas           
        mov mas[si],al       ;ivesta simboli i masyva mas
        inc si                                        
        cmp si,10                               
        jg suma              ;jei daugiau, pereinu prie zymes suma               
        jmp masyvas          ;kartoju ivedimo cikla                                     
suma:                                              
        sub mas[si-1],30h    ; i sesioliktaine sistema     
        add bl,mas[si-1]     ;sudedu simboli su bl (rezultatas i bl)                                        
        dec si               ;sumazinu si vienetu                      
        cmp si,1             ;lyginu si su 1                    
        je return            ;jei lygu, pereinu prie zymes return               
        jmp suma             ;kartoju sumavimo cikla                                    
return:                                             
        ret                  ;grazinu funkcijos reiksme                       
desimtaine:                                            
        div a                ;dalinu al is a (a=10)
        add ah,30h           ;pervedu simboli i desimtaine sistema        
        mov ats[si],ah       ;ikeliu simboli i ats
        dec si               ;sumazinu si vienetu                       
        xor ah,ah            ;ah=0                       
        cmp al,0             ;lyginu al su 0                       
        je isvedimas         ;jei lygu, pereinu prie zymes isvedimas                       
        jmp desimtaine       ;kartoju pervedimo cikla                                       
isvedimas:                                           
        mov ah,09h                                   
        mov dx,offset atsakymas                      
        int 21h                                      
        mov dx,offset ats                            
        int 21h                                                    
exit:                         
;laukia klaviso paspaudimo     
          mov ah, 07h                         
          int 21h                                                
        mov ax,4c00h                          
        int 21h                               
programa ends                                            
end start                                     
                          