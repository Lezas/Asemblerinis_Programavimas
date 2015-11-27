stekas segment stack
        db 256 dup (?)                 
        stekas ends 
        duomenys segment
          
    INFO  DB 10,13                  
       DB '     **************************************************',10,13
       DB '     * Kursinis darbas ',10,13
       DB '     * Uzduotis: Isvesti skaiciaus skaitmenu vidurki  ',10,13
       DB '     * Atliko: Darius Okunevicius II-2/6',10,13
       DB '     **************************************************',10,13,'$'
MyOutputString  DB 10, 13,'Iveskite skaiciu: ','$',10,13                          
MyOutputString_ DB 10, 13, '$' 
MyOutputString2 DB 'Ivesto skaiciaus skaitmenu vidurkis: ','$'                    
MyStringOfError DB 'Blogai ivestas skaicius. Prasom ivesti dar karta: ','$'
MystringOfFinish DB 10,13,10,13,'->Programos pabaiga','$'
SKAICIUS DB 255                            
    DB 255 DUP (?)                         
    SUMA DW 0                              
    LIEKANA DB ?                           
    DAL DB 10                              
    duomenys ends                          
programa segment                           
       assume cs:programa, ds:duomenys, ss:stekas 
start:                                     
        mov ax,duomenys                    
        mov ds,ax                          
        MOV AX, 0                          
        MOV AX, 0002h                      
        INT 10h                            
                                           
        MOV AH, 09h                        
        LEA DX, info                           
        INT 21h                                 
                                           
        MOV AH, 09h                            
        LEA DX, MyOutputString                            
        INT 21h                                  
PRADZIA:                                    
        MOV AH, 0Ah                           
        LEA DX, SKAICIUS                   
        INT 21h                                                  
                                           
        MOV AH, 09h                                               
        LEA DX, MyOutputString_                                              
        INT 21h                                                              
        XOR CH, CH                         
        MOV CL, SKAICIUS+1           
                                                
        MOV SI,2                                  
CIKLAS: XOR BH, BH                        
        MOV BL, SKAICIUS[SI]                 
        SUB BL, 30h
                                
        CMP BL, 9          
        JA KLAIDA
                                  
        ADD SUMA, BX                         
        INC SI    
        LOOP CIKLAS
                                                                                MOV AH, 09h        ;Isvedu cia, nes paskui man reikia registro ax

        LEA DX, MyOutputString2                          
        INT 21h                             
        MOV AX, SUMA
                 
        DIV SKAICIUS+1              
        MOV LIEKANA,AH
        ADD AL, 30h         
               
        MOV DL, AL                           
        MOV AH, 02h                            
        INT 21h                                
        MOV DL, ','           
        MOV AH, 02h                             
        INT 21h
                                         
        MOV AL, LIEKANA                       
        MOV CX, 4         
CIKLAS2:                                                                                                  
        MUL DAL                              
        DIV SKAICIUS+1      
        MOV LIEKANA, AH
                                          
        ADD AL, 30h                        
        MOV DL, AL                                                                  
        MOV AH, 02h                         
        INT 21h
        
                                   
        MOV AL, LIEKANA                   
                                          
        CMP AL, 0                         
        JE  PABAIGA                         
        LOOP CIKLAS2                      
PABAIGA:       
               
        MOV AH, 09h                            
        LEA DX, MyStringOfFinish                            
        INT 21h
                                  
        MOV AH, 07h                       
        INT 21h                             
        MOV AX, 4C00h                         
        INT 21h                              
KLAIDA:                                   
        MOV AH, 09H                           
        LEA DX, MyStringOfError                         
        INT 21h                               
        MOV SUMA, 0                           
        JMP PRADZIA                              
programa ends                              
        end start                         