;apskaiciuoti lygti x=(a^2+b)-c
;a=4 b=8 c=11 dal=10 masyvas is 3 elementu
;veiksmai atliekami registre AL
;dec- komanda, dec si 
; miv si,2
;dec si
;s=1
;zyme:
;***********
;cmp al,0
;je zyme2
;jmp zyme
;zyme2:


STEKAS SEGMENT STACK
     DB 256 DUP(?)
STEKAS ENDS     
                
DUOM SEGMENT
   dal db 10
   a db 4
   b db 8
   c db 11
   ats db 3 dup(0), '$'
DUOM ENDS   
    
PROG SEGMENT    
assume cs:prog, ds:duom, ss:stekas  
start: 
  mov ax, duom
  mov ds,ax
  
mov ax,0002h
int 10h

  mov al,a
  mul a

add al, b
sub al, c

mov si,2

atsakymas:  ;zyme
div dal ;dalinam al is 10

add ah,30h
mov ats[si],ah

dec si

mov ah,0

cmp al,0 ;lyginimo komanda
je isvedimas   

jmp atsakymas

isvedimas:

mov ah,09h
lea DX, ats
int 21h

mov ah,07h
int 21h
       
mov ah,4ch
int 21h         
          
   PROG ENDS      
end START 