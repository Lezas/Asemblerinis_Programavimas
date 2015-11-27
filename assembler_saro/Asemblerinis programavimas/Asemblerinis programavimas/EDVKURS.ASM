                                                                                                            
stekas segment stack                                                                                     
db 256 dup (?)                                                                                                  
stekas ends                                                                                                     
duomenys segment ; use16                                                                                         
    		; BENDRAS                                                                                       
info    db '   Pasirinkite norima punkta  ',10,13                                                               
      	db '1. Kubo turio skaiciavimas',10,13                                                                   
     	db '2. Masyvo ivedimas ir isvedimas i ekrana',10,13                                                                          
	db '3. Darbo pabaiga',10,13,'$'                                                                         
                                                                                                                
men_kl  db 'Blogas pasirinkimas',10,13,'$'                                                                      
uzlaikymas      db ' ',10,13,10,13,'$'                                                                              
                                                                                                                
                                                                                                                                                                                                                    
 			;Masyvo meniu                                                                   
uzd_m   db '-------------MASYVAS-------------',10,13                                                            
        db 'Isveda i ekrana suvesta masyva',10,13,'$'                                       
el_ived db 'Suveskite 3x3 masyvo elementus',10,13,'$'                                                         
i_el	db '',10,13,'$'                                                                                         
ives_m   db 'Jus ivedete toki masyva:',10,13,'$'                                                                         
                                                                      
      	       		; Kubo meniu                                                                
uzd_s db 10,13,'--------------KUBO TURIS--------------',10,13,10,13                                                                 
            db 'Krastiniu ilgiai:  a=4.0 , b=3.0, c=5.0 ',10,13,'$'                                             
turis       db 'Duomenys issaugoti textiniame faile rezultat.txt',10,13
      db 10,13,' Staciakampio gretasienio turis:=','$'   		;Masyvo Duom                                                                            
IVSR       db 2, ?, 2 dup(0),'$'                                                                                
ivedimas   db 5,?,5 dup(' ')                                                                                    
tenb       db 10                                                                                                
ats        db 5 dup(0),'$'                                                                                      
i 	   db 3,'$'   ;eilutes                                                                                  
j          db 3,'$'   ;Stulpeliai                                                                               
twob       db 2                                                                                                 
duom       dw 3 dup(3 dup(?))                                                                                                                                                                     
f_res 	   db  'c:\tasm\temp\rezultat.txt',0                                                                      
f_dis      dw  0                                                                                                
stabd      db 10,13,'$'                                                                                         
tmp        db 1                                                                                                 
       	    		; Aprasomi turio duomenys                                                                            
a   dq 4.0                                                                                                                   
b   dq 3.0                                                                                                                   
c   dq 5.0                                                                                                                   
rez dd 0                                                                                                                     
simt dd 100.0                                                                                                                
desimt dd 10                                                                                                                 
atsilg db 5 dup(?),10,13,'$'                                                                                                 
duomenys ends                                                                                                                
                                                                                                                             
programa segment                                                                                                        
assume ss:stekas, ds:duomenys, cs:programa                                                                                   
.386                                                                                                                         
start:	                                                                                                                     
		       	;Bendro Meniu isvedimas                                                                              
        mov ax, duomenys                                                                                                     
	mov ds, ax                                                                                                           
	pagrindinis:                                                                                                         
	call meniu                                                                                                           
	cmp ah,31h                                                                                                           
	je  slankus                                                                                                          
	cmp ah,32h                                                                                                           
	je  masyvas                                                                                                          
	cmp ah,33h                                                                                                           
	JE pabaiga                                                                                                           
	call ekr_val                                                                                                         
	lea dx,men_kl                                                                                                        
	call i_ekr                                                                                                           
	call ekr_uzlaik                                                                                                      
	jmp pagrindinis                                                                                                      
	pabaiga:                                                                                                             
          call exit                                                              
slankus: 	       	                                                                              
	call ekr_val             
	lea dx,uzd_s                                                                            	        
call i_ekr                       
	;Skaiciavimas            
	fld  a                   
	fmul b                   
	fmul c                   
	fmul simt                
	fistp rez       ;is steko virsunes i atminti
	mov eax, rez             
mov edx, 0                                                                              	                
mov si,5                                                                                                        
desimtaine:                                                                                                     
	div desimt                                                                              	        
add dl,30h                                                                                                      
mov atsilg[si], dl                                                                                              
dec si                                                                                                          
xor dx,dx                                                                                                       
cmp al, 0                                                                                                       
je pabaiga1                                                                                                     
cmp si, 3                                                                                                       
je kablelis                                                                                                     
jmp desimtaine                                                                                                  
kablelis:                                                                                                       
mov atsilg[si],2ch                                                                                              
dec si                                                                                                          
jmp desimtaine                                                                                                  
pabaiga1:                        
	;Slankaus Rezultatu isvedimas                                                                                  
       lea dx,turis                                                                                             
