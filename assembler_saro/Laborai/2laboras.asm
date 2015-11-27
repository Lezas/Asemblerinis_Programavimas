stekas segment stack
db 256 dup(?) 
stekas ends
duomenys segment
  
duomenys ends                                
program segment                              
assume cs:program, ds:duomenys, ss:stekas    
 start:                                      
 
mov ax, 0002h    ;isvalom ekrana 
int 10h        

 mov AX, 0F000h		;segmentinis adresas Bios
 mov DS, AX		;perduodam adresa i DS registra
 mov AH, 40H		;isvedimo i ekrana funkcija
 mov BX,1		;ekrano deskriptorius
 mov CX, 8		;isvesti 8 simbolius
 mov DX, 0FFF5h		;persokam prie isvedamos eilutes
 int 21h		;DOS iskvietimas
                       
mov ah, 4ch                                 
int 21h                                      
program ends                                 
end start