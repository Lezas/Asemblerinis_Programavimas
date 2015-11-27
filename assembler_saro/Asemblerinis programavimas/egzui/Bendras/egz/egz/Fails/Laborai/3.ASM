Stekas SEGMENT STACK                       
        DB 255 DUP(?)                      
Stekas ENDS                                
                                           
Duomenys SEGMENT
   pran0   db 'Masyvo vidurkio radimas', '$'
   pran1   db 10,13,'Atliko Valerija Lialina II-3/3','$'
   pran2   db 10,13,'Rasti masyvo vidurki:','$'
   pran3   db 10,13, '9,6,6,6,6,6,6,6,6,9,2,3,6,4,6,3,9,4,7,9,8,6,6,6,5,6,3,2,6,6','$'
   masyvas db 9,6,5,6,7,6,6,6,6,9,2,3,6,4,6,3,9,4,7,9,8,6,6,6,5,6,3,2,6,6,'$'
   suma    db ?,'$'                    
   vid     db ?,'$'
   sk      db ?,'$'
   klaida  db 'ivyko perpildymas','$'
   vidurk  db 10, 13,'Masyvo vidurkis: ', '$'
   ten     db 10
   tmp     db 0, '$'
                                             
Duomenys ENDS                                
                                             
prg SEGMENT                                  
        ASSUME SS:Stekas,DS:Duomenys,CS:prg  
START:                                       
        mov ax, Duomenys                     
	mov ds, ax                           
                                             
	mov ax, 02h ;isvalom ekrana          
	int 10h                              
        
        mov ah, 09h
        lea dx, pran0
        int 21h
              
        mov ah, 09h
        lea dx, pran1
        int 21h      
                     
        mov ah, 09h
        lea dx, pran2
        int 21h       
        mov ah, 09h
        lea dx, pran3
        int 21h
                                                 
	xor ax, ax                           
	xor bx, bx                           
	lea si, masyvas                      
skaic:                                                  
	mov al,[si]     ;pasiimame masyvo kita skaitmeni
	cmp al,'$'      ;ar nepabaiga
	je skaicVid                       
                                   
	add bl, al                 
	jc perkrova    	;flagas
	inc sk                     
	inc si                     
	jmp skaic                  
                                        
skaicVid:                          
        mov ax, 0
	mov suma, bl     ;issaugome suma
	mov al, suma                                  
	div sk           ;daliname ax is sk           
	mov vid, al      ;svieka dali kopijuojame i vid
                   
	jmp Exit              
perkrova:          
        mov ah, 09h 
        lea dx, klaida
        int 21h  
                                     
Exit:                                
	mov ah,09h	;spausdinimas
	lea dx, vidurk  
	int 21h 
	        
         xor bx, bx                        
         mov bl, vid
         xor ax, ax               
        ;skaiciaus isvedimas                          
         cmp bx, 100    ;lyginu su 100
         jb desimtys           
         mov ax, 0
         mov ax, bx
         mov bx, 100
         div ten  
         mov bh, 0  
         mov vid, ah
         add al, 30h    
         mov tmp, al    
         lea dx, tmp    
         mov ah,09h        
         int 21h        
         mov ax, 10     
desimtys:              
         cmp ax, 10     
         je netikr      
         cmp vid, 10        
         jb vienetai    
netikr:                       
         mov al, vid        
         mov ah, 0    
         div ten        
         mov bh, 0         
         mov vid,0
         mov vid, ah
         mov tmp, al    
         add tmp, 30h   
         mov ah,09h 
         lea dx, tmp
         int 21h    
vienetai:                                         
         add vid, 30h
         mov ah,09h
         lea dx, vid
         int 21h
                          
	mov ah, 07h   ;uzlaiko ekrana
	int 21h       
	                                      
	mov ah, 4ch    
   	int 21h       
                  
prg ends
end start