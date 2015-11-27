
_stack segment stack
        db 256 dup (?)       
_stack ends              
                         
_data segment            
        a_str db    10,13,'Iveskite a: $'
        b_str db    10,13,'Iveskite b: $'
	rez_str db  10,13,'int(12/ab): $'
	over_str db 10,13,'Byte overflow!$',10,13 
        
        a db 3 dup (?),'$',10,13;
        b db 3 dup (?),'$',10,13;


	number_a db 0
	number_b db 0


	dalmuo	 db 0
	daliklis db 0
	rez	 db 0,'$',10,13
          
	eile db 1
        base db 10
          
_data ends                      
                                
_code segment                   
        assume cs:_code, ds:_data, ss:_stack                                                    
_start:                         
        mov ax, _data                             
        mov ds, ax              
       
         mov ah,0002h
         int 10h
      
; uzklausimas a ;;;;;;;;;;;;;;;;;
        mov ah, 09h                          
        lea dx, a_str                          
        int 21h 
          
; skaitom skaiciu a
          
	mov si, 0
inputa:   
	mov ah, 08h       
	int 21h          
	  
	cmp al, 13        ; if enter goto process
	je endinput1
          
	cmp si, 3
	je endinput1 
	  
	cmp al, 30h       ; if al < ord('0') then pakiso siuksle, repeat read'a
	jb inputa
          
	cmp al, 39h       ; if al >ord('9') then pakiso siuksle, repeat read
	ja inputa
          
	mov dl, al        
	mov ah, 02h       ; rodome pati simboli
	int 21h          
                               
	mov a[si], al   
	inc si      
	jmp inputa
          
	; cia turim ascii skaiciu
endinput1:
          
; gaminames realu skaiciu a ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov di, si
	mov cx, si
do_digit_a:
	dec di
	mov al, eile
	mov bl, a[di]
	sub bl, 30h
	mul bl ; AX<- source *AL
	jc _overflow
	  
	add number_a, al   ; number+=eile
	jc _overflow
                    
	mov al, 10  
	mul eile    	; eile=eile*10
	mov eile, al                  
                                      
          
	loop do_digit_a               
             
        jmp bsimb
                                
_overflow:                      
	mov ah, 09h             
  	lea dx, over_str        
   	int 21h  
        jmp exit  
                                      
                                      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; uzklausimas b ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bsimb:               
        mov ah, 09h                          
        lea dx, b_str                          
        int 21h 
                
; skaitom skaiciu b
                
     	mov si, 0
inputb:          
	mov ah, 08h       
	int 21h          
	         
	cmp al, 13        ; if enter goto process
	je endinput2 
	         
	cmp si, 3
	je endinput2 
                 
	cmp al, 30h       ; if al < ord('0') then pakiso siuksle, repeat read'a
	jb inputb
	                
	cmp al, 39h       ; if al >ord('9') then pakiso siuksle, repeat read
	ja inputb
                 
	mov dl, al        
	mov ah, 02h       ; rodome pati simboli
	int 21h          
                               
	mov b[si], al   
	inc si      
	jmp inputb
          
	; cia turim ascii skaiciu
endinput2:
          
          
          
; gaminames realu skaiciu b ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eile, 1
	mov di, si
	mov cx, si
do_digit_b:                     
	dec di
	mov al, eile
	mov bl, b[di]
	sub bl, 30h
	mul bl ; AX<- source *AL
	jc _overflow
	  
	add number_b, al   ; number+=eile
	jc _overflow
          
	mov al, 10
	mul eile	; eile=eile*10
	mov eile, al
        
	loop do_digit_b
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
	mov al, number_a
	mul number_b
	jc _overflow
                                
	mov daliklis, al
	xor ax, ax
	mov al, 0ch	; 12 = Ch
	div daliklis
        
	mov rez, al
	add rez, 30h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
	mov ah, 09h
	lea dx, rez_str
	int 21h
          
	lea dx, rez
	int 21h
;	jmp e
             
exit:              
; happy pabaiga ;;;;;;;
mov ah, 07h
int 21h
        mov ah, 4ch            
        int 21h                 
_code ends                                           
end _start