
; steko segmentas
stekas		segment stack
	db 256	dup(0)
stekas 	ends
      
; duomenu segmentas
duomenys segment
; duomenys
 var_dydis	dw	30
 var_masyvas	dw	0,1,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
 var_rezult	dw	0
; ivairus pranesimai
zinute_0	db	'Uzduotis Nr. 13',10,13
		db	'Atliko: Dalia Mankauskaite',10,13
		db	'Uzduotis:',10,13          
		db	' Duotas 30 elementu masyvas (duomenu segmente).',10,13
		db	'Rasti didziausia sio masyvo elementa.',10,13
		db	'Gauta rezultata patalpinti atmintyje.',10,13,10,13,'$'
zinute_1	db	'Pradiniai duomenys:','$'
zinute_2	db	' masyvo dydis = ','$'
zinute_3	db	' masyvo elementai = (','$'
zinute_4	db	'    ','$'
zinute_5	db	', ','$'
zinute_6	db	')','$'
zinute_7	db	'Rezultatas:',10,13,'$'
zinute_8	db	' didziausias elementas = ','$'
zinute_9	db	' sio elemento indeksas (masyve) = ','$'
zinute_10	db	10,13,'<Paspauskite bet kuri klavisa>',10,13,'$'
rn		db	10,13,'$'
duomenys	ends
  
; kodo segmentas
programa	segment
 assume		cs:programa,ds:duomenys,ss:stekas,es:duomenys
start:                                                                               
; inicializuojame duomenu registrus
 			mov ax,duomenys
			mov ds,ax
			mov es,ax	   		; del viso pikto (nebutinas)
                                                                                                    
; paruosiame ekrana         
			mov ax,0002h
			int 10h
                            
; atspausdinu pranesima     
			mov ax,0900h
			lea dx,zinute_0
			int 21h

; atspausdinu pradinius duomenis
			mov ax,0900h
			lea dx,zinute_1
			int 21h

; atspausdinu var_dydis
			mov ax,0900h
			lea dx,zinute_2
			int 21h

			mov ax,var_dydis
			call atspausdink

			mov ax,0900h
			lea dx,rn
			int 21h

; atspausdinu var_masyvas
			mov ax,0900h
			lea dx,zinute_3
			int 21h

			xor bx,bx			; bx := 0

ciklas_var_mas:
			mov ax,bx			; ax := bx
			and ax,7			; ax := ax % 8
			cmp ax,0			; ax = 0 ?
			jne print_var_mas1	
			; jeigu nulis spausdinam pranesima

; nauja eilute
			mov ax,0900h
			lea dx,rn
			int 21h
; eilutes pradzia
			mov ax,0900h
			lea dx,zinute_4
			int 21h
print_var_mas1:
			mov ax,var_masyvas [bx]		; pasiimam elementa
			call atspausdink				; atspausdinam
			inc bx						; padidinam bx
			cmp bx,var_dydis			; bx = var_dydis ?
			jge ciklo_var_mas_pabaiga	; jei taip, iseinam is ciklo
                                                                                                              
			mov ax,0900h
			lea dx,zinute_5
			int 21h
                                                   
; jeigu iki cia atejo vykdymas, tada reikia kartoti cikla
			jmp ciklas_var_mas
                                                   
ciklo_var_mas_pabaiga:                             
			mov ax,0900h
			lea dx,zinute_6
			int 21h

			mov ax,0900h
			lea dx,rn
			int 21h

; apskaiciuoju rezultata
			mov ax,var_masyvas	; ax := var_masyvas [0]
			mov var_rezult,ax	; var_rezult := ax
			mov bx,1			; bx := 1

skaiciavimo_ciklas:
			mov ax,var_masyvas [bx]
			cmp ax,var_rezult
			jle nedidesnis
			mov var_rezult,ax
			mov dx,bx
nedidesnis:	cmp bx,var_dydis
		jl skaiciavimo_ciklas
		push dx
; atspausdinu pranesima
			mov ax,0900h
			lea dx,zinute_7
			int 21h
                                                   
; atspausdinu var_rezult                           
			mov ax,0900h
			lea dx,zinute_8
			int 21h
                                                   
			mov ax,var_rezult
			call atspausdink
                            
			mov ax,0900h
			lea dx,rn
			int 21h
                                                        
; atspausdinu var_rezult indeksa masyve                 
			mov ax,0900h
			lea dx,zinute_9
			int 21h
                                                        
			pop ax
			inc ax	; reikia padidinti indeksa, kad pirmo elemento numeris butu 1 o ne 0
			call atspausdink
                                                        
			mov ax,0900h
			lea dx,rn
			int 21h
                                                        
; atspausdinu pranesima                                 
			mov ax,0900h
			lea dx,zinute_10
			int 21h
                                                        
; palaukiam, kol vartotojas paspaus ka nors             
			mov ax,0700h
			int 21h
                                                        
; pasakom DOS'ui, kad programa baigia darba             
			mov ax,4c00h
			int 21h
                                                        
; procedura atspausdinanti desimtaini skaiciu ekrane    
; pats skaicius turi buti paduodamas ax registre        
atspausdink	proc                                    
; issaugokim del viso pikto registru reiksmes           
			push dx;padedama i steka
			push cx
			push bx
			push ax
                                          
; jeigu skaicius neigiamas, tada reikia papildomai pavargti
			cmp ax,0	; ax = 0 ?
			jge beminuso; jeigu ax >= 0 tada persokam kelias komandas
			xor dx,dx	; dx := 0
			mov dl,45			; dl := '-'
			mov ax,0200h		; 02h procedura
			int 21h				; 21h (DOS) interruptas
			pop ax	; pasiimam originalia ax reiksme
			push ax	; ir dar karta padedam ax reiksme i steka
			not ax		; (zr toliau)
			add ax,1	; ax := -ax
beminuso:                                                                                    
; pries pradedant skaiciuoti, nustatom skaitliuka (kiek is viso skaitmenu)                   
			xor cx,cx	; cx := 0
; kadangi imsime po viena skaitmeni, tai dalinti reikes is 10                                
			mov bx,10			; bx := 10
                                                                                             
; pirmas ciklas - isskaido skaiciu skaitmenimis                                              
ciklas1:                    
			mov dx,0	; dx := 0
			idiv bx		; ax = dx:ax / bx, dx = dx:ax % bx
			push dx		; issaugom liekana (<10)
			inc cx		; cx := cx + 1
			cmp ax,0	; ax = 0 ?
			jg ciklas1	; kartok cikla, jeigu ax > 0
                                                                                 
; antras ciklas - kiekviena skaitmeni pavercia ANSI simboliu ir parodo ekrane
ciklas2:
			pop dx	; pasiimam paskutine liekana
			dec cx	; cx := cx - 1
			mov ax,0200h
			add dx,30h
			int 21h
			cmp cx,0			; cx = 0 ?
			jg ciklas2			; kartok cikla, jeigu cx > 0
                            
; atstatom issaugotas registru reiksmes
			pop ax
			pop bx
			pop cx
			pop dx
                                                  
; gryztam i pagrindine programa
			ret 
atspausdink	endp        
programa	ends        
end start
