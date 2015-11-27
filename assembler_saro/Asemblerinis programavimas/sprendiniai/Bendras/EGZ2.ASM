;Atliko: Oleg Makarenko, II-2/5   
Stekas Segment Stack
	db 256 dup (?)
Stekas ends
         
Duomenys Segment
        a       db ?
        b       db ?
        c       db ?
	ibuf	db 5,?,5 dup(?)
	rzlt	db 5 dup(0),'$'
	rz      db 0,'$'
	msg1	db 10,13,'Formule x=(b+c)/5   (a,b,c tarp -128 ir 127)','$'
	msg3	db 10,13,'b: ','$'
	msg4	db 10,13,'c: ','$'
	merr   	db 'skaiciaus klaida ( [-128, 127] )','$'
	msg5    db 10,13,'Rezultatas: ','$'
	desi	db 10
Duomenys ends


Programa Segment                  
	Assume SS:Stekas, DS:Duomenys, CS:Programa

;	IVEDIMO CIKLAS		;
	mov ax,Duomenys
	mov ds,ax
 	mov ax,0002h       
	int 10h


	mov ax,0900h
	lea dx,msg1
	int 21h
	
        
              
     	lea dx,msg3
	call ived
        mov b,al

	lea dx,msg4
	call ived
	mov c,al


