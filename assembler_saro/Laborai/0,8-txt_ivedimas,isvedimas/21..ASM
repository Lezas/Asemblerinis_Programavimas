STEK SEGMENT STACK           
        DB 256 DUP(?)        
STEK ENDS                    
                             
DUOMENYS SEGMENT 
        PRAN  DB 'ATLIKO: TOMAS ALEKSANDRAVICIUS II-2/6',13,10,'$'          
        PRAN1 DB 'IVESKITE SIMBOLIU EILUTE  : $'
        PRAN2 DB 13,10, 'PAKEISTOS SIMBOLIU EILUTES DIDZIOSIOS RAIDES: $'
        PRAN3 DB 13,10, 'PAKEISTOS SIMBOLIU EILUTES MAZOSIOS RAIDES: $'
          TXT DB 30,?,30 DUP(?),'$'
          DID DB 30 DUP(?),'$'
          MAZ DB 30 DUP(?),'$'
DUOMENYS ENDS                      
                                     
PROGRAMA SEGMENT                   
        ASSUME DS: DUOMENYS, CS: PROGRAMA, SS:STEK
                                   
START:                             
        MOV AX, DUOMENYS           
        MOV DS, AX            
                                   
        MOV AX, 0002H ;ekrano isvalymas            
        INT 10H                        
                                       
                                   
        MOV AH, 09H                
        LEA DX, PRAN               
        INT 21H                    
                                            
        LEA DX, PRAN1              
        INT 21H                    
                                   
        MOV AH, 0AH                
        LEA DX, TXT                
        INT 21H                    
                                   
        MOV AH, 00                 
        MOV AL, TXT+1              
        MOV SI, 2                  
        ADD SI, AX                                  
        MOV TXT[SI], '$'                  
	MOV CX, AX                 
                                   
        MOV SI, 2             
        MOV BP, 0             
        MOV DI, 0 
        CIKLAS:
DIDZIOSIOS:
                                   
	CMP TXT[SI], 64            
	JG DAUG                    
	JMP CIKLASEND
DAUG:                
	CMP TXT[SI], 91
	JL DIDZIOJI    
	JMP MAZOSIOS
DIDZIOJI:            
        MOV AL, TXT[SI]
	MOV DID[BP], AL
	INC BP
	JMP CIKLASEND
MAZOSIOS:
	CMP TXT[SI], 96
	JG DAUG1     
	JMP CIKLASEND
DAUG1:           
	CMP TXT[SI], 123
	JL MAZOJI1   
	JMP CIKLASEND
MAZOJI1:
        MOV AL, TXT[SI]
	MOV MAZ[DI], AL
	INC DI
	CIKLASEND:
	INC SI
        LOOP CIKLAS                 
                                   
PAB:                            
        
        MOV AH, 09H
        LEA DX, PRAN2
        INT 21H
        LEA DX, DID
        INT 21H  
        
        LEA DX, PRAN3
        INT 21H
        LEA DX, MAZ
        INT 21H                   
                                     
        MOV AH, 4CH          
        INT 21H              
PROGRAMA ENDS                
END START                    
