stekas segment stack                  
       	db 256 dup (?)                
stekas ends                                  
                                             
duom segment    
        pran  db 10,13,'Emilis Uldukis II-0/2',13,10
                db 'Skaiciuosime reiskini c=a*a+2b',13,10,'$'    
        pran1 db 10,13, 'Iveskite a:','$'
        pran2 db 10,13, 'Iveskite b:','$'
        pran3 db 10,13,10,13, 'Atsakymas:','$'
        ats db 7 dup(?),10,13,'$'         
        tarp db 7 dup(?),10,13,'$'  
        sveikas db (?),10,13,'$'                          
        s dw ?,10,13,'$'                  
        a db ?,10,13,'$'                  
        b db ?,10,13,'$'                  
        d db 2,'$'                        
        dal dw 10,'$'                     
duom ends                                 
                                             
kodas segment                             
 assume cs:kodas, ds:duom, ss:stekas      
                                             
start:                                       
       	mov ax,duom                       
        mov ds,ax                         
        mov di,1
        mov si,0
        ; Isvalymas                       
        mov ax,0600h                      
       	mov cx, 0000h                     
	mov dx, 184fh                     
	mov bh, 07h                       
     	int 10h                           
       	; Kursorius                       
       	mov bh, 00                        
        mov dh, 00                        
        mov dl, 00                        
        mov ah, 02h                       
        int 10h                           
                                          
        mov ah,09h                           
        lea dx,pran                       
        int 21h                              
        lea dx, pran1                        
        int 21h                              
        call ivedimas                        
        mov a,al                             
                                             
        mov ah,09h                           
        lea dx,pran2                         
        int 21h                              
        call ivedimas                        
        mov b,al                             
                                             
                                             
        mov al,a                          
        mul a                             
        mov s,ax                          
        xor ax,ax                         
        mov al,b                             
        mul d                                
        add ax,s                          
                                                           
  skaicius:                                                    
        div dal                                              
        add dl, 30h                       
        mov tarp[di], dl                  
        inc di                            
        mov dx, 0                         
        cmp ax, 0                         
        je isv                            
        jmp skaicius                      
                                          
   isv:                                   
        mov ah,tarp[di]                   
        mov ats[si],ah                    
        dec di      
        inc si      
        cmp di,0
        je isvedimas  
        jmp isv       
                                          
 isvedimas:                               
      mov ah,09h                          
      lea dx,pran3                        
      int 21h                     
      lea dx,ats                  
      int 21h                     
                                  
      mov ah,4ch                  
      int 21h                     
                                  
                                  
 ivedimas proc far                           
        mov si,0                                              
                                             
pradzia:                                               
        mov ah,08h
        int 21h                                               
        cmp al,13
        je pabaiga                       
        cmp al,30h                       
        jb pradzia                       
        cmp al,39h     
        ja pradzia                                                                              
        mov dl,al  ;isveda i ekrana tai ka rasai
        mov ah,02h                                                         
        int 21h                                                            
                                                                     
        sub al,30h                                                         
        mov sveikas[si],al                      
        inc si                                                             
        jmp pradzia                                                        
pabaiga:                                  
        mov cx,si                         
        sub cx,1                          
        mov al,sveikas[0]                 
        mov dx,00h                        
        mov bx,00h                        
        mov ah,00h                        
        mov si,00h                        
        cmp cx,0                          
        je galas
ciklas:          ;is atskiru skaitmenu darom viena     
        mul dal                           
        mov bl,sveikas[si+1]  
        add al,bl                                      
        inc si                                         
loop ciklas                                            
galas:
  ret                                           
ivedimas endp                              
                            
                      
                                       
kodas ends                               
end start                                
           