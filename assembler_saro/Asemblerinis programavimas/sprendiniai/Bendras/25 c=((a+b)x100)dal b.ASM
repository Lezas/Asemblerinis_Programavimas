stek segment stack                                                           
	db 256 dup(?)                                                        
stek ends                                                                    
                                                                             
duom segment                                                                 
autorius db 13, 10, 'Domas Puras, II-04/4', 13, 10, '$'
Pran1  db 10,13,'Iveskite a: ','$'        
Pran2  db 10,13,'Iveskite b: ','$'        
funkcija db 10,13,'Funkcija c=((a+b)*100)/b',10,13, '$'
atsakymas db 10,13, 'Atsakymas c= $'                                               
a dw ?                                    
b dw ?                                    
simtas dw 100                             
c dw ?                                    
;l db ?                                                                                                    
des db 10
temp db ?
db 'tmp:'
tmp db 10 dup (0)
db '$'
 	                                                               
;daliklis db 10
                                                                                                                    
duom ends                                                                    
                                                                             
progr segment                                                                
assume cs:progr,ds:duom,ss:stek                                              
                                                                             
start:                                                                       
mov ax, duom                                                                 
mov ds, ax                                                                    
                                                                             
;Isvalomas ekranas                                                                             
mov ax,0002h                                                                   
int 10h                                                                             
                                                                             
;I ekrana isvedamas autorius                                                                           
mov ah, 09h                                                                  
lea dx, autorius                                                             
int 21h                                                                      
 	                                                                     
;Isvedamos reiksmes                       
mov ah,09h                                
lea dx,pran1                              
int 21h                                   
                                                         
call ivedimas                             
mov a, ax                                 
                                                                   
mov ah,09h                                
lea dx,pran2                              
int 21h                                                                             
                                                          
call ivedimas                             
mov b, ax                                 
                                                                             
;Skaiciuojama funkcijos reiksme                                                                             
                                                                             
mov ah, 09h                               
lea dx, funkcija                          
int 21h                                   
                                                         
mov dx, 0                                                            
mov ax, a                                 
add ax, b ;a+b                            
mul simtas ;(a+b)*100                     
mov c,ax
                                                                             
div b ;((a+b)*100)/b
mov c,ax
                                                                                                                                                          
i_pabaiga:                                                                   
call isvedimas                            
                                                              
mov ah, 09h                               
lea dx, atsakymas                         
int 21h                                   
                                                                     
lea dx, tmp                               
add dx,2
int 21h
jmp galas

galas:    ;galas tai uzbaigimas ir gryzimas i DOS'a                                
mov ah,07h                                
int 21h                                   
mov ah, 4ch                               
int 21h     
                                                                                                        
;paprogrames                                                                   
ivedimas proc                                                            
mov si, 0                                 
                                                           
pradzia:                                                                     
mov ah, 08h ;ivedinesime pagal 08h komanda                                                         
int 21h                                   
cmp al, 13 ;lygina ar ne enteris          
je pabaiga ;jei enteris soka i pabaiga    
cmp al, 30h ;lygina ar tai skaicius ASCII lenteleje
jb pradzia ;jei maziau soka i pradzia      
cmp al, 39h ;lygina ar tai skaicius ASCII lenteleje
ja pradzia ;jei daugiau soka i pradzia     
                                                                             
;Ivestu duomenu atspausdinimas ekrane                                                          
mov dl, al                                
mov ah, 02h ;f-jos numeri 02h ikeliame i ah kad galetume iskviesti ja intruptu int 21h     
int 21h                                                                               
                                                                             
sub al, 30h ;atima                        
mov tmp[si], al ;i tmp[] irasome al (skaitmeni)
inc si ;padidina si reiksme vienetu                                                               
jmp pradzia                               
                                          
pabaiga:                                                                     
mov cx, si ;i cx ikelia skaiciaus skaitmenu kieki                                                          
sub cx, 1 ;atima is si 1                  
mov al, tmp[0]
mov dx, 00h
mov bx, 00h
mov ah, 00h
mov si, 00h
cmp cx, 0
je end1   ;if equal go to end1      
                                                                    
;Is skaitmenu kuriamas skaicius                                                                            
ciklas:                                                                      
mul des ;padaugina pirma skaiciaus skaitmeni is 10
mov bl, tmp[si+1] ;i bla ikeliame antra skaitmeni
add al, bl ;juos sudedame
inc si ;padidina si reiksme 1
loop ciklas ;ciklas vyks tiek kartu kiek yra cx registre
end1:                                                                       
ret
ivedimas endp             	
                                          
isvedimas proc                                                          
        mov si, 9                                                            
        mov ax, c ;i ax ikeliame rezultata                                                           
ciklas_2:                                                                    
        mov ah, 0                                                            
        div des    ;daliname is 10                                                          
        mov tmp[si-4], ah                                                    
        add tmp[si-4], 30h   ;masyvo skaitliukas                                                
        dec si    ;mazinam skaitliuka vienetu                                                           
        mov ah, 0                                                                                              
        cmp ah, al                                                           
       jb ciklas_2   ;jei maziau, kartojame cikla                                                               
        mov si, 7  ;isviso 7 zenklai                                                          
        mov cx, 3 ;kiek sk po kablelio                                                            
        mov tmp[6], 2Eh ;2Eh-yra taskas
ciklas_3:                                                                                                                         
add al, 30h  ;isikeliame nuli
mov tmp[si], al
mov al, ah
inc si  ;si padidinam vienetu
loop ciklas_3    ;kartojame cikla

                                                              
ret                                                                          
isvedimas endp                                                               
                                                                             
progr ends                                                                   
	end start       