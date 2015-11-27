stekas segment stack                 
       	db 256 dup (?)               
stekas ends                          
                                     
duomenys segment                     
        inf db 'Kursinis darbas',13,10
            db 'Atliko Sigita Ciapaite, II-2/6 gr.',10,13
            db 'Ivedami du skaiciai, ir isvedamas tu skaiciu vidurkis.',10,13, '$'         
        pran db 10,10,10,13, 'Programos pabaiga.','$'
        a db 10,13,'Iveskite  a: ','$'
        b db 10,13,'Iveskite  b: ','$'
        rezultatas db 10,13,'Vidurkis: ', '$'
        tmp dw 0
        tmp2 dw 0
        kinta  dw 0           
        kintb  dw 0
        ats db 6 dup(0), 10,13,'$'
        c db 2
        d db 0
        e db 10 
        f db 44          
        desimt db 10
duomenys ends                         
                                      
programa segment                     
   assume cs:programa, ds:duomenys, ss:stekas
                                     
start: 	mov ax,duomenys ; inicializuojami duomenys     
       	mov ds,ax              
 	mov ax, 0002h   ; isvalomas ekranas
        int 10h
        
        mov ah, 09h     ; Spausiname pranesima
        lea dx, inf
        int 21h
       
iva:    mov ah, 09h     ; Ivesti a:
        lea dx, a         
        int 21h               
        mov bx, 00h    
        mov d, 1
        call ivedimas   ; kreipiames ivestii paprograme
        cmp tmp2, 256   ; lyginame
        jae iva         ; jei didesnis tai ivesti is naujo
        jbe ka

ka:     mov bx, tmp2    ; ivedem kintamaji a
        mov kinta, bx         
        
ivb:    mov ah, 09h     ; prasome ivesti kintamaji b:
        lea dx, b        
        int 21h 
        mov bx, 00h     ; ruosiames         
        mov d, 1                       
        call ivedimas   ; ivedimas
        cmp tmp2, 256   ; lyginimas
        jae ivb
        jbe kb
kb:     mov bx, tmp2    ; ivedeme kintamaji b
        mov kintb, bx         

        mov ah, 09h     ; spausdiname rezultato pranesima
        lea dx, rezultatas     
        int 21h
        mov ax, 00h                
; Skaiciavimas                    
        mov ax, kinta
        add ax, kintb   ; kintamuju suma
        div c           ; vidurkis
        
        mov cx, 00h     ; siunciam i steka duomeni i  steka siusim liekana
        mov cl, ah      ; pirma issivalom cx registra, paskui islpeciam iki zodzio
        push cx         ; siunciam
        mov si, 00h
        call sveika     ; kvieciam procedura sveikai daliai apskaiciuoti
        mov si, tmp
        mov bl, f
        mov ats[si], bl ; irasom kableli
        pop dx          ; is steko pasiimam liekana
        mov al, dl
        mov ah, 00h
liek:   inc si          ; skaiciuosim trupmenine dali
        mul e
        div c
        add al, 30h
        mov ats[si], al
        mov al, ah
        cmp si, 5
        jne liek
        je baigt
baigt:
        mov ah, 09h     ; isvedame atsakyma
        lea dx, ats
        int 21h
        mov ah, 09h     ; isvedame programos pabaigos pranesima
        lea dx, pran
        int 21h
                
        mov ah, 07h     ; pabaiga          
        int 21h                
	mov ah, 4ch            
  	int 21h                

ivedimas proc
        mov tmp2, 00h
        mov di, 00h
        mov cx, 00h
        mov si, 00h     ; ivedimo kontrolei
iv:                     
        mov ah, 08h     ; ivedam simboli  (al)            
        int 21h                
        cmp al, 0Dh     ; tikrinam ar buvo nutrauktas ivedimas (ENTER)
        je sir             
        cmp al, 30h     ; lyginam su simboliu 0
        jb iv           ; buvo ivestas ne skaicius
        cmp al, 39h     ; lyginam su simboliu 9      
        ja iv           ; buvo ivestas ne skaicius
        mov ah, 02h     ; isvedam i ekrana       
        mov dl, al
        int 21h
        xor dh, dh      ; issivalom dh
        push dx         ; siunciam i steka
        inc si          ; keiciam si
        cmp si, 3
        je tol
        jmp iv 
sir:    cmp si, 0       ; ar buvo ivesta
        je iv
tol:    mov cx, si
IL:     pop ax
        xor ah, ah
        sub al, 30h
        mul d
        add tmp2, ax
        mov al, d
        mul desimt
        mov d, al
        loop IL
iv_pab:                        
        ret                    
ivedimas endp

sveika proc
        cmp al, 9
        jbe vnt
        cmp al, 99
        jbe du
        ja trys
vnt:    
        mov si, 1       ; vienzenklis skaicius
        jmp ciklas
du:
        mov si, 2       ; dvizenklis  skaicius
        jmp ciklas       
trys:
        mov si, 3       ; dvizenklis  skaicius
        jmp ciklas
ciklas: mov tmp, si     ; isissaugiom                                                     
dar:    dec si          ;si=si-1
        mov ah, 00h                                         
        div e           ;ax=ax/e,             
        add ah, 30h     ;ah=ah+30h pridedam prie liekanos
        mov ats[si], ah
        jmp t
t:      cmp al, 0       ;lyginam ar sveikoji dalis lygi 0.
        je stp                                            
        jne dar
stp:    ret
sveika endp     ; proceduros pabaiga
        
 
programa ends                   
end start                       
