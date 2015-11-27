stekas segment stack                 
       	db 256 dup (?)               
stekas ends                          
                                     
duomenys segment                     
       tekstas  db 'Kursinio darbo uzduotis Nr.I.22',10,13   
                db 'Atliko: Nerijus Gervys, II-2/6',10,13,'$'
       duok_sk  db 13,10,'Iveskite skaiciu (ne didesni uz 255): $'
  rezultatas    db 13,10,'Sesioliktainis: $'
       pakartot db 13,10,'Kartoti? (y/n)$'
        r_A     db 1 dup('0A$')
        r_B     db 1 dup('0B$')
        r_C     db 1 dup('0C$')
        r_D     db 1 dup('0D$')
        r_E     db 1 dup('0E$')
        r_F     db 1 dup('0F$')
        sixteen db 16 ,'$'                              
        ten     db 10 ,'$'          
        ats     db 3 dup(0),'$'
        temp    db 0         
        sk      db 0
duomenys ends                         
                                      
programa segment                     
   assume cs:programa, ds:duomenys, ss:stekas
                                     
start: 	mov ax,duomenys        
       	mov ds,ax                                       
pradzia:       	
       	mov ax, 0002h          
        int 10h                       

        mov ah, 09h               
        lea dx, tekstas        
        int 21h 
        mov ah, 09h               
        lea dx, duok_sk        
        int 21h                            
;ivedimas
        call ivedimas            
        mov sk, bl             
        call pagrindine
;ar kartoti 
        mov ah, 09h               
        lea dx, pakartot        
        int 21h
        mov ah,08h
        int 21h
        cmp al, 6Eh ; n
        je  pab
        cmp al, 79h ; y
        je  pradzia
pab:                                                 
 	mov ah, 4ch            
  	int 21h                
  	
ivedimas proc                                                   
        mov bl, 0
        mov di, 0              
iv_prad:                              
        mov ah, 08h ;klava            
        int 21h                        
                               
        cmp al, 13             
        je iv_pab              
        cmp al, '0'            
        jb iv_prad           
        cmp al, '9'            
        ja iv_prad           
        
        mov ah,02h ;parodo 1 skaiciu ekrane
        mov dl,al
        int 21h
                              
        sub al, 30h            
        mov temp, al           
        mov al, bl             
        mul ten             
        add al, temp           
        mov bl, al             
                                           
        xor al, al
        inc di
        cmp di,3
        je  viskas            
        jmp iv_prad
viskas:
        mov ah, 08h ;klava            
        int 21h                                              
        cmp al, 13             
        jne viskas           
iv_pab:                       
        ret                    
ivedimas endp                               

pagrindine proc           
        xor ax,ax     
        mov al, sk
                     
        div sixteen
        
        cmp al, 10
        je  sv_A
        cmp al, 11
        je  sv_B
        cmp al, 12
        je  sv_C
        cmp al, 13
        je  sv_D
        cmp al, 14
        je  sv_E
        cmp al, 15
        je  sv_F
        
        add al, 30h
        mov ats[1],al
toliau:        
        cmp ah, 10
        je liek_A
        cmp ah, 11
        je liek_B
        cmp ah, 12
        je liek_C
        cmp ah, 13
        je liek_D
        cmp ah, 14
        je liek_E
        cmp ah, 15
        je liek_F
        
        add ah, 30h
        mov ats[2],ah                       

rez:    mov ah, 09h            
        lea dx, rezultatas     
        int 21h                     
        mov ah, 09h            
        lea dx, ats          
        int 21h
        ret                
sv_A:
        mov al, r_A[1]
        mov ats[1], al 
        jmp toliau
sv_B:
        mov al, r_B[1]
        mov ats[1], al 
        jmp toliau                
sv_C:
        mov al, r_C[1]
        mov ats[1], al 
        jmp toliau
sv_D:
        mov al, r_D[1]
        mov ats[1], al 
        jmp toliau
sv_E:
        mov al, r_E[1]
        mov ats[1], al 
        jmp toliau
sv_F:
        mov al, r_F[1]
        mov ats[1], al 
        jmp toliau
liek_A: 
        mov al, r_A[1]
        mov ats[2], al 
        jmp rez
liek_B: 
        mov al, r_B[1]
        mov ats[2], al 
        jmp rez                   
liek_C: 
        mov al, r_C[1]
        mov ats[2], al 
        jmp rez
liek_D: 
        mov al, r_D[1]
        mov ats[2], al 
        jmp rez
liek_E: 
        mov al, r_E[1]
        mov ats[2], al 
        jmp rez
liek_F: 
        mov al, r_F[1]
        mov ats[2], al 
        jmp rez        
pagrindine endp
                                                                                          
programa ends                   
end start                       
