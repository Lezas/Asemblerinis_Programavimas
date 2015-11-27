stekas segment stack                               
        db 256 dup(?)                              
stekas ends                                        
                                                   
duomenys segment                                         
        nl equ 10,13
        vard    db 'Padare: Justinas Jasinskas II-2/3',nl,nl,'$'
        info1   db '+---------------------------------------------+',nl   
                db '|            Asemblerio  Kursinis Darbas      |',nl   
                db '+---------------------------------------------+',nl
                db '$'                                                    
        info2   db 'Pasirinkite uzduoti kuria norite atlikti:',nl,'$'
        uzd1    db '1. I uzduotis',nl,'$'                                   
        uzd2    db '2. II  uzduotis',nl,'$'
        info_u  db '3. Uzduociu INFO',nl,'$'   
        info_i  db 'Jei norite iseiti spauskite 0(Nuli)$'
        pasi    db 'Jusu pasirinkimas: $'          
        error1  db 'KLAIDA: Pasirinkite 0, 1, 2, 3$'
        info_v  db 'I uzduotis:',10,13                                                                
                db 'Ivedama simboliu eilute, isvedama ta pati eilute, po pirmo simbolio rasant viena'       
                db 'tarpa, po antro ir trecio - dar viena tarpa, po ketvirto, penkto, sesto - dar',10,13      
                db 'viena tarpa ir t.t., didziasias raides verciant i mazasias.',10,13                                
                db 'Pvz: Ivedam... KiSkiAkopUstlapiS  Rezultatas... k is kia kopu stlap is',10,10,13               
                db 'II uzduotis:',10,13                                                                    
                db 'Programa papraso ivesti skaiciu bei viena simboli, ir is ivesto simbolio ekrane',10,13             
                db 'suformuoja tusciaviduri romba, kurio krastines ilgis lygus ivestam skaiciui.',10,13
                db 'Pvz: Ivedem... 2 ir * Rezultatas:   *',10,13                                      
                db '                                   * *',10,13                                     
                db '                                    *',10,10,13
                db 10,10,10,10,10,13,'$'
        pauze   db 'Noredami testi spauskite bet koki klavisa...$'
        uzd1_p1 db 'Iveskite simboliu eilute: $'    
        uzd1_p2 db 'Jus ivedete: $'                                                
        uzd1_p3 db 'Rezultatas: $'                                                 
        tarpas  db ' $'                                
        simb_pa db '$'                                 
        uzd2_p1 db 'Iveskite skaiciu(2-6): $'       
        uzd2_p2 db 'Iveskite viena simboli: $'         
        uzd2_p3 db 'Gautas tusciaviduris Rombas: $'    
        error2  db 'KLAIDA!!! Ivesti galima nuo 2 iki 6$'
        ivestas1 db ?,'$'                                                                                  
        ivestas2 db ?,'$'                                 
        temp     db ?,'$'                                 
        temp1    db ?,'$'                                 
        temp2    db 1,2,3,4,5,6,7,8,9,10,11,12,'?'        
        simb_eil db 255 dup(?),'$'            
        ilgis    dw 0      
        skaitik  db ?,'$'  
        skaitik2 db ?      
                                              
                                                    
duomenys ends                                                                      
                                                                                            
kursinis segment                                                                            
assume cs:kursinis, ds:duomenys, ss:stekas                                                  
                                                                                            
;Paprogramiai                                                                               
PrintBuf PROC                                                                               
     	push ax	        ; issaugome steke registrus, kurie keisis                           
	push bx                                                                             
	                                                                                    
	mov ah,40h                                                                          
	mov bx,1                                                                            
	int 21h                                                                             
	                                                                                    
	mov si,ax     	     		                                                    
	pop bx 	      	     	                                                            
     	pop ax                                                                              
       	RET          
ENDP PrintBuf        
skaicius PROC        
        cmp al,10    
        jae didelis   
        add al,30h   
        mov temp1,al 
        mov ah,09h                                        
        lea dx,temp1 
        int 21h      
        RET          
didelis:             
        mov bh,10    
        div bh       
        mov temp,al 
        mov temp1,ah
        mov bh,3    
        sub temp,bh 
        mov bh,2    
        sub temp1,bh
        add temp1,30h
        mov ah,09h  
        lea dx,temp 
        int 21h      
        mov ah,09h    
        lea dx,temp1
        int 21h     
        RET         
ENDP skaicius      
pavadinimas PROC                   
        mov cx,0                  
        mov cl,[si+1]
        add si,2     
pav:           
        mov bl,[si]
        mov [di],bl  
        inc si        
        inc di        
        loop pav 
        RET        
ENDP pavadinimas   
                                                                                            
;Pradzia                                                                                    
START:                                                                                      
        mov ax,duomenys                                                                     
        mov ds,ax                                                                           
START1: mov ax,0002h                                                                        
        int 10h                                                                             
                                                                                            
        mov ah,09h                                                                          
        lea dx,info1                                                                        
        int 21h                                                                             
                                                                                            
        mov ah,09h                                        
        lea dx,vard                                       
        int 21h                                           
                                                          
        mov ah,09h                                        
        lea dx,info2                                      
        int 21h                                           
                                                          
        mov ah,09h                                        
        lea dx,uzd1                                       
        int 21h                                           
                                                          
        mov ah,09h                                        
        lea dx,uzd2                                       
        int 21h                                           
                                                          
        mov ah,09h                                        
        lea dx,info_u                                     
        int 21h                                           
                                                          
        mov ah,09h                                        
        lea dx,info_i                                     
        int 21h                                           
        jmp rinkis                                        
                                                                                            
kartot: mov ax,0600                                       
        mov bh,07                                         
        mov cx,1600h                                      
        mov dx,184fh                                      
        int 10h                                           
