 stekas segment stack
db 256 dup(0)   
stekas ends     
cr equ 13       
lf equ 10       
duomenys segment
	mas db 13,45,78,6,3,5,2,78,21,45,87,98,68,1,23,47,19,35,84,13,1,45,4,5,98,'$'
	a db '$$$$'
	suma dw '$$'
      
pran    db cr,lf
	db 'II-2/3, laboratorinis darbas Nr.7',cr,lf
        db 'Ramune Atroskaite',cr,lf
	db 'Programa skaiciuoja 25 elementu masyvo suma, vidurki,',cr,lf
	db '6 ir 9 elementu sandauga bei 7 ir 23 skirtuma.',cr,lf
	db cr,lf
        db 'Suma: ','$'	
pran3	db ,cr,lf,'$'
pranv1	db 'Vidurkio sveika dalis: ', '$'
pranv2	db ', vidurkio liekana: ', '$'
prandg  db 'Sesto ir devinto elementu sandauga: $'
pransk  db 'Septinto ir dvidesimt trecio elementu skirtumas: $',cr,lf
taskas	db '.','$'
ats     db 'Atsakymas: ',cr,lf,'$'
                       
                
duomenys ends 
programa segment
assume cs:programa, ds: duomenys, ss:stekas

spausd proc
	mov ah,09h
	int 21h
ret
spausd endp

start:        
;inicializavimas
	mov ax, duomenys
	mov ds,ax
;ekrano sutvarkymas
	mov ax, 0002h
	int 10h
              
; pranesimo isvedimas:
	lea dx, pran
	call spausd
; skaiciavimai
	mov cx,25
	mov bl,0	
	mov dx,0000h
	mov ax,0000h
cikl:
	mov al,mas[bx]
	add dx,ax
	inc bl
	loop cikl
	mov suma, dx

; suma yra DX
	mov bl,100
	mov ax,dx
	div bl
	mov ch,ah

; isvedam pirma skaiciu
	add al,30h
	mov a, al
	lea dx, a
	call spausd
; antras ir trecias skaiciai
	mov ax,0000h
	mov al,ch
	mov bl,10
	div bl
	mov ch,ah
; spausdinami 2 3 skiaciai
	add al,30h
	mov a, al
	lea dx, a
	call spausd

	add ch,30h
	mov a, ch
	lea dx, a
	call spausd

	lea dx, pran3
	call spausd

; skaiciuojam vidurki
	mov ax,suma
	mov bl,25
	div bl

; vidurkio isvedimas
	mov cx,ax	
	
	lea dx, pranv1
	call spausd


	mov ax,0000h
	mov al,cl
	mov bl,10
	div bl
	mov cl,ah
	add al,30h

	mov a, al
	lea dx, a
	call spausd
	
	add cl,30h
	mov a, cl
	lea dx, a
	call spausd

	lea dx, pranv2
	call spausd
; liekanos spausdinimas
	mov ax,0000h
	mov al,ch
	mov bl,10
	div bl
	mov cl,ah
	add al,30h

	mov a, al
	lea dx, a
	call spausd
	
	add cl,30h
	mov a, cl
	lea dx, a
	call spausd

	lea dx, pran3
	call spausd

	lea dx, prandg
	call spausd

; sesto ir devinto elementu sandauga
	mov al, mas[5]
	mul mas[8]
; ju isvedimas	
	mov bl,100
	div bl
	mov ch,ah ; issaugom
	
	add al,30h
	mov a,al
	lea dx, a
	call spausd
	
	mov ax,0000h
	mov al,ch
	mov bl,10 
	div bl
	mov ch,ah

	add al,30h
	mov a,al
	lea dx, a
	call spausd

	add ch,30h
	mov a,ch
	lea dx, a
	call spausd

	lea dx, pran3
	call spausd

; cia jau prie kito
	lea dx, pransk
	call spausd


; 7 ir 23 elementu skirtumas
	mov bl,mas[6]
	sub bl,mas[22]
	mov ax,100h
	sub ax,bx
        	
; spausdinimas

        add al,30h
	mov a,2Dh
	mov a[1],al
	mov a[2],24h
	lea dx, a
	call spausd


; programos pabaiga
	lea dx, pran3
	call spausd
	mov ah, 07h
	int 21h
	mov ah,4ch
	int 21h
programa ends
end start