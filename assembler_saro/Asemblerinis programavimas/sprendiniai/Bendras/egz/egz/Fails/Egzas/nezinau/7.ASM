masm
model   small
.data
message db  'Masyvas ','$' 
message1 db 'Masyvo elementu suma: ','$'
message2 db ' Masyvo elementu vidurkis: ','$'
mas dw 1,3,2,'$'
sk db 3
sum dw 1 dup(0),'$'
vid db 1 dup(0),'$'
.stack  256h
.code
.486
main:   
mov     ax,@data
mov     ds,ax

mov     ah,9
lea     dx,message
int     21h

xor ax,ax
xor dl,dl
mov cx,3
mov esi,0

go:
add ax,mas[esi*2]
inc esi
loop go

add ax,30h
mov sum,ax

mov ah,9
lea dx,message1
int 21h

mov ah,9
lea dx,sum
int 21h

sub sum,30h
mov ax,sum 
div sk
add AL,30h 
mov vid,AL

mov ah,9
lea dx,message2
int 21h

mov ah,9
lea dx,vid
int 21h

mov ah,07h
int 21h

mov ah,4ch
int 21h

end main