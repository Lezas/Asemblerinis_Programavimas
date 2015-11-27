.386 ;su dvigubais registrias
stekas segment stack use16 
db 256 dup(?)
stekas ends
     cr equ 13 ;konstantai prioskiria reiksme
     lf equ 10    
duomenys segment use16                          
uzduotis db 'Darba atliko Ruta Jasulaityte II-3/2 Su slankiuoju kableliu:', 13,10
         db 'a=-1,2 b=15,7  a+b=','$'
a dq -1.2 ;keturgubas zodis
b dq 15.7  
desimt dd 10 ;dvidubas
ats db 10 dup (0) , cr,lf ,'$'
tikslumas dq 100.0 ;kiek bus kablelio
suma dd 0  
duomenys ends
prg segment use16
assume cs:prg, ds:duomenys, ss:stekas

start:            
mov ax,duomenys   
mov ds,ax         
mov ax,0002h ;ekrano valymas       
int 10h 
mov ah, 09h
lea dx, uzduotis
int 21h   
           
;koprocesoriaus darbas, jis turi savo steka, is 8 skilciu(nulinej skilty)
fld a; a reiksme uzkraunama i steka es (f del to kad koprocesoriu)                 
fld b; b---------------''-------------------
fadd ;ats bus a
fmul tikslumas   
 
  fistp suma; rezas issuagomas atmintyje 
  mov eax,suma ; e del dvigubu registru
  xor edx, edx
  ;1* or 0=1
  ;1* or 1=0
  ;0*or0=0 
  mov di, 10

  desimtaine:
  div desimt
  add dl,30h
  mov ats[di],dl
  xor dx,dx
  cmp al,0 
  je pabaiga

   dec di  
   cmp di,8
   je kablelis
   jmp desimtaine

   kablelis:
   mov ats[di],','
   dec di ;padidinja vianetu
   jmp desimtaine

   pabaiga:
mov ah,09h  
lea dx, ats
int 21h
                              
mov ah,07h                    
int 21h                       
                              
mov ah,4ch                    
int 21h                       
                              
prg ends   
end start