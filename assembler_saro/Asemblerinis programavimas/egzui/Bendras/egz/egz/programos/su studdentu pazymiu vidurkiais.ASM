;Kursinis darbas          
;Uzduoties Nr. 3.3        
;paskaiciuti studentu pazymiu bendra vidurki, kai studentu skaicius nezinomas
;Atliko: Gintaras Vaikutis II 0/3
stek segment stack                
        db 256 dup (0)            
stek ends                                   
duom segment                                                     
        vp db 10,13,' Atliko:Gintaras Vaikutis II 0/3',10,13,'$'
        stsar db ' Studentu ir ju pazymiu sarasas: ','$'         
        mas   db  'ii0/3', ' Saulius', 8,9,7,6,8,6,7,8,8,10,0
              db  'ii0/4', ' Paulius ', 10,10,10,10,10,10,10,10,10,10,0
              db  'ii2/2', ' Tomas ',8,6,7,8,6,9,9,2,3,10,0
              db  'ii1/9', ' Zilvinas ',8,5,9,6,9,8,8,10,9,7,0
              db  'ii9/1', ' Marius ',7,9,9,9,8,9,7,6,6,9,0
              db  'ii0/3', ' Nerijus ',8,9,9,6,8,6,9,6,9,10,0
             db '***'                                            
        kte  db 10,13,'$'                                        
        stvid db 'Studentu vidurkiai ziurint is virsaus i apacia ','$'
        linija db 10,13,'-------------------------------------------',10,13,'$'
        pranes db 'bendras vidurskis','$'                        
        isvats db ' Bendras studentu vidurkis: ','$'             
        ats db '   .    ','$'                                    
        d db 10                                                  
duom ends                                                        
kurs6 segment                                   
assume cs:kurs6,ds:duom                         
start:                                          
        mov ax,duom                             
        mov ds,ax                               
;Ekrano valymas                                          
        mov ax,0002h                                     
        int 10h           
                                       
	mov ah,09h                              
	lea dx,vp                               
	int 21h                                 
	                  
	mov si,0                                
;pranesimu isvedimas                
        mov ah,09h                              
        lea dx,kte                              
        int 21h                   
        lea dx,kte                
        int 21h                   
        lea dx,stsar                                        
        int 21h                   
        lea dx,linija                       
        int 21h                   
                          
        xor di,di                             
isv:                                            
        cmp mas[si],'*' ;tikrinam ar ne pabaiga                                               
        jne tol                                
        inc si                                 
        cmp mas[si],'*'                        
        jne tol                                
        inc si                                 
        cmp mas[si],'*'                        
        jne tol                                
                                               
        push dx                                
        mov ah,09h                             
        lea dx,linija                          
        int 21h                                
        lea dx,stvid                           
        int 21h                                
        pop dx                                 
        xor ax,ax                              
        jmp pradsk      ;persokam i vidurkiu skaiciavima                       
tol:                                                    
        cmp mas[si],0  ;ziurim ar ne iraso pabaiga                                                
        jne tolx                                                       
        inc di         ;padidinam studentu skaiciu                                                
        mov ah,09h                                                     
        lea dx,kte      ;tuscia eilute                                               
        int 21h                                                        
tolx:                                                                  
        cmp mas[si],1  ;ziurim ar turime skaiciu                                                
        jb xx          ;jei maziau uz 1                                                
        cmp mas[si],10                                                 
        ja xx                                                          
        cmp mas[si],10  ;jei tai ne 10 persokam              
        jne bedes                              
        mov ah,02h      ;isvedam desimt              
        mov dl,31h                    
        int 21h                   
        mov dl,30h                          
        int 21h                   
        mov dl,' '     ;bei isvedam tarpa           
        int 21h                          
        inc si                           
        jmp isv                                                        
bedes:                                   
        mov dl,mas[si]  ;isvedam skaiciu                                     
        add dl,30h                              
        mov ah,02h                              
        int 21h                                 
        mov dl,' '      ;bei isvedam tarpa                        
        int 21h                                 
        inc si                                  
        jmp isv                                 
xx:                                             
        mov ah,02h                        
        mov dl,mas[si]                     	
        int 21h                           
        inc si                     
        jmp isv                             
                            
pradsk:            ;skaiciavimas
        mov si,0                  
        push di    ;isimename studentu skaiciu               
        mov cx,di  ;ciklas bus vygdomas di kartu ---
pralvard:          ; praleidziame vardus ir pavardes                   
        cmp mas[si],1                                                  
        jb pral                                                        
        cmp mas[si],10                                                 
        ja pral                                                        
        jmp vid                                                        
pral:                                                                  
        inc si                                                         
        jmp pralvard                                                   
vid:                                                                   
        push cx                                                        
        mov cx,10                                                      
        xor bx,bx                                                      
cikl:                  ;ciklas bus vydomas 10 kartu                                               
        add bl,mas[si] ;ciklui pasibaigus bl bus pazymiu suma
        inc si                                                         
        loop cikl                                                      
kikvpazsuma:                                                           
        push ax
        push dx                                                        
        mov mas[si],bl ;vietoj elemento "nulis" bl
        mov ah,09h                                                     
        lea dx,kte                                                     
        int 21h                                                        
        mov ah,02h                                                     
        mov dl,' '                                                     
        int 21h                                                        
        xor ax,ax                                 
        cmp bl,100 ;paziurim ar musu vidurkis bus 10                               
        je desbalu                                  
        mov al,bl                                   
        div d                                     
        add al,30h                                
        mov dh,ah     ;isimename liekana                            
        mov dl,al                                 
        mov ah,02h                                
        int 21h                                   
        mov dl,'.'                                
        int 21h                                   
        add dh,30h                                
        mov dl,dh                                 
        int 21h                                   
        jmp galas                                 
desbalu:                                          
        mov ah,02h                                
        mov dl,'1'                                
        int 21h                                   
        mov dl,'0'                                
        int 21h                                   
        mov dl,'.'                                
        int 21h                                   
        mov dl,'0'                                
        int 21h                                   
                                                  
                                                  
galas:                                            
        pop dx                                    
        pop ax                                    
        jmp suma                                  
                                                  
suma:                                                
        add ax,bx ;visu studentu pazymiu suma               
        inc si                                    
        pop cx                                    
        loop pralvard   ;---                          
        pop di  ;studentu kiekis                                  
        xor bx,bx                 
        xor dx,dx                 
        mov bx,ax                 
        mov ax,di                 
        mul d     ;di*d pazymiu kiekis
        mov dl,al ;di*d perkeliam i dl                      
        mov ax,bx ;i ax grazinam suma                    
        div dl    ;sum/N                
        xor bx,bx                 
        mov bh,ah ;isimename liekana
        xor ah,ah                 
        mov si,2                  
des:                              
        div d                     
        add ah,30h     
        mov ats[si],ah            
        cmp al,0                  
        je liek                   
        dec si                    
        xor ah,ah                 
        jmp des                   
liek:                             
        mov si,4                  
        xor ax,ax                 
        mov al,bh                 
vpokab:                           
        mul d                     
        div dl                    
        xor ah,ah ;kadangi reikia tik vieno skaitmens po kablelio
        add al,30h                
        mov ats[si],al            
rez:                              
        mov ah,09h                
        lea dx,linija             
        int 21h                   
        lea dx,isvats             
        int 21h                   
        lea dx,ats                
        int 21h                   
                                                                 
dos:   	               
        mov ah,07h     
        int 21h                 	                  
       	mov ah,4ch                
	int 21h                   
                                  
kurs6 ends                        
end start	