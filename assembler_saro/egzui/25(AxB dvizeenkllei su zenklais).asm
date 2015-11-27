;Ingos Jakeliunaites II-5/5


stekas SEGMENT STACK
      DB 256 DUP(?)
stekas ENDS    
 
duom SEGMENT    
   des DB 10   
   pirmas DB 0 
   IVSR DB 4,?,4 DUP(' ')
   pran DB 'Iveskite skaiciu:',10,13,'$'  
   klpr DB 'Klaida!',10,13,'$'  
   ats DB 'Rezultatas c=a*b=   ',10,13,'$'
   duom ENDS    

prog SEGMENT    
   assume ss:stekas, ds:duom, cs: prog 

  start:                 
     MOV AX, duom      
     MOV DS, AX  
 
     CALL ivedimas  
     CALL konvert 
     MOV pirmas, AL

     CALL ivedimas   
     CALL konvert 
             
     MOV AH, 0   
     MUL AL
             
     DIV des    
     Add AH, 30h
     MOV ats+20, AH
     MOV AH, 0     
     DIV des   
     Add AH, 30h
     Add AL, 30h
     MOV ats+18, AL
     MOV ats+19, AH         
                
     MOV AX,0002 
     INT 10h 
        
     MOV AH, 09h      
     LEA DX, ats       
     INT 21h  
     
     MOV ah, 07h
     INT 21h  
      
     MOV AH, 4Ch     
     INT 21h 
      
ivedimas PROC   
     MOV AX,0002
     INT 10h    
     MOV AH,09h 
     LEA DX,pran
     INT 21h    
     MOV AH, 0Ah   
     LEA DX, IVSR  
     INT 21h    
     RET        
ivedimas ENDP    
                
konvert PROC     
     SUB AX, AX   
     SUB CX, CX         
     MOV CL, IVSR+1  
   
     CMP CL, 0       
     JE Nulis   
    
     LEA SI, IVSR+2    
     MOV BH, [SI]  
     CMP BH, '0'
     JL klaida  

     CMP BH, '9'   
     JG klaida  
 
     SUB BH, 30h    
     MOV AL, BH   
     DEC CL       
     CMP CL, 0      
     JE proc_pab 
    
     ciklas:         
          INC SI       
          MOV BH,[SI]   
          CMP BH, '0' 
          JL klaida  
 
          CMP BH, '9'   
          JG klaida  
  
          SUB BH, 30h    
          MUL des  
          JO klaida
                   
          Add AL, BH
          JO klaida      
          JMP isejimas
           
 
     nulis:    
          MOV AL, 0
          MOV AH, 09h
          LEA DX, nulis
          INT 21h
          JMP proc_pab
              
     klaida:   
          MOV AH, 09h
          LEA DX, klpr
          INT 21h
          MOV AL, 00
          JMP proc_pab
              
     isejimas: 
          LOOP ciklas
          RET     

     proc_pab:    
          RET        
          
konvert ENDP   
          
prog ENDS  
END start