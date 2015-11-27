stekas segment stack      
db 256 dup (?)                  
stekas ends               
                          
duomenys segment           
        VardasT db 16,?   
        Vardas  db 16 dup (' '),13,10,'$'
        PavardT db 25,?        
        Pavard  db 25 dup (' '),13,10,'$'
        pranV db 10,13,"Iveskite varda: ",'$'
        pranP db 10,13,"Iveskite pavarde: ",'$'  
        newline db 13,10, '$'   ;tuscia eilute
        pran db 'Iveskite skaiciu: ','$'
        skaitm db 5 dup(?),'$'                  
        ten dw 10             
        prans db 13,10,'Skaiciu suma: ','$'
        sum dw 0,0 
duomenys ends                               
                    
program segment                                
       	assume cs:program,ds:duomenys,ss:stekas
start:                                         
       	mov ax,duomenys                        
       	mov ds,ax
;ekrano valymas
        mov ax, 02h
        int 10h
;pranesimo isvedimas                	
        mov ah, 09h
        lea dx,pranV        
        int 21h 
;ivedimas is kliaviaturos         
        mov ah, 0ah                             
        lea dx,VardasT                                             
        int 21h 
;pranesimo isvedimas        
        mov ah, 09h                           
        lea dx,pranP        
        int 21h
;ivedimas is klaviaturos        
        mov ah, 0ah     
        lea dx,PavardT                                       
        int 21h                            
;ekrano valymas        
        mov ax, 02h
        int 10h                               
;vardo isvedimas     
        mov bl,VardasT+1    
        xor bh,bh          
        mov Vardas[bx+1],10
        mov Vardas[bx+2],'$'

        mov ah, 09h
        lea dx,Vardas                                                     
        int 21h
;pavardes isvedimas                             
        mov bl,PavardT+1    
        xor bh,bh          
        mov Pavard[bx+1],10
        mov Pavard[bx+2],'$'
        
        mov ah, 09h
        lea dx,Pavard             
        int 21h       
;skaiciavimai
        mov cx,10   
nexts:  push cx     
                    
        lea dx,newline  
        mov ah,09h  
        int 21h        
       	lea dx,pran           
       	mov ah,09h            
       	int 21h               
       	                      
        mov cx,5              
        mov si,0 
                     
ived:   mov ah,08h  
        int 21h           
                          
        cmp al,13        ;ar ne Enter 
        je skaic          
        cmp al,'0'       ;lygina al su 0
        jb ived          ;jei maziau, pakartot ivedima
        cmp al,'9'       ;lygina al su 9 
        ja ived          ;jei daugiau pakartok ivedima
                          
        mov dl,al         
        mov ah, 02h        
        int 21h                                       
                          
        sub al,'0'        
        mov skaitm[si],al 
        inc si               
loop ived

skaic:                              
        mov al, skaitm[0]     ;ax - pirmas skaitmuo
        xor ah,ah                                  
                    
        cmp si,1    
        je suma                                           
        mov cx,si                                  
        sub cx,1                                   
        mov si,1                                   
skaic1:                                           
        mul ten                                    
        mov dl,skaitm[si]                          
        xor dh,dh                                  
        add ax,dx          ;prie ax prirasem skaitmeni
        inc si                                     
loop skaic1               
                    
suma:   add sum,ax
        adc sum+2,0
        pop cx      
loop nexts           
                    
        mov ax,sum
; isvedam ax i ekrana kaip skaiciu (ax,cx,dx,si;skaitm,ten)
        xor dx,dx
        mov cx,5    
next:   div ten     
        mov si,cx   
        add dl,'0'  
        mov skaitm[si-1],dl
        xor dx,dx   
        cmp ax,0000h
loopne next 
        
nuliai: mov si,cx   
        mov skaitm[si-1],'0'
loop nuliai      
                    
        lea dx,prans  ;isvedimas
        mov ah,09h
        int 21h        
        lea dx,skaitm
        mov ah,09h
        int 21h
;ekrano uzlaikymas
        mov ah, 07h
        int 21h
;grizimas i DOS'a                                                                                  
        mov ah,4ch                                               
        int 21h                                                    
program ends                                                       
end start                                                           
       	       	     	     	                       
              