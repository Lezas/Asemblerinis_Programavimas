stck segment stack
	DB 256 dup(0)
stck ends
data segment
	tekstas  DB "Ervin Milos teksto issaugojimas",10,13
	Pathname DB 'D:\TASM\output.txt',00
	FILEHAND DW 0  ;failo deskriptorius
	kl_tekstas DB "Failas nesukurtas arba kita klaida",10,13,'$'
	kl1_tekstas DB "Irasymo klaida",10,13,'$'
data ends	
code segment
assume ds:data, cs:code, ss:stck
start:
	mov ax,data
	mov ds,ax
	lea bx, tekstas
	lea cx, Pathname
	sub cx,bx
	push cx
	mov ah, 3ch
	mov cx, 00
	lea dx, Pathname
	int 21h
	JC Klaida
	mov FILEHAND, ax ;ax suformtuoja deskriptoriu
	mov bx, FILEHAND
	mov ah, 40h
	pop cx
	lea dx, tekstas
	int 21h
	JC Klaida
	cmp ax,cx
	JNE Klaida1
	mov ah, 3eh
	mov bx, FILEHAND
	int 21h
	JMP pabaiga
Klaida:
	mov ah, 09h
	lea dx,  kl_tekstas
	int 21h
	JMP pabaiga
Klaida1:
	mov ah,09h
	lea dx, kl1_tekstas
	int 21h
	JMP pabaiga
pabaiga:
	mov ah,4ch
	int 21h
code ends
end start	
	
	
