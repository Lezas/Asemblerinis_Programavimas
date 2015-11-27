stekas segment stack                             
       db 256 dup(0)                 
                   
       ends stekas                               
                                                 
duomenys segment                            
       pran db 'Septinta programa Tadas Padvilikis',13,10,'$'     
       mas db 1,2,3,4,5,9,9,9,9,'$'      
       kiekpran db 'masyvo elementu sk yra 9',13,10,'$'
       liek db 'vidurkio sveikoji dalis yra',13,10,'$'
       sveik db 'vidurkio liekana yra',13,10,'$' 
       tarp db '',13,10,'$'                                         
       sumapran db 'masyvo suma:',13,10,'$'           
       vidurkispran db 'masyvo  vidurkis:',13,10,'$'       
           suma db 3 dup (?),'$'
       vidurkis db 3 dup (?),'$'  
             sk db 3 dup (?),13,10,'$'
            sk1 db 2 dup (?),'$'
           sk11 db (?),'$' 
            des db 10,'$'  
       kab db ',','$'        
        duomenys ends                                       
                                                      
programa segment                                      
         assume ds:duomenys,ss:stekas,cs:programa     
start:  mov ax,duomenys                                
        mov ds,ax                                                            
                        
        lea si,mas                         
        mov ax,0000                               
        mov cx,9        
                                           
        ciklas:                                        
        mov al,[si]     
        add si,1             
        add suma,al                        
        loop ciklas                      
                  
                  
                mov al,suma
	        mov ah,0
	        mov bl,9
	        div bl
	        add ah,30h  
                mov sk11,ah        
                mov ah,0 
                div des  
                add ah,30h
                mov sk1+1,ah
                mov ah,0
                div des
                add ah,30h
                mov sk1,ah
                mov ah,0 
                
                                       
                mov cx,0   
                mov al,suma
                mov ah,0
                MOV BL,10               
		DIV BL                  
		ADD ah,30h              
		MOv sk+2,ah 
		mov ah,0              
		div bl                 
		ADD AH,30h              
		MOV sk+1,AH            
	        mov ah,0
	        div bl  
	        mov ah,30h
	        mov sk,ah
	        mov ah,0        
	        mov al,0 	         
	         
	   
                            
        mov ah,09h                    
        lea dx,pran               
        int 21h                            
        mov ah,09h      
        lea dx,sumapran 
        int 21h         
        mov ah,09h                
        lea dx,sk                  
        int 21h       
        mov ah,09h      
        lea dx,vidurkispran 
        int 21h  
        mov ah,09h      
        lea dx,sk1
        int 21h
        mov ah,09h
        lea dx,kab
        int 21h
        mov ah,09h 
        lea dx,sk11
        int 21h
        mov ah,09h
        lea dx,tarp
        int 21h
        mov ah,09h
        lea dx,kiekpran
        int 21h
         mov ah,09h
        lea dx,liek
        int 21h
        
           mov ah,09h
        lea dx,sk1
        int 21h
mov ah,09h
        lea dx,tarp
        int 21h
                mov ah,09h
        lea dx,sveik
        int 21h    
            mov ah,09h
        lea dx,sk11
        int 21h                                                                                                                                                                                           
        mov ah,4ch            
        int 21h               
programa ends              
end start