stck segment stack
	DB 256 dup(0)
stck ends
data segment
	Pathname DB 'D:\TASM\readFile.txt',00
	FILEHAND DW 0  ;failo deskriptorius
	kl_tekstas DB "Failas nesukurtas arba kita klaida",10,13,'$'
	kl1_tekstas DB " klaida",10,13,'$'
	rezultatas DB 30 dup (' ')
data ends
code segment
assume ds:data, cs:code, ss:stck
start:
	mov ax,data
	mov ds,ax
	mov ah, 3dh
	mov al,00
	lea dx, Pathname
	int 21h
	JC Klaida
	mov FILEHAND, ax
	mov ah, 3fh ;3fh dx ir 21h susieti
	mov bx, FILEHAND
	mov cx, 30
	lea dx, rezultatas
	int 21h
	JC Klaida1
	mov ah, 3eh
	mov bx, FILEHAND
	int 21h
	jmp isvedimas
isvedimas:
	mov ah, 09h
	lea dx, rezultatas
	int 21h
	jmp pabaiga
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
	
