stekas segment stack       
        db 256 dup(?)      
stekas ends                
                           
duomenys segment              
        info    db ' Levaldas Sukovas II-2/3',10,13
                db ' Programa papraso ivesti zodi ir isveda ji kita puse$'        
        pran1   db 10,10,13,' Iveskite zodi: $'
        pran2   db ' Zodis kita puse: $'
        mas     db 30 dup(?),'$'
        temp    db ?,'$'      
        simb    db '$'        
                                                                       
duomenys ends                                                          
                                                                       
programa segment                                                       
        assume cs:programa,ds:duomenys,ss:stekas                       
                                                                       
START:                                                                 
        mov ax,duomenys                                                
        mov ds,ax                                                      
        mov ax,0002h                                                   
        int 10h                 
                                
        mov ah,09h              
        lea dx,info             
        int 21h                 
                                
        mov ah,09h              
        lea dx,pran1            
        int 21h                 
                                
        mov ah,3fh                                     
        mov bx,0                                       
        mov cx,30               
        lea dx,mas              
        int 21h                 
                                
        mov ah,09h              
        lea dx,pran2            
        int 21h                 
                                
        mov si,0              
C1:     mov bh,mas[si]          
        cmp bh,simb           
        je toliau             
        inc si                
        jmp C1                
        mov cx,si             
toliau: mov bh,mas[si]        
        mov temp,bh           
        mov ah,09h            
        lea dx,temp           
        int 21h                 
        dec si
        loop toliau           
        mov bh,mas[0]         
        mov temp,bh           
        mov ah,09h            
        lea dx,temp           
        int 21h               
                              
                                
;Pabaiga                                  
        mov ah,07h              
        int 21h                 
        mov ah,4ch         
        int 21h            
programa ends              
end START