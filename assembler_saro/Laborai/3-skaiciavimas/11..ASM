                                                  
stekas segment stack                                                     
        db 256 dup (?)                                                   
stekas ends                                                              
                                                                         
eol equ 10,13
                                                                         
duomenys segment                                                               
        pran1 db 'Agne Katkute II-2/1   Laboratorinis darbas Nr.3',eol,"$"
        pran0 db 'Atsakymas, kai a=6, b=7 ir c=3:',eol,"$"
        pran2 db 'a*b+c= ',"$"
        pran3 db 'Programa baigta. Spauskite bet koki klavisa.$'
        a db 6                                                          
        b db 7
        c db 3                  
        y db 3 dup (?),eol,"$"
        desimt db 10          
duomenys ends                 
                              
programa segment              
assume cs:programa, ds:duomenys, ss:stekas
start:                                                
        mov AX, duomenys      
        mov DS, AX            
        
        mov AX, 0002h     
        int 10h           
                                                 
        mov AH, 09h           
        lea DX, pran1     
        int 21h
        
        mov ah,09h
        lea dx,pran0
        int 21h           
                     
        xor AX, AX
        mov AL, a
        Mul  b
        add AL, c
                                                              
        mov SI, 1
        ciklas:       
                div desimt
                add AH, 30h
                mov y[SI], AH
                dec SI
                xor AH, AH
                cmp AL, 0                                                     
                je pabaiga
        loop ciklas

pabaiga: 
        mov AH, 02h
        mov BH, 00h       
        mov DH, 03
        mov DL, 01  
        int 10h 
                          
        mov AH, 09h        
        lea DX, pran2     
        int 21h            
        lea DX, y          
        int 21h  
                                
        mov AH, 02h       
        mov BH, 00h       
        mov DH, 15
        mov DL, 01
        int 10h           
                           
        mov AH, 09h       
        lea DX, pran3     
        int 21h                                                               
                           
        mov AH, 08h    
        int 21h            
        
        mov AH, 4Ch        
        int 21h            
programa ends              
end start