;Var. II nr 14
;kursinis darbas papraso varotoja ivesti simboliu eilute ir isveda zodi "taip"
;jei sia eilute skaitant atvirksciai , gauname tapacia eilute,priesingu atveju 
;isveda zodi ne
stekas segment stack                                             
        db 256 dup (2)         
stekas ends                                            
                                                                 
duomenys segment               
        vardas db 'Atliko Saulius Masiulis II-2/2, kursinis var. II nr. 14' , 13,10,'$'
        sk1 db 30,?,30 dup (?),'$'
        iv1 db ' Iveskite siboli eilute:',13,10,'$'
        iv4 db 13,10, 'Atsakymas: $'                                    
        lygu1 db 'taip','$'                                             
        nelygu1 db 'ne','$'                                             
duomenys ends
                                                                        
programa segment                                                        
assume cs:programa,ds:duomenys,ss:stekas                                
                                                                        
start:                                                                  
                                                                        
mov ax,duomenys                                                         
mov ds,ax                                                               
                                                                        
mov ax,0002h ;isvalo ekrana                    
int 10h                                        
mov ah,09h                                     
lea dx,vardas                                  
int 21h                                        
                     
lea dx,iv1           
int 21h                                        
;nuskaitom zodi                                
mov ax,0                                       
mov ah,0Ah                                     
lea dx,sk1                                     
int 21h                                        
;kursorias perkelimas          
          mov ah,02                  
          mov bh,00                  
          mov dh,5             
          mov dl,6             
          int 10h              
                               
 mov cl,sk1+1        
 mov di,1            
                     
;kusroriaus perkelimas
          mov ah,02                  
          mov bh,00                  
          mov dh,5
          mov dl,20
          int 10h    
   mov ah,09h
   lea dx,iv4
   int 21h
   mov cl,sk1[1]
   mov di,1
   ciklas3:    
   inc di 
   loop ciklas3               
          
                     
   mov cl,sk1[1]     
   mov si,2
   mov al,0          
 ciklas2:            
  mov al,sk1+di      
  cmp sk1+si,al      
  jne nelygu         
  inc si  
  dec di  
                   
  mov al,0           
loop ciklas2         
                     
                     
                     
                                  
  lygu:                           
    mov ah,09h       
    lea dx,lygu1                      
    int 21h                           
    jmp pabaiga                       
 nelygu:                               
     mov ah,09h      
     lea dx, nelygu1 
     int 21h         
                                          
                                          
pabaiga:  
 mov ah,07h
 int 21h
                                          
mov ah,4ch                            
int 21h                               
                                      
programa ends         
end start