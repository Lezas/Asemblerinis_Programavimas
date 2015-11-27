stekas segment stack
        db 256 dup(?)
stekas ends       
                  
duomenys segment  
x dw 0  
skaic_kl db 'Ivestas netinkamas simbolis,ivesti galima tik teigiamus skaicius!!!',10,13,'$'
ived_kl db 'Niekas neivesta,bandyk dar karta!!!',10,13,'$'
ov_flow db 'Perdidelis skaicius!!!Galima ivesti max 255',10,13,'$'
pranA db 'Iveskite a: $'
pranB db 10,13,'Iveskite b: $'
rez db 'Rezultatas= ','   ','$'
des db 10                                           
ivsr db 4,?,4 dup(0)                                
duomenys ends                                       
                                                    
programa segment                                    
assume ss:stekas, ds:duomenys, cs:programa          
start:                                              
        mov ax,02h                                  
        int 10h                                     
        mov ax,duomenys                             
        mov ds,ax                                   
        mov ah,09                                   
        lea dx,pranA                                
        int 21h                                     
        call ivedimas                               
        call konvert                                
        mov x,ax
        mov ah,09h                                   
        lea dx,pranB                                
        int 21h                                     
        call ivedimas                               
        call konvert                                
        call suma                                
suma proc
        mov ah,0  
        add ax,x
        div des  
        add ah,30h                                  
        mov rez+14,ah
        mov ah,0                                    
        div des                                     
        add ah,30h                                  
        mov rez+13,ah
        mov ah,0                                    
        div des                                     
        add ah,30h                                  
        mov rez+12,ah
    	mov ax,02h                                  
	int 10h                                     
	;spausdinimas                               
	mov ah,09h                                  
     	lea dx,rez                                  
     	int 21h                                     
        JMP pabaiga                                 
suma endp
ivedimas proc                                       
        lea dx,ivsr
        mov ah,0ah
        int 21h                                     
        ret                                         
ivedimas endp                                       
konvert proc                                        
        sub ax,ax                                   
        sub cx,cx                                   
        mov cl,ivsr+1                               
        CMP cl,0     ;tirkina ar ivesta kas nors                  
        JE nulis                                    
        lea SI,ivsr+2;nuskaito pirma adresa         
        mov bh,[SI]  ;i bh nusiuncia SI adresa                                                 
        CMP bh,'0'   ;tikrina ar nemaziau nulis     
        JL klaida                                   
        CMP bh,'9'   ;tikrina ar nedaugiau 9                  
        JG klaida                                   
        sub bh,30h                                  
        add al,bh                                   
        dec cl                                      
        CMP cl,0                                    
        JE procpab                                                    
ciklas:                                             
        inc SI                                      
        mov bh,[SI]
        CMP bh,'0'                                  
        JL klaida                                   
        CMP bh,'9'                                  
        JG klaida                                   
        mov ah,0  
        sub bh,30h
        mul des
        add al,bh 
         Jc over
        mov ah,0
        JMP isejimas                                
over:   
        mov ah,09h                                  
        lea dx,ov_flow
        int 21h                                     
        JMP pabaiga
nulis:                                              
        mov al,0                                    
        mov ah,09h                                  
        lea dx,ived_kl                              
        int 21h                                     
        JMP pabaiga                                 
klaida:                                             
        mov ah,09h                                  
        lea dx,skaic_kl
        int 21h                                     
        JMP pabaiga                                 
                                                    
isejimas: loop ciklas                               
procpab:  ret
                                         
konvert endp                                        
                                                        
pabaiga:
mov ah,07h
int 21h         
mov ah,4ch
int 21h 
        
programa ends
end start      
        