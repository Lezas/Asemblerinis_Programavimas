stekas segment stack                      
             db 255 dup(?)                           
stekas ends                               
                                                                       
cr equ 13                                                              
lf equ 10                                                              
                                                                       
duomenys segment                                                           
        pran db 'Ernestas Smalskys II-3/6',lf,cr                       
             db 'Kursinis darbas: I dalis',lf,cr,'$'                   
       pran1 db '  Prasome ivesti skaiciu, kuris',lf,cr                
             db ' bus lyginamas su masyvo vidurkiu',lf,cr,'$'          
       pran2 db 'Maksimumas masyve yra ','$'                           
       pran3 db 'Minimumas masyve yra ','$'                            
    pran_maz db 'Ivestas skaicius mazesnis uz masyvo vidurki',lf,cr,'$'
    pran_did db 'Ivestas skaicius didesnis uz masyvo vidurki',lf,cr,'$'          
         mas db 12,3,10,5,48,1,13,31,22,71,'*'          
        suma db 'Suma=','$'                                            
         sum db ?,lf,cr,'$'                                                 
    vidurkis db 'Vidurkis=','$'                                        
         vid db ?,lf,cr,'$'                                                
        list db 3 dup(?),lf,cr,'$'                                         
          lk db 2 dup(?),'$'                                           
         max db 3 dup(?),lf,cr,'$'                                        
         des db 10                                                         
        liek db ?                                                                                                       
         kab db ',', '$'                                                   
        maxi db 'Max=','$'                                             
        mini db 'Min=','$'                                             
         ind db 2 dup(?),lf,cr,'$'                                     
     max_ind db ?,lf,cr,'$'                                            
     min_ind db ?,lf,cr,'$'                                            
         min db 3 dup(?), lf,cr,'$'                                         
        sign db '-','$'                                                    
         num db 3,?,3 dup (0)                                               
          sk db 0                                   
       error db 'Masyvo suma nepateko tarp 0 ir 255, todel'
             db ' buvo pateikti tik sie rezultatai',lf,cr,'$'                                                     
                                                             
duomenys ends                                                                  
                                                                           
programa segment                                                               
      assume ss:stekas, ds:duomenys, cs:programa                                     
                                                                           
start:                                                                     
      mov ax, duomenys                                                         
      mov ds, ax                                                       
                                                                                                                                                                                                                   
     ;ekrano valymas                                                    
      mov ax, 02h                                                                
      int 10h                                                                                                                                                  
                                                                       
     ;skaiciaus ivedimas is klaviaturos                                                                      
      mov dx,0                                                          
      mov ah,09h                                                       
      lea dx,pran1                                                               
      int 21h                                                                    
      mov ah,0ah                                                       
      lea dx,num                                                                 
      int 21h                                                                    
                                                                           
      lea si,num+2                                                               
      mov cl,num+1                                                               
      mov ch,0                                                                   
      dec cl                                                                     
      mov al,[si]                                                                
      mov ah,0                                                                   
      sub al,30h                                                                 
      mov sk,al                                                                  
      cmp cl,0                                                                   
      je funkcd                                                        
                                                                                                                                       
ciklas0:                                                                   
      inc si                                                                     
      mov al,sk                                                                  
      mul des                                                                    
      mov bl,30h                                                                 
      sub [si],bl                                                                
      add al,[si]                                                                
      mov sk,al                                                                  
      loop ciklas0                                                     
                                                                       
      ;funkcine dalis                                                                                                                                                                                  
funkcd:                                                                
      mov ax, 02h                                                      
      int 10h                              
                                                          
      mov ah, 09h                                                      
      lea dx, pran                                                     
      int 21h                              
                                                                                                                                                     
      mov si, 0                                                          
      mov al, 0                                                          
                                                                           
ciklas1:                                                     
      ; masyvo elementu sumos skaiciavimas                                                             
      cmp mas[si],'*'  ; '*' yra masyvo pabaigos simbolis                                                 
      je kitas         ; kai jis sutinkamas ciklas baigiamas                                                
      add al,mas[si]                                                       
      inc si                                                               
      jmp ciklas1    ;persoka i ciklo pradzia                              
                                                                       
kitas:                                                       
      mov sum,al                          
      cmp sum, 0        ; tikrinama ar suma patenka i intervala [0,255]                                     
      jg zyme1                                                                            
      cmp sum, 255                                           
      jg  zyme1                                              
                                                   
                                                                                                                           
      mov cx,3                                                         
      mov di,2                                                         
                                                                                                                                                                                                