call i_ekr                                                                                                      
lea dx, atsilg                                                                                                  
call i_ekr                                                                                                      
lea dx,uzlaikymas                                                                                               
call i_ekr                                                                                                      
call ekr_uzlaik                                                                                                 
jmp failas	       	      	 
			;Masyvas 
masyvas:                         
			;Masyvo Meniu                                                                   
 call ekr_val                    
 lea dx,uzd_m                    
 call i_ekr                      
lea dx,el_ived                   
call i_ekr                       
   		; MASYVO IVEDIMAS
MOV CX,0                        
Loopi:                                                                
   Loopj:                          
Lea DX,i_el                        
call i_ekr                         
  PUSH CX                       
  CALL SkIvedimas 	; GRAZINAMA REIKSME DX REGISTRE                                       
  POP CX                                                              
  MOV AL,CH                        
  MUL j                                                                 
  MUL twob                                                  
  MOV BX,AX        ;nusisiuncia eilutes reiksme i bh                                                            
  MOV AL,CL        ;nusisiuncia stulpelio reiksme i al                                                   
  MUL twob                         
  MOV DI,AX                                                
  MOV Duom[BX][DI],DX ; MASYVO EL PRISKYRIMAS              
  INC CL                                                   
 CMP CL,j    ;lygina ar jau baigesi eilute                  
 JNE Loopj                                                 
 MOV CL,0    ;griztam i eilutes pradzia po to einam i kita eilute
 INC CH                                                          
CMP CH,i                                                         
JNE Loopi       ; Masyvo Isvedimas ir rezultatu irasymas
                                
call ekr_val                    
lea dx,ives_m                   
call i_ekr                      
                                
MOV CX,0                                          
Loopi2:                         
 Loopj2:                        
  ;Skaiciuoja indeksus                                                                     
  PUSH CX                       
  MOV AL,CH                                             
  MUL j                                                 
  MUL twob                                               
  MOV BX,AX                                             
  MOV AL,CL                                             
  MUL twob                                               
  MOV DI,AX                                      
  LEA DI,Duom[BX][DI]           
  CALL SkIsvedimas              
  POP CX                        
  mov ah,09h                    
  lea dx, ats                                 
  int 21h                                     
 INC CL                               
 CMP CL,j                       
 JNE Loopj2                     
 mov ah,09h                     
 lea dx, stabd                                                                                                  
 int 21h                        
 MOV CL,0                       
 INC CH                         
 CMP tmp,0                      
 JNE JmpTmp1                    
  MOV TMP,1                     
  JMP JmpTmp2                   
 JmpTmp1:                            
  MOV TMP,0                          
 JmpTmp2:                            
CMP CH,i                                                                                                                              
JNE Loopi2                                                                                                                            
  ;pabaiga                                                                                                          
call ekr_uzlaik                                                                                                                       
failas:                                                                                                                               
LEA DI,f_res           ; Failo Atidarymas ir Irasymas i ji                                                                            
LEA SI,f_dis                                                                                                                          
call f_open                                                                                                                           
                                                                                                                                      
         mov ah,40h                                                                                                                   
         mov bx,f_dis                                                                                                                 
         lea dx,turis[0]    ;isveda eilute faile                                                                                         
 	 mov cx,85	       	                                                                                                      
	 INT 21h                                                                                                                      
         mov ah,40h                                                                                                                   
         mov bx,f_dis                                                                                                                 
	 lea dx, atsilg                                                                                                               
	 Mov Cx,7                                                                                                                     
         INT 21h                                                                                                                      
         mov ah,40h                                                                                                                   
         mov bx,f_dis                                                                                                                 
         lea dx,stabd                                                                                                                 
	 mov Cx,1                                                                                                                     
         INT 21h                                                                                                                      
                                                                                                                                      
	 mov ah,3eh           ; Failo uzdarymas                                                                                       
         mov bx,f_dis                                                                                                                 
         int 21h                                                                                                                      
	 jmp pagrindinis                                                                                                              
                                                                                                                                      
             	         
                                                                              
                                                                                                                                      
      		        ;Isvedimas i Ekrana                                                                                                  
i_ekr proc                                                                                                                            
        mov ah, 09h                                                                                                                   
        int 21h                                                                                                                       
        ret                                                                                                                           
endp i_ekr                                                                                                                            
                                                                                                                                      
