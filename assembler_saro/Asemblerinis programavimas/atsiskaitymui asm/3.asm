stekas segment stack
        db 256 dup(?)
stekas ends

         
;Duomenu segmentas
duomenys segment

MatricaA db 33,2,3,4         
         db 5,50,7,8         
         db 4,3,80,1
         db 8,7,6,5,'$'
		
MatricaB db 4,0,1,2
		 db 4,10,4,6
		 db 3,2,50,0
		 db 7,6,5,4,'$'
		 
   suma dw 0   
   dydis dw 10    
   simbolis db ' $'                    
tarpinis db 0,'$'
    
duomenys ends              
               
programa segment           
         assume cs:programa, ds:duomenys, ss:stekas

rezultatas proc                      
        mov cx, 0                    
push_sk:                             
        mov dx, 0                    
        div dydis                     
        add dx, 30h                  
        push dx                      
        inc cx                       
        cmp ax, 0                    
        jne push_sk                  
pop_sk:                              
        mov ah, 09h                  
        pop dx                       
        mov tarpinis, dl                 
        lea dx, tarpinis                 
        int 21h                      
        loop pop_sk                  
        ret                          
rezultatas endp

start:                 
        mov ax, duomenys   
        mov ds, ax         

		mov ax, 0002h
   	    int 10h     
                           
        mov cx, 4
        mov bx, 0                  
                           
Outer:  

	push cx
	mov  cx, 4
	mov  si, 0
	Inner:
        mov ah, 0          
        mov al, MatricaA[bx][si] ;Pirmas matricos elementas
        mov suma, ax
		
		mov ah, 0
		mov al, MatricaB[bx][si] ;Antras matricos elementas
		sub suma, ax
		
		push cx
		mov ax, suma
		call rezultatas
		lea dx,simbolis
		
		mov ah, 09h
        int 21h
		pop cx
		inc si
		
	loop Inner
	
		pop cx
        add bx, 4

		push dx
		mov ah, 02
		mov dl, 0DH
		int 21h
		mov dl, 0AH
		int 21H
		pop dx

loop Outer                
         
                        

;Atsakymo isvedimas 
        

       
        
        mov ax, 0100h
    	int 21h

    	mov ax, 4c00h
    	int 21h
programa ends  
         end start               
        
