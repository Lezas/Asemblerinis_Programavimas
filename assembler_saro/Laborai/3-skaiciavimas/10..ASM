;       y=a+b+c
                                                     
stekas segment stack                                                     
        db 256 dup (?)                                                   
stekas ends                                                              
                                                                         
eil equ 10,13,'$'
                                                                         
duomenys segment                                                               
        pran1 db 'Agne Katkute II-2/1   Laboratorinis darbas Nr.2',10,13
              db 'ATSAKYMAS, kai a=5, b=6, c=3',eil
        pran2 db 'a+b+c=$'
        pran3 db 'Programos pabaiga. Spauskite bet koki klavisa.$'
        a db 5                                                          
        b db 6
        c db 3                  
        y db 3 dup (?),eil
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
                     
        xor AX, AX
        MOV AL, a
        add AL, b
        add AL, c
                                                              
       mov SI, 2
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
        mov AH, 09h
        lea DX, pran2     
        int 21h            
        lea DX, y          
        int 21h  
        
        mov AH, 02h 
        mov BH, 00h   
        mov CX, 0000h 
        mov DX, 0c12h
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