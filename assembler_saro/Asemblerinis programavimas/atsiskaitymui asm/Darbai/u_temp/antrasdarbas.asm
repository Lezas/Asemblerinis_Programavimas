dseg segment
str10 db 'prasome ivesti 2 skaicius',0ah,0dh,'$'
pir_did db 'pirmas skaicius didesnis uz antra',0ah,0dh,'$'
an_did db 'antras skaicius didesnis uz pirma',0ah,0dh,'$'
jie_lygus db 'skaiciai lygus ',0ah,0dh,'$'
skirtumas db 'skirtumas=','$'
ar_kartoti db 'jei norite iseiti is programos spauskite * kitaip spauskite bet ka',0ah,0dh,'$'
pirmas_skaicius db 0
antras_skaicius db 0
dseg ends

sseg segment stack
dw 200h dup(?)
sseg ends


cseg segment 
assume cs seg,ss:sseg,ds:dseg
main:
again:
mov ax,dseg
mov ds,ax
mov dx,offset str1
mov ah,9
int 21h

mov ah,1
int 21h
mov bl,al
sub bl,30h
mov pirmas_skaicius,al

mov ah,1
int 21h
mov antras_skaicius,al
sub al,30h
mov dx,offset new_line
mov ah,9
int 21h

mov dl,pirmas_skaicius
mov ah,2
int 21h
mov ah,9
int 21h
----------
mov dx,offset new_line
mov ah,9
int 21h

mov dl,antras_skaicius
mov ah,2
int 21h
mov ah,9
int 21h

---------------




mov bl,pirmas_skaicius
mov al,antras_skaicius
sub al,bl
cmp al,00h
jz lygus
mov al,antras_skaicius
mov bl,pirmas_skaicius
cmp al,bl
ja tut
mov al,pirmas_skaicius
mov bl,antras_skaicius
sub al,bl
mov cl,al
add cl,30h
mov ax,desg
mov ds,ax
mov dx,offset pir_did
mov ah,9
int 21h
mov dx,offset skirtumas
mov ah,9
int 21h

mov dl,cl
mov ah,2
int 21h
mov dxoffset new_line
mov ah,9
int 21h
jmp ee
tut:
sub al,bl
mov cl,al
add cl,30h
mov ax,dseg
mov ds,ax

mov dx,offset an_did
mov ah,9
int 21h
mov dx,offset skirtumas
mov ah,9
int 21h

mov dl,2dh
mov ah,2
int 21h

mov dx,offset new_line
mov ah,9
int 21h
ee:
jmp next
lygus: mov cl,al
mov dx,offset jie_lygus
mov ah,9
int 21h

mov dx,offset skirtumas
mov ah,9
int 21h
mov dl,cl
add dl,30h
mov ah,2
int 21h
mov dx,offset new_line
mov ah,9
int 21h

jmp next
next:
clc
movdx,offset ar_kartoti
mov ah,9
int 21h
mov ah,1
int 21h
cmp al,'*'
je galas
mov dx,offset new_line
mov ah,9
int 21h
jmp again:
galas:
mov dl,33h
mov ah,2
int 21h
mov al,36h
mov bl,39h
sub al,bl
mov ch,00h
mov cl,al
mov ax,127
sub ax,cx
add al,30h
mov dl,al
mov ah,2
int 21h
mov ah,4ch
int 21h
cseg ends
end main









































