ciklas2:                                                               
      mov ah,0        ;verciama i desimtaini pavidala                                                 
      div des                                                          
      add ah,30h                                                       
      mov list[di],ah                                                  
      dec di                                                           
      loop ciklas2                                                     
                                                                                                                                                                                                   
      ;kursorius                                                       
      mov ah,02h                                                       
      mov bh,00                                                        
      mov dh,8                                                         
      mov dl,25                                                        
      int 10h                                                          
                                                                       
      mov ah, 09h                                                            
      lea dx, suma                                                     
      int 21h                                                          
                                                                       
      mov ah, 09h                                                             
      lea dx, list           ;isvedama suma                                          
      int 21h                                                          
zyme1:                                                                            
      cmp sum, 255                                           
      jg  zyme2                                              
      cmp sum, 0                                             
      jg zyme2                                               
                                                                       
      ;vidurkio skaciavimas                                                                                                    
      mov al, sum                                                      
      mov ah,0                                                         
      mov dx, 0                                                        
      div si                                                           
      mov liek, dl                                                     
      mov vid, al                                                      
                                                                       
      mov di, 1                                                        
      mov cx, 2                                                                                                                      
ciklas3:                                                               
      mov ah, 0                                                        
      div des                                                          
      add ah, 30h                                                      
      mov lk[di], ah                                                   
      dec di                                                           
      loop ciklas3                                                     
                                                                       
      mov ah,02h                                                       
      mov bh,00                                                        
      mov dh,9                                                         
      mov dl,25                                                        
      int 10h                                                          
                                                                       
      mov ah, 09h                                                      
      lea dx, vidurkis                                                 
      int 21h                                                          
                                                                   
      mov ah, 09h                                                     
      lea dx, lk          ;isvedama sveikoji dalis desimtainiu pavidalu                                      
      int 21h                                                      
                                                                   
      mov ah,09h                                                   
      lea dx, kab         ;isvedamas kablelis                                          
      int 21h                                                      
                                                                                                                               
      mov al, liek                                                 
      mov di,0                                                     
      mov cx,2                                                     
      mov dx,0                                                     
                                                                   
ciklas4:                                                           
      mov ah, 0                                                    
      imul des                                                     
      div si                                                       
      add al, 30h                                                  
      mov lk[di], al                                               
      mov al,dl                                                    
      inc di                                                       
      loop ciklas4                                                 
                                                                   
      mov ah, 09h                                                  
      lea dx, lk          ;isvedamas trupmenine dalis desimtainiu pavidalu                                         
      int 21h                                                      
                                              
zyme2:                                                             
        ;maksimumo radimas                                                                                                            
      mov ax, 0                                                    
      mov si, 0                                            
      mov bl, 1                                            
      mov max_ind, 1                                       
      mov al, mas[si]         ;maksimumui priskiriamas pirmas masyvo elemntas                                    
ciklas5:                                                   
      cmp mas[si],'*'                                             
      je maxim                                                                                                                                                                  
      cmp al, mas[si]         ;tikrinama ar sekantis elemntas ne didesnis                                    
      jge testi                                                   
      mov al, 0                                                  
      mov al, mas[si]         ;jei didesnis, maksimumui priskiramas jis pats                             
      mov max_ind, bl                                             
testi:                                                                         
      inc bl                                               
      inc si                                                      
      jmp ciklas5                                                 
                                                                  
maxim:                                        
                                                              
      mov cx,3                                                     
      mov di,2                                                                          
ciklas6:                                                            
      mov ah,0                                
      div des                                 
      add ah,30h                              
      mov max[di],ah                          
      dec di                                  
      loop ciklas6                              
                                                                             
      mov ah,02h                              
      mov bh,00                               
      mov dh,10                               
      mov dl,25                               
      int 10h                                 
                                              
      mov ah, 09h                                
      lea dx, maxi                            
      int 21h                                 
                                              
      mov ah, 09h                             
      lea dx, max         ;isvedamas maksimumas desimtainiu pavidalu                    
      int 21h                                                       
                                                                                       
     ;maksimumo indekso radimas                                     
      mov al, max_ind                                               
      mov cx,2                                                      
      mov di,1                                                                          
