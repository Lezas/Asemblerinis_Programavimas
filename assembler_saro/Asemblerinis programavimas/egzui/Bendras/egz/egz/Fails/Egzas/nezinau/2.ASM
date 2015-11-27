masm
model small
.data
message db    'Aleksandr	Koviakov II-2/1. 3 skaiciu suma 10+9+8 $'
     a dw 10
     b dw 9
     c dw 8
 .stack  256h
    .code
main    proc   
xor bx,bx
mov bx,a
add bx,b
add bx,c
mov c,bx
mov     ax,@data
mov     ds,ax
mov     ah,9
mov     dx,bx
 int     21h
     main    endp
     end     main
