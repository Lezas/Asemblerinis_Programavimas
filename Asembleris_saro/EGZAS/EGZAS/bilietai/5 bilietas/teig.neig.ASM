SSEG SEGMENT STACK  
db 256 dup (?)                         
ENDS SSEG                              
                                       
DSEG SEGMENT                           
        ind dw 0                       
	_10 db 10
        Tekstas1 db 'Masyve teigiamu skaiciu yra:   .', 10, 13, '$'
        Tekstas2 db 'Masyve neigiamu skaiciu yra:   .', 10, 13, '$'
	teig db 0                      
	neig db 0                      
	mas db -1,-2,3,4,-5,6,7,8,-9,0
	    db	1,2,3,-4,5,6,7,-8,9,0
	    db 	1,2,-3,4,-5,6,-7,8,9,0
ENDS DSEG                              
                                       
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG       

START:                                 
	; Ikeliam duomenu segmentu adesa i DS
        mov ax, DSEG                     
        mov ds, ax                      
	; Isvalom ekrana           
	mov ax, 0002h             
        int 10h                          	
	; Cikla kartosim 30 kartu, todel reiksme irasom i CX
	mov cx, 30  
ciklas:             
	mov ax, cx  
	; CX suksis nuo 30 iki 1 mazejanciai, o masyvas numeruojamas nuo 0
	; Todel atimam vienata, kad AX suktusi nuo 29 iki 0
	sub ax, 1               
	; I indeksini registra irasom einamojo skaiciaus indeksa masyve
	mov si, ax              
	; I BX irasom einamaji skaiciu is masyvo
	mov bl, mas[si]         
	; Palyginam skaiciu su 0
	cmp bl, 0    
	jl maziau                   
	jg daugiau                  
	; Jeigu nulis, nieko nedarom
	je toliau                   
maziau:                             
	; Padidinam neigiamu skaiciu skaitikli
	inc neig                    
	; Persokam DAUGIAU dali     
	jmp toliau                  
daugiau:                            
	; Padidinam teigiamu skaiciu skaitikli
	inc teig                    
toliau:                             
loop ciklas                         
        ; I ind irasom vieta eiluteje, kur rasysim rezultata                           
	mov ind, 30                                         
	; I al irasom kiek turim teigiamu skaiciu
	mov al, teig                             
rasom_1:                                         
        ; AX dalinam is 10                           
        div _10                                      
        ; Pridedam 48, kad paversti skaiciu i ASCII simboli                       
        add ah, 30h                                  
        ; Irasom simboli i eilute                    
        mov si, ind                                  
        mov Tekstas1[si], ah                         
        ; Nunulinam ah                               
        xor ah, ah                                   
        ; Sumazinam indeksa (painam i kaire eiluteje)
        dec ind                                      
        ; Jei liekana ne nulis, kartojam rasymo cikla
        cmp al, 0                                    
        jne rasom_1                                  
        
        ; Vel i indeksa ind irasom vieta eiluteje                                             
	mov ind, 30                              
        ; I AL irasom neigiamu skaiciu kieki	                                         
	mov al, neig                        
                                            
rasom_2:                                    
        ; AX dalinam is 10                           
        div _10                             
        ; Pridedam 48, kad paversti skaiciu i ASCII simboli                       
        add ah, 30h                                  
        ; Irasom simboli i eilute                    
        mov si, ind                                  
        mov Tekstas2[si], ah                
        ; Nunulinam ah                               
        xor ah, ah                                   
        ; Sumazinam indeksa (painam i kaire eiluteje)
        dec ind                                      
        ; Jei liekana ne nulis, kartojam rasymo cikla
        cmp al, 0                           
        jne rasom_2                         

        ; Nurodom eilutes spausdinimo funkcija                                            
	mov ah, 09h
	; I DX irasom pirmos eilutes adresa
	lea dx, Tekstas1                   
	; Ivykdom rasyma 
	int 21h         
	; Irasom antros eilutes adresa                    
	lea dx, Tekstas2              
	; Ir vel parasom       
	int 21h                             
                         
	; Gryztam i DOS             
 	mov ah, 4Ch                 
	int 21h                           
ENDS CSEG                                 
END START                                 