ciklas7:                                                            
      mov ah,0                                                      
      div des                                                       
      add ah,30h                                                    
      mov ind[di],ah                                                
      dec di                                                        
      loop ciklas7                                                  
                                                                    
      mov ah,02h                                                    
      mov bh,00                                                     
      mov dh,11                                                     
      mov dl,25                                                     
      int 10h                                                       
                                                                          
      mov ah, 09h                                                   
      lea dx, pran2                                                 
      int 21h                                                       
                                                                                                 
      mov ah, 09h                                                   
      lea dx, ind         ; isvedamas maksimumo indeksas                                          
      int 21h                                                       
                                                                    
     ;minimumo radimas                                  
      mov ah,02h                                        
      mov bh,00                                         
      mov dh,12                                         
      mov dl,25                                         
      int 10h                                           
                                                        
      mov ah, 09h                                       
      lea dx, mini                                      
      int 21h                                           
                                                                                                                                        
      mov ax, 0                                         
      mov si, 0                                         
      mov bl, 1                                         
      mov min_ind, 1                                    
      mov al, mas[si]     ;minimumui priskiriamas pirmas masyvo elemntas                              
ciklas8:                                                
      cmp mas[si],'*'                                   
      je minim                                                                                                              
      cmp al, mas[si]     ;tikrinama ar sekantis elemntas ne mazesnis              
      jle tesiam                          
      mov al, 0                           
      mov al, mas[si]     ;jei mazesnis, minimumui priskiramas jis pats              
      mov min_ind,bl                              
tesiam:                                           
      inc bl                                      
      inc si                                      
      jmp ciklas8                                 
                                                  
minim:                                                                                            
      cmp al,0            ;tikrinama ar neneigiamas                         
      jge pabaiga                                                           
                                                                            
      mov ah,09h                                                            
      lea dx,sign         ;jei neigiamas priestai isvedamas minusas                         
      int 21h             ; ir skaicius paverciamas teigiamu                        
      neg al                                                                                                                           
                                                                            
pabaiga:                                                                    
      mov cx,3                                                              
      mov di,2                                                                                                            
ciklas9:                                                                    
      mov ah,0                                                              
      div des                                                               
      add ah,30h                                                            
      mov min[di],ah                                                        
      dec di                                                                
      loop ciklas9                                                          
                                                                                                                 
      mov ah, 09h                                                           
      lea dx, min         ; isvedamas minimumas desimtainiu pavidalu                                  
      int 21h                                                               
                                                                            
      ;minimumo indekso radimas                                             
      mov al, min_ind                                                       
      mov cx,2                                                              
      mov di,1                                                                          
ciklas10:                                                                   
      mov ah,0                                                              
      div des                                                               
      add ah,30h                                                            
      mov ind[di],ah                                                        
      dec di                                                                
      loop ciklas10                                                         
                                                                            
      mov ah,02h                                                            
      mov bh,00                                                             
      mov dh,13                                                             
      mov dl,25                                                             
      int 10h                                                               
                                                                            
      mov ah, 09h                                                           
      lea dx, pran3                                                         
      int 21h                                                               
                                                                                                 
       mov ah, 09h        ; isvedamas minimumas                                          
      lea dx, ind                                                           
      int 21h                                                               
                                                                            
      cmp sum, 255                                                          
      jg  err1                                                              
      cmp sum, 0                                                            
      jg err1                                                               
                                                                                                 
      ;vidurkio lyginimas su ivestu skaiciumi                               
      mov al,sk                                                             
      cmp al,vid                                                            
      jle maziau                                                            
                                                                            
      mov ah,02h                                                            
      mov bh,00                                                             
      mov dh,14                                                             
      mov dl,15                                                             
      int 10h                                                               
                                                                            
      mov ah, 09h                                                           
      lea dx, pran_did                                                      
      int 21h                                                               
                                                                            
      jmp galas                                                             
                                                                            
maziau:                                                                     
      mov ah,02h                                                            
      mov bh,00                                                             
      mov dh,14                                                             
      mov dl,15                                                             
      int 10h                                                               
                                                                            
      mov ah, 09h                                                           
      lea dx, pran_maz                                                      
      int 21h                                                               
      jmp galas                                                             
                                                                            
err1:                                                                       
      mov ah,02h                                                            
      mov bh,00                                                             
      mov dh,23                                                             
      mov dl,1                                                              
      int 10h                                                               
                                                                            
      mov ah, 09h                                                           
      lea dx, error      ;pranesimas kad suma nepatenka i reikiama intervala
      int 21h                             
                                               
galas:                                         
      ;ekrano uzlaikymas                       
      mov ah, 07h                              
      int 21h                                  
                                                                          
      mov ah, 4ch                              
      int 21h               
                                       
programa ends                                      
end start 