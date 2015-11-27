stekas segment stack 
        db 256 dup(?)
stekas ends           
duomenys segment      
      vardas db 20 dup(' '),'$'
     masyvas db "vectas"
     radom_s db "Simboli radome masyve!$"   
   neradom_s db "Simbolis nerastas masyve!$"
duomenys ends                               
programa segment                            
assume ss:stekas, ds:duomenys, cs:programa  
start:                                      
                                            
mov ax,duomenys                             
mov ds,ax                                   
                                            
mov ax,0002h                                
int 10h                                     
                                            
;ivedimas is klaviaturos                    
mov ah,3fh                
mov bx,0                  
mov cx,20                 
lea dx,vardas             
int 21h                   
                          
;i al reiksme sumetam nulini masyvo vardas elementa (pirma raide)
mov al, vardas[0]         
                          
;kintamojo vardas isvedimas
comment * mov dl,al       
mov ah,02h                
int 21h  *                

mov cx,6
 lyginam:                 
    mov si,cx           
    cmp al,masyvas[si-1]
    je radom        
    push ax         
    pop ax                
 loop lyginam             
;isvedimas neradom     
mov ah,09           
lea dx,neradom_s    
int 21h             
jmp pabaiga         
                    
radom:       
mov dl,al    
mov ah,09       
lea dx,radom_s
int 21h      
             
pabaiga:     
;press enter            
mov ah, 07h             
int 21h    

;isejimas i dos'a (windows:)
mov ah,4ch
int 21h
         
programa ends
end start