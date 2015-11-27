
stekas segment stack                                
db 256 dup (0)                                           
stekas ends                                               
                                                                                                                                                          
duom segment 
pran db 'Darba atliko : Vidas Razmislevicius II-3/6',10,13,'$'                                  
bufout db "Failas111 hahaha "
buflen=$-bufout    
handle dw 0        
fname db "failas11.xls",0
fname2 db "failas22.doc",0
failas3 db "c:\tasm\temp\failas22.doc",0
dta db 43 dup (0)
abufin db 80 dup (" ")
naujas db "2a"
duom ends          
                   
prog segment       
assume cs:prog, ds:duom, ss:stekas
start:             
mov ax,duom        
mov ds,ax

mov ax,02h
int 10h          
;failo kurimas              
mov ah,3ch  ;failo kurimo komanda  
mov cx,0           
mov dx,offset fname
int 21h       
 ;irasymas i faila             
mov handle,ax 
mov ah,40h    ;irasymo komanda
mov bx,handle 
mov cx, buflen
mov dx,offset bufout
int 21h   
;failo uzdarymas
mov ah,3eh
mov bx,handle
int 21h  
;siaip mov ah,4ch uzdaro failus
mov ah,3dh ;atidaro faila
mov al,2 ;ir rasyti ir skaityti
mov dx,offset fname
int 21h  
mov handle,ax
mov ah,3fh;skaytymo komanda
mov bx,handle
mov cx,80
mov dx,offset abufin
int 21h  
mov cx,ax
mov ah,40h;irasymo komanda
mov bx,1                  
mov dx, offset abufin
int 21h  
;        
mov ah,3dh
mov al,2 
mov dx,offset fname
int 21h  
mov handle,ax
mov ah,42h;rezimo nustatymas(nuo pradzios skaiciuojami baitai ar nuo galo) 
mov al,0                                                                  
mov bx,handle                                                             
mov cx,0                                                                  
mov dx,8 
int 21h  
;irasymas i faila     
mov ah,40h
mov bx,handle
mov cx,2 
mov dx,offset naujas
int 21h  
;failo pavadinimo keitimas
push ds  
pop es   
mov ah,56h
mov dx,offset fname
mov di,offset fname2
int 21h  
         
;failo paieska
mov ah,1ah
mov dx,offset dta
int 21h  
          
mov ah,4eh
mov cx,0 
mov dx,offset failas3
int 21h

mov ah,09h
lea dx,pran
int 21h                                              
;ekrano uzlaikymas
mov ah,07h
int 21h                          
;programos baigimas          
mov ah,4ch
int 21h  
prog ends
end start