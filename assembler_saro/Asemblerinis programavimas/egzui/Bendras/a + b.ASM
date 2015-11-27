stekas segment stack                
        db 256 dup(0)                 
stekas ends                         
cr equ 13              
lf equ 10              
                                             
duomenys  segment                            
                                     
        tekstas1 db 'Programos autorius: ','$'
        tekstas2 db 'Programa sudare: ','$'
        tekstas3 db 'II-1/5','$' 
        tekstas4 db 'Skaiciuosime lygti x=a+b:','$'
        tekstas5 db 'Iveskite a = ','$'              
        tekstas6 db 'Iveskite b = ','$'              
        tekstas7 db 'Atsakymas: x = ','$'            
        autorius db 20 dup('*'),'$'               
        ivesk db 5,?,5 dup('*'),'$'
        desimt dw 10
        file db 'C:\Tasm\Temp\rezultatai.txt',0
        spausdinti db 10 dup('*'),'$' 
        a dw 0,'$'  
        b dw 0,'$'  
        rez dw 6,?,6 dup('*'),'$'
                     
duomenys  ends                                         
assume cs:programa, ds:duomenys, ss:stekas                                                       
                                                       
programa  segment                                      
                                                       
start:    mov ax,duomenys                              
          mov ds,ax                               
;ekrano valymas                                   
  	  mov ax,02h                              
  	  int 10h  

        MOV AX,3C00h		;sukuriamas rezultatu failas
	MOV CX,0000h                     
	LEA DX,file
	INT 21h

			
	MOV AX,3D02h		;atidarom si faila
	LEA DX,file
	MOV CL,00h
	INT 21h

	MOV DI,AX		;o jo identifikatoriu dedam i DI                                
;kursoriaus pozicijos nustatymas                            
         ; mov ah,02h                              
         ; mov dh,00                               
         ; mov dl,00                               
         ; int 10h                                 
;pirmojo teksto isvedimas        
          mov ah,09h                              
          lea dx,tekstas1                            
          int 21h                                 
;autorius ivedimas is klaviaturos           
          mov ah,0Ah                              
          lea dx,autorius                         
          int 21h                                 
;autoriaus isvedimas i ekrana                               
          mov ax,02h                              
 	  int 10h                                 
;zymeklio pozicijos nustatymas                                                  
         ; mov ah,02h                              
        ;  mov dh,01                               
        ;  mov dl,20                               
       ;   int 10h                                 
                                                  
          mov ah,09h                              
          lea dx,tekstas2                            
          int 21h                                 
                                                  
          mov dl,'$'                              
          mov cl,autorius+1                       
          lea bx,autorius                         
          add cl,2                                
          add bl,cl                               
          mov [bx],dl                             
                                                  
          mov ah,09h                              
          lea dx,autorius+2                       
          int 21h                                 
                                                  
          mov ah,02h                              
          mov dh,01                               
          mov dl,38                               
          add dl,autorius+1                       
          int 10h                                 
                                                  
          mov ah,09h                              
          lea dx,tekstas3                            
          int 21h                                 
;zymeklio pozicijos nustatymas
          mov ah,02h
          mov dh,03
          mov dl,00
          int 10h             
;lygties isvedimas i ekrana                            
          mov ah,09h        
          lea dx,tekstas4      
          int 21h           
;zymeklio pozicijos nustatymas
          mov ah,02h          
          mov dh,05           
          mov dl,00           
          int 10h                  
;penktojo teksto isvedimas i ekrana                              
          mov ah,09h               
          lea dx,tekstas5          
          int 21h             
;kintamojo a ivedimas                             
          mov ah,0Ah          
          lea dx,ivesk      
          int 21h 
;kintamojo a apdorojimas
          sub ivesk+2,30h                 
          mov bh,0                        
          mov bl,ivesk+2                  
          mov a,bx                        
                                          
          mov ch,0                        
          mov cl,ivesk+1                         
          dec cl              
                              
          cmp cl,0            
          JE baigti_a              
                                  
          lea bx,ivesk+3                    
          ciklas_a:               
          mov ax,a                
          mul desimt               
          sub BYTE PTR[bx],30h    
          mov dh,0                
          mov dl,[bx]             
          add dx,ax     
          mov a,dx      
          inc bx                  
          loop ciklas_a           
          baigti_a:         
;zymeklio pozicijos nustatymas
          mov ah,02h          
          mov dh,06           
          mov dl,00           
          int 10h                  
;sestojo teksto isvedimas i ekrana                              
          mov ah,09h              
          lea dx,tekstas6         
          int 21h                 
;kintamojo b ivedimas is klaviaturos                                  
          mov ah,0Ah                
          lea dx,ivesk              
          int 21h                   
;kintamojo reikiamas apdorojimas                                    
          sub ivesk+2,30h         
          mov bh,0                
          mov bl,ivesk+2          
          mov b,bx                
                                
          mov ch,0              
          mov cl,ivesk+1                         
          dec cl                
                                
          cmp cl,0              
          JE baigti_b              
                                  
          lea bx,ivesk+3                    
          ciklas_b:             
          mov ax,b              
          mul desimt               
          sub BYTE PTR[bx],30h    
          mov dh,0                
          mov dl,[bx]             
          add dx,ax     
          mov b,dx      
          inc bx                  
          loop ciklas_b 
          baigti_b:     
;skaiciavimas pagal formule                      
          mov ax,a      
          mov bx,b          
          add ax,bx     
          mov rez,ax    
                        
          mov bx,0000   
;zymeklio pozicijos nustatymas                        
          mov ah,02h          
          mov dh,08           
          mov dl,00           
          int 10h                                
;septintojo teksto isvedimas i ekrana
          mov ah,09h                 
          lea dx,tekstas7            
          int 21h                    
;rezultato paruosimas spausdinimui                                     
          mov ax,rez              
          lea bx,spausdinti+9     
          mov cx,0010             
          spausdinimo_ruosimas:   
          cmp ax,0000                            
          JE nutraukti_ruosima
          mov dx,0000                                           
          div desimt                             
          add dl,30h              
          mov [bx],dl             
          dec bx                                                           
          loop spausdinimo_ruosimas              
;rezultato isvedimas i ekrana                                                 
          nutraukti_ruosima:       
          lea bx,spausdinti       
          sub bl,cl
          mov ah,09h               
          lea dx,[bx]             
          int 21h  


       MOV AX,4000h		;irasom i fail
        MOV BX,DI
        MOV CX,7
        LEA DX,[bx]
        INT 21h

        
;laukia klaviso paspaudimo         
          mov ah,07h               
          int 21h            
;grizhta i DOS               
          mov ah,4ch                         
          int 21h                            
programa  ends                               
end start