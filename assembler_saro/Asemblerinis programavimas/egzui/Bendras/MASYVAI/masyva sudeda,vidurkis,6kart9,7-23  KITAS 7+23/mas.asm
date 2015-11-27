stekas segment stack                                                     
        db 265 dup (?)                                                   
stekas ends                                                              
                                                                         
cr equ 13                    
lf equ 10                    
                                                                        
duomenys segment                                                               
               
      helloworld db 'K.makrickas, M.Gudelionis', cr, lf
                 db ' ',cr, lf,'$'
                          
      atsakymas  db 'Elementu suma - ','$'
                                        
      vidurkis db 'Vidurkis - ','$'     
                                        
      kablelis   db ',','$'             
                                        
      pran1   db ' ',cr,lf              
              db '6*9 = ', '$'
      pran2   db ' ',cr,lf              
              db '7-23 = - ','$'
                                        
                                                               
      masyvas db 1,100,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,5,4,1,cr,lf
      y db 5 dup (?),cr, lf, '$'
                               
      dal dw 10, '$'                  
      suma dw ?, '$'           
                               
      tmp2 db 25, '$'          
      tmp1 db 10, '$'          
      tmp3 db 100, '$'         
                               
      sveikas db ?,'$'         
      liekana db ?,'$'         
      sandauga db ?,'$'        
                               
      skirtumas db ?, '$'      
                               
duomenys ends                  
                               
programa segment               
assume cs:programa, ds:duomenys, ss:stekas
                               
start:                                                
        mov ax, duomenys       
        mov ds, ax        
                          
                    
        mov ax, 0002h     
        int 10h           
                          
                    
        mov ah, 09h       
        lea dx, helloworld       
        int 21h                                     
        
        lea bx, masyvas
        mov ax, 0   
        mov dx, 0       
        mov dl, [bx]
   
   call pentium     
                    
        mov si, 4                   
        mov dx, 0                    
    des:             
        div dal     
        add dl, 30h 
        mov y[si], dl
        dec si      
        mov dx, 0   
        cmp ax, 0   
        jne des                                       
                    
        mov ah, 09h                            
        lea dx, atsakymas                          
        int 21h                                
        lea dx, y                              
        int 21h                                
           
mov ax, suma        
div tmp2   
               
      	mov bx,ax		                
   	mov ah, 09h     
	lea dx, vidurkis  
	int 21h         
                        
	mov ax,0        
     	mov al,bl              
	div tmp1          
	mov bl,ah       
	add al,30h      
                        
	mov sveikas, al 
	mov ah, 09h     
	lea dx, sveikas 
	int 21h         
	                
	add bl,30h      
	mov sveikas, bl 
	mov ah, 09h     
	lea dx, sveikas 
	int 21h         
                        
	mov ah, 09h     
	lea dx, kablelis
	int 21h         
                        
	mov ax,0               
                        
	mov al,bh       
	div tmp1        
	mov bl,ah       
	add al,30h      
                        
	mov liekana, al 
	mov ah, 09h     
	lea dx, liekana 
	int 21h         
	                
	add bl,30h      
	mov liekana, bl 
                        
	mov ah, 09h     
	lea dx, liekana 
	int 21h         
                        
	mov ah, 09h            
	lea dx, pran1   
	int 21h         
	                
	mov al, masyvas[5]
	mul masyvas[8]  
                        
	div tmp3        
	mov bh,ah       
	                
	add al,30h      
	mov sandauga,al 
	mov ah, 09h     
	lea dx, sandauga
	int 21h         
	                
	mov ax,0        
	mov al,bh       
	div tmp1        
	mov bh,ah              
                        
	add al,30h      
	mov sandauga,al 
	mov ah, 09h     
	lea dx, sandauga
	int 21h         
                        
	add bh,30h      
	mov sandauga,bh 
	mov ah, 09h     
	lea dx, sandauga
	int 21h                                    
                        
	mov ah, 09h     
	lea dx, pran2   
	int 21h         
        mov ax, 0       
        mov bx, 0       
                        
                               
	mov al,masyvas[6]
	sub al,masyvas[22] 
	js pranx        
	div tmp1        
	mov bh,ah       
                        
	add al,30h      
	mov skirtumas,al
	mov ah, 09h     
	lea dx, skirtumas
	int 21h          
                         
	add bh,30h       
	mov skirtumas,bh         
	mov ah, 09h      
	lea dx, skirtumas        
	int 21h          
       jmp toliau                  
                        
 pranx:                 
	mov ax, 0       
        mov bx, 0       
	mov al,masyvas[22]
	sub al,masyvas[6]
	div tmp1        
	mov bh,ah       
                        
	add al,30h      
	mov skirtumas,al
	mov ah, 09h     
	lea dx, skirtumas
	int 21h          
                         
	add bh,30h       
	mov skirtumas,bh         
	mov ah, 09h      
	lea dx, skirtumas        
	int 21h                
toliau:	                                          
        mov ah, 02h                            
        mov bh, 00h                            
        mov cx, 0000h                          
        mov dx, 0C12h 
        int 10h                                
                                                                                              
        mov ah, 07h                            
        int 21h                                
        mov ah, 4ch                            
        int 21h                               
 
 pentium proc 
  ciklas:       
        add ax, dx             
        inc bx     
        mov dl, [bx]
        cmp dl, 0Dh
        jne ciklas
        mov suma, ax
       ret
      pentium  endp 
  
               
programa ends      
end start                                      
                                               
