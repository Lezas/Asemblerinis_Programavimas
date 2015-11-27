
stekas segment stack           
        db 256 dup(0)           
        stekas ends             
                                
 duomenys segment               
        tekstas1 db 'iveskite pirma skaiciu:',10,13,'$'
        tekstas2 db 'iveskite antra skaiciu:',10,13,'$'
        skaicius1 db 3,?,3 dup(0),10,13,'$' 
        file2	db 'C:\TASM\TEMP\rezult.txt',0 
        pran db 'rezas:',10,13 ,'$'             
        sk1 db 0,'$'                                   
        sk2 db 0,'$'
        ats db 0,'$'
        sveik db 0,'$'
        liek db 0,'$'                                   
 duomenys ends                                         
                                                       
 programa segment                                      
 assume cs:programa,ds:duomenys,ss:stekas              
   valyti proc
     mov ax,02h                                            
     int 10h 
     ret 
   valyti endp 
   
 keitimas macro skaicius1, sk1
 mov al,skaicius1+2                    
 sub al,30h                           
 mul cl                               
 mov ah,skaicius1+3                    
 sub ah,30h                           
 add al,ah                            
 mov sk1,al
 endm
 
 nusk proc
 mov ah,0ah                             
 lea dx,skaicius1                            
 int 21h 
 ret
 nusk endp
                                                               
 start:                                                
 mov ax,duomenys                                       
 mov ds,ax                                             
                                                       
  call valyti  

        MOV AX,3C00h		;sukuriamas rezultatu failas
	MOV CX,0000h                     
	LEA DX,file2
	INT 21h

			
	MOV AX,3D02h		;atidarom si faila
	LEA DX,file2
	MOV CL,00h
	INT 21h

	MOV DI,AX		;o jo identifikatoriu dedam i DI                                    
                                                       
                                      
 mov ah,09h                                            
 lea dx,tekstas1                                        
 int 21h                                               
                  
 call nusk
 keitimas skaicius1, sk1
 call valyti                

 mov ah,09h   
 lea dx,tekstas2
 int 21h 
      
 call nusk
 keitimas skaicius1, sk2                                     
  call valyti                                                
    mov cl,10              
    mov al,sk1                       
    sub al,sk2                       
    mov ats,al
    mov ah,0                       
                                  
 ;dalyba isvedimui
 div cl           
 add al,30h       
 mov sveik,al
 add ah,30h 
 mov liek,ah
                                        
 ;isvedame atsakyma
 mov ah,09h
 lea dx,pran
 int 21h
                
 mov ah,09h
 lea dx,sveik     
 int 21h         
 mov ah,09h
 lea dx,liek
 int 21h
          mov ax,4000h
          mov bx,di
          mov cx,6
          lea dx,pran
          int 21h

       MOV AX,4000h		;irasom i fail
        MOV BX,DI
        MOV CX,1
        LEA DX,sveik
        INT 21h

        MOV AX,4000h		;irasom i faila liekana
        MOV BX,DI
        MOV CX,1
        LEA DX,liek
        INT 21h
              
                          
 mov ah,07h               
 int 21h                             
                                     
 mov ah,4ch                          


int 21h               
                       
 programa ends
 end start