ekr_uzlaik proc         ;ekrano sustabdymas                                                                                                              
        mov ah, 07h                                                                                                                   
        int 21h                                                                                                                       
	lea dx,uzlaikymas                                                                                                             
	call i_ekr                                                                                                                    
        ret                                                                                                                           
endp ekr_uzlaik                                                                                                                       
                        ;Ekrano Isvalymas                                                                                               
ekr_val proc                                                                                                                          
        mov ax, 02h                                                                                                                   
        int 10h                                                                                                                       
        mov ax, 0                                                                                                                     
        ret                                                                                                                           
endp ekr_val                                                                                                                                                                                                            
                        ;Meniu isvedimas                                                     
meniu proc                                                                     
 	call ekr_val                                                           
	lea dx,info                                                            
	call i_ekr                                                             
	call ived                                                              
	ret                                                                    
endp meniu	                                                               
  		     ; Meniu pasirinkimas              
ived proc                                                                      
  mov ah,0ah                                                                   
  lea dx,ivsr                                                                  
  int 21h                                                                      
  lea bx,ivsr+2                                                                
  mov ah,[bx]                                                                  
  ret                                                                          
ived endp                                                                      
			; Masyvo sk Ivedimas bei tikrinimas                    
SkIvedimas PROC                                                           
        mov ah,0Ah                                                                                              
        lea dx,ivedimas                                                        
        int 21h                                                                
        mov cl,byte ptr ivedimas[1]       ; pakeicia i byte               
        mov ch,0                                                               
        mov si,1                                                               
        mov bx,0                                                               
        mov dl,0                                                               
        IvCicle:                                                               
        inc si                                                                 
        mov al,ivedimas[si]                                                    
        cmp si,2                                                               
        jne vykdyti                                          
        cmp AL,2Dh   ; tikrina ar yra minusas              
        jne vykdyti                                          
        MOV DL,1                                           
        jmp vykdyti2                                           
                                                                               
        vykdyti:                                                                 
        mov ah,0                                                               
        sub ax,30h                                                                                              
        add bx,ax                                                              
        cmp cx,1                                                               
        je vykdyti2                                                                
         mov ax,bx                                                             
         mul tenb                                                              
         mov bx,ax                                                             
                                                                               
        vykdyti2:                                                                  
        mov ivedimas[si],byte ptr 0                                                     
        loop IvCicle                                                           
        CMP DL,0                                                               
        je vykdyti3                                                               
        neg bx     ; keicia operando zenkla                                    
                                                                               
        vykdyti3:                                                                 
       	MOV DX,BX                                                              
        RET                                                
  SkIvedimas ENDP                                                              
                                                                               
	       	      	 ; Masyvo Sk konvertavimas ir ivedimas                                                  
SkIsvedimas PROC                                                                                           
MOV CX,5                                                                                                        
MOV BX,4                                                                                                        
MOV AX,[DI]                                                                                                     
MOV DL,0                                                                       
CMP AX,0 ; Ar neigiamas                                                        
JGE SkIsvLoop                                                                  
MOV DL,1 ; isimena zenkla                                                 
NEG AX                                                                         
                                                                               
SkIsvLoop:                                                                     
 DIV tenb                                                                      
 ADD AH,30h                                                                    
 MOV ats[BX],AH                                                                
 MOV AH,0                                                                      
 DEC BX                                                                        
Loop SkIsvLoop                                     
MOV CX,3                                                                       
MOV BX,0                                                                       
MOV ats[BX],' '                                                                                                 
SkIsvLoop2:                                                                    
 INC BX                                                                        
 CMP byte ptr ats[BX],30h                                                             
 JNE OutLoop                                                                   
 MOV ats[BX],' '                                                               
LOOP SkIsvLoop2                                                                
OutLoop:                                                                       
CMP DL,0                                                                       
JE Skipp                                                                       
DEC BX                                                                         
MOV byte ptr ats[BX],'-'                                                       
Skipp:                                                                         
RET                                                                            
SkIsvedimas ENDP                                                    
			; Darbas su Failais                         
f_open PROC NEAR                                   
	 PUSH AX                                   
	 PUSH DX                                   
	 PUSH CX                                   
	 mov ah,3ch   ;Failo sukurimas             
	 mov cx,0                                  
	 MOV dx,DI                                 
	 int 21h                                                                                             
         mov ah,3dh   ; Failo atidarymas                                        
         mov al,2                                                   
         MOV dx,DI                                                  
         int 21h                                                    
         MOV [SI],AX                                                
         POP CX                                                     
         POP DX                                                     
         POP AX                                                     
RET                                                                 
f_open ENDP                                        
                                                   
		; Isejimas is programos  
		exit proc
		call ekr_val
		mov ah, 4ch
		int 21h
		ret
		endp exit      
                                                                     
programa ends                                                                  
end start                                          