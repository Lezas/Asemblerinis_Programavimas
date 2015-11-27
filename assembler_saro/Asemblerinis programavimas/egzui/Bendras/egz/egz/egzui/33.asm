stekas segment stack                
db 256 dup(0)                     
stekas ends                       
cr equ 13                         
lf equ 10                         
                                                           
duomenys segment                                             
pran1 db '              Atliko: Tomas Karnisauskas II-2/3 grupe ',cr,lf     
      db '              Programa vykdo replace operacija' ,cr,lf
      db '                              2 KURSINIS',cr,lf
      db '           **********************************************',cr,lf,'$'
pran2 db '',cr,lf
      db 'Iveskite eilute1:',cr,lf,'$' 

pran3 db '',cr,lf 
      db 'iveskite eilute2:',cr,lf,'$'

pran4 db '',cr,lf  
      db 'iveskite eilute3:',cr,lf,'$'
      
pran5 db '',cr,lf 
      db '',cr,lf   
      db 'pakeistas tekstas',cr,lf
      db '--------------------',cr,lf,'$'
     
pran6 db '',cr,lf
      db '',cr,lf      
      db '          Noredami baigti, spauskite bet kuri klavisa...',cr,lf,'$' 
klaida db '',cr,lf
       db '      Klaida!!! Iveskite vienoda eiluciu skaiciu....',cr,lf,'$'  
a db 15,?,15 dup (?),'$'
b db 15,?,15 dup (?),'$'                                   
c db 15,?,15 dup (?),'$' 
rez db 15 dup (?),'$'  
                                
duomenys ends                                      
                                                   
                                                   
programa segment                                   
        assume cs:programa, ds:duomenys, ss:stekas 
        start:                                     
               mov ax, duomenys                    
               mov ds, ax                          
 ;       -Ekrano valymas-
    		 mov ax, 0002h     
       		 int 10h                                        
  
; pranesimo isvedimas             
		mov ah,09h                          
               lea dx,pran1                     
               int 21h                                                                                             
; zodzio ivedimas    
                mov ah,09h                          
               lea dx,pran2                     
               int 21h                                                   
               mov ah,0ah 
               lea dx,a                        
               int 21h                             
                
                mov cl,a+1 ; parodo kiek simboliu ivedem
        
      pradzia1: mov ah,09h                          
               lea dx,pran3                     
               int 21h       
               mov ah,0ah 
               lea dx,b                        
               int 21h
               
               cmp b[1],cl
               jne eroras1
                            
              
     pradzia2: mov ah,09h                          
               lea dx,pran4                     
               int 21h       
               mov ah,0ah 
               lea dx,c                        
               int 21h
              
              cmp c[1],cl
               jne eroras2
              
              call sukeitimas              		
;  zodzio isvedimas                                                  
               mov ah,09h                          
               lea dx,pran5
               int 21h                             
                                          
               mov ah,09h                          
               lea dx,rez
               int 21h	
                                                     
               mov ah,09h                          
               lea dx,pran6
               int 21h
               
               mov ah, 07h                     
               int 21h                   
                                                                                                             
               mov ah,4ch                
               int 21h                   
             eroras1: mov ah,09h
                lea dx, klaida
                int 21h
                jmp pradzia1
              eroras2: mov ah,09h
                lea dx, klaida
                int 21h
                jmp pradzia2 
                
                sukeitimas proc
                mov si,2                                                                                                                                                                                                                                 
		ciklas:    
		mov al,a[si]
		mov rez[si-2],al
		mov bl,b[si]
		cmp al,bl   
		jne exit         
	        mov ah,c[si]
	        mov rez[si-2],ah                                                     
                exit: inc si
                loop ciklas
                sukeitimas endp
                ret                        
               programa ends             
               end start         