rinkis: mov ah,02h                                        
        mov bh,00                                         
        mov dh,18                                         
        mov dl,16                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,pasi                                       
        int 21h                                           
        mov ah,08h                                        
        int 21h                                           
        mov ivestas1,al                                   
        mov ah,09h                                                                          
        lea dx,ivestas1                                   
        int 21h                                           
        sub ivestas1,30h                                  
        cmp ivestas1,0                                    
        je pabaig                                         
        cmp ivestas1,1                                    
        je uzduot1                                        
        cmp ivestas1,2                                    
        je uzduot2                                        
        cmp ivestas1,3
        je Info                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,19                                         
        mov dl,16                                                                           
        int 10h                                           
        mov ah,09h                                        
        lea dx,error1                                     
        int 21h                                           
        mov ah,07h                                        
        int 21h                                           
        jmp kartot                                           
                                                          
pabaig:  jmp pabaig1                                      
uzduot2: jmp uzduot2a                                     
                                                          
Info:   mov ax,0002h                                      
        int 10h                                           
        mov ah,09h                                        
        lea dx,info_v                                     
        int 21h                                           
        mov ah,09h                                        
        lea dx,pauze                                      
        int 21h                                           
        mov ah,07h                                        
        int 21h                                           
        jmp START1                                        
                                                          
uzduot1:                                                  
        mov ax,0002h                                      
        int 10h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,01                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd1                                       
        int 21h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,03                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd1_p1                                    
        int 21h                                           
        mov ah,3fh                                        
        mov bx,0                                          
        mov cx,254                          
        lea dx,simb_eil                                   
        int 21h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,06                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd1_p2                                    
        int 21h                                           
        mov ah,09h                                        
        lea dx,simb_eil                                   
        int 21h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,07                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd1_p3                                    
        int 21h                                           
                                                          
        mov bh,0                                          
        mov si,0                                          
        mov di,1                                          
uzd1_L1:                                                  
        mov cx,di                                         
uzd1_L2:                                                  
        mov bh,simb_eil[si]                               
        cmp bh,simb_pa                                    
        je toliau1                                        
        mov ivestas1,bh 
        cmp ivestas1,65
        jb testi
        cmp ivestas1,90
        ja testi       
        add ivestas1,32
testi:  mov ah,09h
        lea dx,ivestas1                                   
        int 21h                                           
        inc si                                            
        loop uzd1_L2                                      
        mov ah,09h                                        
        lea dx,tarpas                                     
        int 21h                                           
        inc di                                            
        loop uzd1_L1                                      
                                                          
toliau1:                                                  
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,12                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,pauze                                      
        int 21h                                           
        mov ah,07h                                        
        int 21h                                           
        jmp START1                                        
                                                          
uzduot2ak:                                                
                                                          
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,06                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,error2                                     
        int 21h                                           
        mov ah,07h                                        
        int 21h                                           
                                                          
uzduot2a:                                                 
        mov ax,0002h                                      
        int 10h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,01                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd2                                       
        int 21h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,03                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd2_p1                                    
        int 21h                                           
        mov ah,08h                                        
        int 21h                                           
        mov ivestas1,al                                   
        mov ah,09h                                        
        lea dx,ivestas1                                   
        int 21h                                           
        sub ivestas1,30h                                  
        cmp ivestas1,2                                    
        jb uzduot2ak                                      
        cmp ivestas1,6                                    
        ja uzduot2ak                                      
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,04                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd2_p2                                    
        int 21h                                           
        mov ah,08h                                        
        int 21h                                           
        mov ivestas2,al                                   
        mov ah,09h                                        
        lea dx,ivestas2                                   
        int 21h                                           
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,06                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,uzd2_p3                                    
        int 21h                                           
                                                          
        mov ah,ivestas1                                   
        add ah,8                                          
        mov temp,ah                                       
        mov temp1,ah                                      
        sub temp1,2                                       
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,temp                                       
        mov dl,01                                         
        int 10h                                           
        mov si,0                                          
                                                          
uzd2_L1:                                                  
        sub temp,1                                        
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,temp                                       
        mov dl,temp2[si]                                  
        int 10h                                           
        mov ah,09h                                        
        lea dx,ivestas2                                   
        int 21h                                           
                                                          
        add temp1,1                                       
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,temp1                                      
        mov dl,temp2[si]                                  
        int 10h                                           
        mov ah,09h                                        
        lea dx,ivestas2                                   
        int 21h                                           
                                                          
        inc si                                            
        mov ah,ivestas1                                   
        cmp temp2[si],ah                                  
        jbe uzd2_L1                                       
                                                          
        mov ah,ivestas1                                   
        sub ah,1                                          
        add ivestas1,ah                                   
uzd2_L2:                                                  
        add temp,1                                        
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,temp                                       
        mov dl,temp2[si]                                  
        int 10h                                           
        mov ah,09h                                        
        lea dx,ivestas2                                   
        int 21h                                           
                                                          
        sub temp1,1                                       
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,temp1                                      
        mov dl,temp2[si]                                  
        int 10h                                           
        mov ah,09h                                        
        lea dx,ivestas2                                   
        int 21h                                           
                                                          
        inc si                                            
        mov ah,ivestas1                                   
        cmp temp2[si],ah                                  
        jbe uzd2_L2                                       
                                                                                              
        mov ah,02h                                        
        mov bh,00                                         
        mov dh,20                                         
        mov dl,01                                         
        int 10h                                           
        mov ah,09h                                        
        lea dx,pauze                                      
        int 21h                                           
        mov ah,07h                                        
        int 21h                                           
        jmp START1                                        
                                                                                          
;Pabaiga                                           
Pabaig1: mov ah,4ch                            
         int 21h                                    
                                                   
kursinis ends                                      
end START                                          
 