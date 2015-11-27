;STEKO SEGMENTAS.
stek segment stack
        db 256 dup (?)
stek ends        

;DUOMENU SEGMENTAS                      
data segment      
        desimt dd 10
        simtas dd 100   
        pradzia dw 1627         ;Pradzia
        prad_suma dq 24.0       ;Pradine suma
        daugiklis dq 1.03       ;Palukanos
        baksai dd (?)                              
        centai dd (?)                              
        isvedimui dd (?)                           
        filtras1 dw (?)         ;Apvalinimo filtras
        filtras2 dw (?)                            
                     
        cr equ 13       ;"Enter" simbolius           
        lf equ 10       ;"Grazinimas i eilutes pradzia"
                     
        msg db 'Kursinis darbas: Nikolaj Goranin, II-0/4 /Asm.prg-as./',cr,lf,cr,lf
            db 'Uzduotis (4.0) : Indenu uzdavinys nuo 1627 iki 2003m..',cr,lf
            db cr,lf,cr,lf,'$'                       
                                    
        Atsakymas db 'Rezultatas     :'             
        saskaita db 7 dup (' '),',   doleriu.',13,10,'$'
                                                   
data ends            
                     
;PROGRAMOS SEGMENTAS.                                                   
code segment
        assume cs:code, ds:data, ss:stek
startas:  mov ax,data
        mov ds,ax                  
                                   
        ;Ekrano valymas                                
        mov ax, 0600h                                  
        mov bh, 07                                     
        mov cx, 0000h                                  
        mov dx, 184Fh                                  
        int 10h                                        
                                   
        ;Informacijos apie autoriu ir uzduoti isvedimas
        mov ah,09h                                 
        lea dx,msg                 
        int 21h                                    
                     
        ;------Programa-----                               
        mov cx,2003    
        sub cx,pradzia  ;Kiek metu praejo.
                                          
        finit           ;Initializuojamas coprocesorius
        fld prad_suma   ;Uzkraunam i steka pradine suma
        ;Filtru nustatymas                     
        fstcw filtras1                    
        mov ax,filtras1                   
        and ax,1111000011111111b          
        or  ax,0000011100000000b   ;mantises ilgis: 64 bitai (24,53,64)
;                  apti
        mov filtras2,ax            

for_1:     
        fmul daugiklis             
loop for_1 
                                   
        fldcw filtras2                           
                          
        fist baksai                
        fisub baksai               
        fimul simtas                      
        fistp centai
;--------Isvedimas--------------     
        mov cx,7                   
        mov si,6                   
        mov bl,10              
for_2:              
        fild baksai              
        fidiv desimt           
        fistp isvedimui 
        fild isvedimui         
        fimul desimt           
        fistp isvedimui 
        fild baksai     
        fisub isvedimui        
        fistp isvedimui        
                mov al,byte ptr isvedimui                          
                add al,30h             
                mov saskaita[si],al    
                dec si                       
        fild baksai            
        fidiv desimt           
        fist baksai            
loop for_2                        
                    
        mov al,byte ptr centai
        mov ah,0                       
        div bl                 
        add al,30h                     
        add ah,30h                     
        mov word ptr saskaita[8],ax

        mov ah,09h                                        
        lea dx,atsakymas                                 
        int 21h                                          
                                                         
        ;Programos darbo nutraukimas
        mov ah,4Ch
        int 21h                        
code ends  
end startas