stekas SEGMENT STACK           
        DB 256 dup(?)          
stekas ENDS                    
                               
data SEGMENT                   
   pran	db 'Namu drabas',10,13
        db 'darba atliko:IIV-4 studentes ',10,13
        db 'Uzduoties nr.: 3',10,13              
        db 13,10, 'UZDUOTIS: Programa papraso vartotoja ivesti masyva' 
        db  ' ir isveda to masyvo',10,13,' eilutes atvirkscia tvarka',10,13,13,13,10,'$'                                                         
    txt db 200,?,200 dup(' '),'$'                          
    raide db 1 dup(),'$'
    newline db 10,13,'$'                        
    ivesk db 'Iveskite masyva,eilutes atskirdami zvaigzdutemis(*): ','$'
    pran1 db 'Tekstas nebuvo ivestas. Prasau ivesti teksta',13,10
    db 'ir nepamirskite masyvo eiluciu atskirti zvaigzdute(*)',13,10,'$'                                              
    eilnr db 20                                                   
                                                                  
data ENDS                                                         
                                                                  
programa SEGMENT                                                  
        ASSUME DS: data, CS: programa, SS: stekas                 
START:                                                            
                                                                  
        MOV AX,DATA                                                                                                                             
        MOV DS,AX                                                                                                                               
        ;isvalom ekrana                                                                                                                                        
        MOV AX,0002H                                                                                                                            
        INT 10H                                                                                                                                                                                        
        ;Pranesimu spausdinimas                                                                                                                 
        MOV AH,09H                                                                                                                              
        LEA DX,pran                                                                                                                             
        INT 21H  
                                                                                                                                                        
        ;Iveskite teksta                                          
        LEA DX,ivesk                                              
        INT 21H  
       pradzia:                                                                                                                                
         mov ah,09h
         lea dx,newline
         int 21h                                                  
        ;teksto ivedimas                                          
        MOV AH,0Ah                                                
        LEA DX,txt                                                
        INT 21h 
        ;kursoriaus nustatymas
         mov ah,02h                                               
         mov bh,0                                                 
         mov dh,eilnr ;eilute                                            
         mov dl,30  ;stulpelis                                              
         int 10h                                                  
                                                                  
         lea si,txt+2                                             
        mov cl,txt+1
        
        mov ah,[si]
        cmp ah,13
        je klaida
                                                                               
cik:                                                              
        mov ah,[si]                                               
        ;;;--------------TIKRINAM AR ZVAIGZDUTE ---------------
        cmp ah, '*'
           je zvgzd
           jne rasykraide
        jmp toliau       
                         
zvgzd:                   
                                
        dec eilnr        
        push ax          
        push dx          
                         
         mov ah,02h      
         mov bh,0        
         mov dh,eilnr    
         mov dl,30       
         int 10h         
                         
        pop dx          
        pop ax          
                         
toliau:                  
                         
               jmp toliau2
rasykraide:        
         mov raide, ah   
                         
        MOV AH,09h        
        LEA dx,raide ;isveda po viena raide    
        INT 21h  
  
                
toliau2:                                                               
         inc si          
         loop cik       
                        
         mov ah,02h     
         mov bh,0       
         mov dh,21      
         mov dl,0       
         int 10h        
         JMP PABAIGA  
         
         klaida:
         mov ax,0002h
         int 10h
         mov ah,09h
         lea dx,pran1
         int 21h 
         jmp pradzia                                                                                            
     pabaiga:                                            
                                                    
        MOV AH,07H                                  
        INT 21H                     
        MOV AH,4CH                  
        INT 21H                     
programa ENDS                       
END START
