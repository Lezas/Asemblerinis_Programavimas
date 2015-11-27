stekas segment STACK           
	db 256 dup(?)          
stekas	ENDS                   
                               
duom segment                
pran	db 'egzaminas',10,13
        db '10 baitu is OA lasteliu kuriu adreas uzrasytas si',10,13 
        db  ' persiusti i OA kuriu adresas di',10,13,'$'
duom ENDS                                                  
                                                                
programa SEGMENT                                           
     	ASSUME  SS:stekas, DS:duom, CS: programa           
START:  MOV AX,Duom    	                                        
     	MOV DS,AX                                               
                                                                
        
        MOV AX,0002h                                            
        INT 10h    
                                                     
mov ah,09h                
lea dx,pran
int 21h          


      mov si, 15    

      mov di, 35  


mov cx,10  

push di   

ciklas: 
mov bl,[si]  
mov [di],bl  
inc si
inc di
loop ciklas            

mov al,'$'       



mov [di],al
pop di          

MOV AH,09H             
mov  DX,di     

INT 21H  
    
 MOV AH,07H                                  
 INT 21H              
 MOV AH,4CH           
 INT 21H         

 


     
programa ENDS     
END START

       