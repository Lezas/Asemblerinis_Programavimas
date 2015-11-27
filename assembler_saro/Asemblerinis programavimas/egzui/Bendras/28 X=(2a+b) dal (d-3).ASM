 stekas segment stack
        db 256 dup (?) 
stekas ends            
                       
cr      equ 13         
lf      equ 10         
                       
duomenys segment       
pran1   db 'Si programa skaiciuoja reiskinio X=(2a+b)/(d-3) reiksme',cr,lf,'$' 
pran2   db 'Pradiniai duomenys: a=2, b=1, d=5',cr,lf,'$'
pran3   db 'Spauskite bet kuri klavisa...',cr,lf,'$'       
pran4   db 'ATSAKYMAS (reiskinio sveikoji dalis): ','$'
pran5   db 'Dalyba is 0 negalima! STOP',cr,lf,'$'                 
minus   db '-','$'
a       db 2
b       db 1                                     
d       db 5
du      db 2  
trys    db 3  
sveik   db ?,'$'
duomenys ends                                    
                                                 
programa segment                                 
        assume cs:programa, ds:duomenys, ss:stekas
start:                                          
        mov ax, duomenys                        
        mov ds, ax                              
;ekrano valymas                                 
        mov ax, 0002h                           
        int 10h                                 
;pranesimu isvedimas     
        mov ah, 02                                         
        mov bh, 00                                         
        mov dh, 4                                          
        mov dl, 11
        int 10h                                            
          lea dx, pran1                                      
          call spausdinti                               
        mov ah, 02                                         
        mov bh, 00                                         
        mov dh, 5                                         
        mov dl, 20       
        int 10h                                            
          lea dx, pran2                                 
          call spausdinti                               
        mov ah, 02                                         
        mov bh, 00                                         
        mov dh, 7                                       
        mov dl, 23                                         
        int 10h                                            
          lea dx, pran3                                 
          call spausdinti                            
                               
;laukia klaviso paspaudimo                      
        mov ah, 07h                             
        int 21h  
                 
        mov ah, 02                                         
        mov bh, 00                                         
        mov dh, 10                                       
        mov dl, 18                                         
        int 10h                                            
          lea dx, pran4
          call spausdinti             
                 
;skaiciavimai                         
        xor ax, ax       
        xor bx, bx       
        mov al, du ;2    
        mul a  ;a*2                   
        add al, b  ;a*2+b                 
        mov sveik, al
        mov bl, d ;d
        sub bl, trys ;d-3
        cmp bl, 0
        je klaida
        div bl   
        cmp ax, 0
        jge toliau
        lea dx, minus
        call spausdinti         
        mov sveik, al
toliau:          
;atsakymo isvedimas      
        add sveik, 30h   
        ;lea dx, pran4    
        ;call spausdinti  
        lea dx, sveik    
        call spausdinti  
        call pabaiga                                
                  
klaida:           
        mov ah, 02                                         
        mov bh, 00                                         
        mov dh, 10
        mov dl, 18                                         
        int 10h                                            
          lea dx, pran5                                
          call spausdinti
        call pabaiga                      
                 
pabaiga:                
; laukia klaviso paspaudimo           
        mov ah, 07h    
        int 21h        
;grizimas i DOS        
        mov ah, 4ch
        int 21h                                             
                 
spausdinti:      
push ax          
mov ah, 09h      
int 21h          
pop ax           
ret              
programa ends    
        end start