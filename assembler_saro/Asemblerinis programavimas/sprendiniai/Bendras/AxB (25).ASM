stekas segment stack                 
       	db 256 dup (?)               
stekas ends                          
                                     
duomenys segment                     
        a1  db 'Iveskite a: $'
        b1  db 10,13,'Iveskite b: $'
        rezultatas    db 10,13,'Rezultatas a*b: $'
        temp    db 0         
        a       db 0          
        b       db 0                     
        ten     db 10 ,'$'          
        c     db 4 dup(0),'$'
duomenys ends                         
                                      
programa segment                     
   assume cs:programa, ds:duomenys, ss:stekas
                                     
start: 	mov ax,duomenys        
       	mov ds,ax                                       
       	
       	mov ax, 0002h          
        int 10h                
;ivedimas a        
        mov ah, 09h               
        lea dx, a1        
        int 21h                              
        call ivedimas            
        mov  a, bl         
;ivedimas b                               
        mov ah, 09h               
        lea dx, b1        
        int 21h                                              
        call ivedimas            
        mov  b, bl         
;rezultato a*b isvedimas            
        call isvedimas         
;pabaiga                      
        mov ah, 07h            
        int 21h                                             
 	mov ah, 4ch            
  	int 21h                

ivedimas proc                                                   
        mov bl, 0              
iv_prad:                     
        mov ah, 08h            
        int 21h                
                               
        cmp al, 13             
        je iv_pab              
        cmp al, '0'            
        jb iv_prad           
        cmp al, '9'            
        ja iv_prad           
                               
        mov ah,02h             
        mov dl,al              
        int 21h                
                               
        sub al, 30h            
        mov temp, al           
        mov al, bl             
        mul ten             
        add al, temp           
        mov bl, al             
                                                  
        xor al, al             
        jmp iv_prad          
iv_pab:                       
        ret                    
ivedimas endp                               
;***************************
isvedimas proc
        ;a*b skaiciavimas           
        mov al, a ;byte ptr a 
        mul b ;byte ptr b    
                     
        mov ah, 0                          
        mov si, 3                                             
ciklas:
        div ten             
        add ah, 30h            
        mov c[si], ah      
        dec si                 
        mov ah, 0              
        cmp si,0
        je  klaida
        cmp al, 0              
        je  klaida            
        jmp ciklas
klaida:                         
        mov ah, 09h            
        lea dx, rezultatas     
        int 21h                     
        mov ah, 09h            
        lea dx, c          
        int 21h                
        ret                    
isvedimas endp
                                                                                          
programa ends                   
end start                       
