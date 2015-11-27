Stekas SEGMENT STACK                    
        DB 255 DUP(?)                   
Stekas ENDS                             
                                        
Duomenys SEGMENT                        
         PRANESIMAS dB 'Egzaminas, uzduotis nr.16',13,10
                    dB 'Atliko: Paulius Urbanavicius is II-2/4',13,10,'$'
            MASYVAS dB 1,2,3,4,5,6,7,8,1,1,5,-5,-5,-5,-5,-5,-5,-5,-5,-5,'$'
	       TEIG dB 'stulpelio vidurkis:',13,10,'$'
                  a dw 0,'$'
                      
Duomenys ENDS                           
                                        
programa segment                        
assume ss:stekas,ds:duomenys,cs:programa
start: 	mov ax,duomenys                 
      	mov ds,ax                       
                                        
MOV SI,-1               
                                        
MOV ah,09h                              
lea dx,pranesimas                       
int 21h                                 
                                        
CIKLAS:                                 
inc SI                              
cmp masyvas[si],'$'                     
je pab                                                                   
      	CMP MASYVAS[SI],0                                                
        JL ciklas                                                        
       	inc a  	   	                                                 
    	                
jmp CIKLAS                                                               
                                                                         
pab:                                                                     
;ADD a,30H                                                                
                                                                         
MOV ah,09h                                                               
lea dx,TEIG                                                              
int 21h                                                                  
                                                                         
MOV ah,09h                                                               
lea dx,a                                                                 
int 21h                                                                  
                                                                         
MOV Ah,07h                                                               
int 21h                                                                  
mov ah,4ch                                                               
int 21h                                                                  
                                                                         
Programa ENDS                                                            
END START