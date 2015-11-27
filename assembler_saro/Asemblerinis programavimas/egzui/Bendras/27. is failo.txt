;---------steko segmentas---------  
stekas    segment stack             
          db 256 dup(0)             
stekas    ends                      
                                                    
;----duomenu  segmentas---------                    
duomenys  segment

klaida       db 'Ivyko klaida','$'                       
errtxt1      db 'Nepavyko atidaryti failo skaitymui. Klaidos kodas $'
errtxt2      db 'Nepavyko nuskaityti failo. Klaidos kodas $'
kldkodas     dw 0, '$'                                   
failas1      db 'C:\tasm\temp\Duomenys.txt',0            
failbuf      db 256 DUP(' ')                             
faildesk     dw 0                                        
simbolsk     dw 0                                        
duomenys ends

;----------programos segmentas--------                   
programa  segment                                        
          assume cs:programa, ds:duomenys, ss:stekas     
                                                         
start:    mov ax,duomenys                                
          mov ds,ax                                      
              
;ekrano valymas                                          
        mov ax,0002h                                     
        int 10h                                          
                                                         
;Failo skaitymas                                         
        lea dx, failas1                                  
        call failoatidarymas                             
        call failonuskaitymas                            
        mov di, simbolsk                                 
        mov failbuf[di+2], '$'                           
        mov failbuf[di+1], 13                            
        mov failbuf[di], 10                              
        lea dx, failbuf                                  
        mov ah, 09h                                                   
    	int 21h
               
	jmp dos                                                            
               
  ; Failo atidarymo paprograme
  FailoAtidarymas proc        
    mov ah, 3Dh               
    mov al, 2            
    int 21h                                            
    jc AtidarKlaida                                    
    mov faildesk, ax        
    jmp AtidarPab                                   
                                                                                                              
  AtidarKlaida:                                        
    add ax, 30h                                        
    mov kldkodas, ax                                   
    lea dx, errtxt1                                    
    call Isvedimas                                     
    lea dx, kldkodas                                   
    call Isvedimas                                     
    jmp dos    
                              
  AtidarPab:                  
    ret                       
  FailoAtidarymas endp        
                              
                              
  ; Failo nuskaitymo paprograme                                   
  FailoNuskaitymas proc       
    mov ax, 0                 
    mov ah, 3Fh                                        
    mov bx, faildesk        
    mov cx, 50                                         
    lea dx, FailBuf                                    
    int 21h                                            
    jc NuskKlaida             
    jmp NuskPab                                              
                              
  NuskKlaida:                                          
    add ax, 30h                                        
    mov KldKodas, ax                                   
    lea dx, ErrTxt2                                    
    call Isvedimas                                     
    lea dx, KldKodas                                   
    call Isvedimas                                     
    jmp dos                                        
                                                       
  NuskPab:                    
    mov SimbolSk, ax          
    mov ax, 0                 
    mov ah, 3Eh                                        
    mov bx, faildesk                           
    int 21h                                   
    ret                                                
  FailoNuskaitymas endp   
               
  Isvedimas proc                                                  
    mov ah, 09h                                                   
    int 21h                                                       
    ret                                                           
  Isvedimas endp     
               
;programos pabaiga
dos:           
        mov ah, 07h
        int 21h    
pabaiga:              
          mov ah,4ch           
          int 21h              
programa  ends                 
          end start   