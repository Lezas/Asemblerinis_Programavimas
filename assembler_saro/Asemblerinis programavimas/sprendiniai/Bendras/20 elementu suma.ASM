;---------steko segmentas---------           
stekas    segment stack                      
          db 256 dup(0)                      
stekas    ends                               
cr        equ 13                             
lf        equ 10                             
                                             
;----duomenu  segmentas---------             
duomenys  segment                            
pran1  db 'Darbas nr10. Atliko II-1/4 Rimas Bulvydas',cr,lf
       db 'Iveskite 20 elementu masyva', cr, lf, '$'
pran2  db 'Atsakymas:',cr,lf,'$'
                                                     
mas db 21,?,20 dup (0)
rez db 3 dup ('*'), '$'
t db 10
des db 10
                                                                        
duomenys  ends                                         
                                                       
;----------programos segmentas--------                 
programa  segment                            
          assume cs:programa, ds:duomenys, ss:stekas
                                             
start:    mov ax,duomenys                    
          mov ds,ax                          
;ekrano valymas                              
 	  mov ax,0002h
 	  int 10h
                	
;praneshimo ishvedimas       
          mov ah, 09h        
          lea dx, pran1      
          int 21h
;masyvas
          mov ah, 0ah
          lea dx, mas
          int 21h
          call matrica



;atsakymas
          isved:
          mov t,20
          mov ah, 09h  
          lea dx, pran2
          int 21h     
          mov ah, 09h
          mov dx, bx
          int 21h
          call matrica
                                 
;grizhta i DOS
          mov ah, 07h
          int 21h
          mov ah,4ch                         
          int 21h 
       
; funkcijos:
        matrica:
        mov cx, 0
        mov si, 1
          lea bx,mas
          xor ax,ax
          ciklas:
          add ax, [bx]
          inc bx
          add cx, si
   
          cmp cx, 
          je ciklas2
          loop ciklas

   ciklas2:
          lea bx, rez+3
          mov ah 09h
          div des
          add ah, 30h
          dec bx
          mov [bx],ah
          cmp al,0
          jg ciklas2
          ret
              
programa  ends                               
          end start                          
