stekas segment stack      
db 256 dup (?)                  
stekas ends               
                          
duomenys segment           
        ;intro
        VardasT db 16,?   
        Vardas  db 18 dup (' ')
        PavardT db 25,?         
        Pavard  db 27 dup (' ')
        pranV db 10,13,"Iveskite varda: ",'$'
        pranP db 10,13,"Iveskite pavarde: ",'$'  
        newline db 13,10, '$'
        ; skaiciaus ivedimas
        pran db 'Iveskite skaiciu: ','$'
        skaitm db 5 dup(?),'$'                  
        ten dw 10           
        ; skaicivimas  
        prans db 13,10,'Skaiciu suma: ','$'
        sum dw 0      
        ;klaida       
        error db 13,10,'Perpildimo klaida:',13,10
              db 'Ivestaas skaicius ar suma per didele','$'
duomenys ends                               
                    
program segment                                
       	assume cs:program,ds:duomenys,ss:stekas
start:                                         
       	mov ax,duomenys                        
       	mov ds,ax                              
; intro ivedimas                                                    
        lea dx,pranV        ;Vardas ivedimas
        mov ah,09h                         
        int 21h                            
        lea dx,VardasT                     
        mov ah,0Ah                         
        int 21h                            
        lea dx,pranP        ;Pavard ivedimas
        mov ah,09h                         
        int 21h                            
        lea dx,PavardT                
        mov ah,0Ah                         
        int 21h                            
                                    
        mov cx,0000h        ;cls               
        mov dx,184Fh     
        mov ax,0600h                   
        mov bh,07h                     
        int 10h     
; intro isvedimas     
        mov bl,VardasT+1    ; paruosimas isvedimui
        xor bh,bh          
        mov Vardas[bx+1],10
        mov Vardas[bx+2],'$'
        lea dx,Vardas       ; isvedimas                             
        mov ah,09h                  
        int 21h                      
        mov bl,PavardT+1    ; paruosimas isvedimui
        xor bh,bh          
        mov Pavard[bx+1],10
        mov Pavard[bx+2],'$'          
        lea dx,Pavard       ; isvedimas
        mov ah,09h         
        int 21h       
; uzd               
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
        cmp al,'0'       ;jei ne skaicius
        jb ived          ;pakartot ivedima
        cmp al,'9'        
        ja ived     
                          
        mov dl,al         
        mov ah,02h        
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
        cmp dx,0
        jne klaida
        mov dl,skaitm[si]                          
        xor dh,dh                                  
        add ax,dx          ;prie ax prirasem skaitmeni
        jc klaida
        inc si                                     
   loop skaic1               
                    
suma:   add sum,ax 
        jc klaida 
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
        jmp pabaiga
              
klaida: lea dx,error ;klaidos isvedimas
        mov ah,09h
        int 21h
                                                                                          
pabaiga: mov ax,4C00h
        int 21h                                                    
program ends                                                       
                                                                    
end start                                                           
       	       	     	     	                       
              