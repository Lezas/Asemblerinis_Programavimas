;----------------------------------------------------------------------------
; Tomas Pukelis FMu-3                                                       -
; THE TERM WORK                                                             -
; Task: Input 3x3 matrix from the keyboard and calculate the determinatn    -
;       Output the result to the screen					    -        
;----------------------------------------------------------------------------
.model small                        
.stack                              
.data                               
  
    array db 3 dup (0)                
        db 3 dup (0)                
        db 3 dup (0)   
  
  detMessage db 13, 10, "Determinant is equal to: ","$"
  space db " ", "$"
  endl  db 13, 10, "$" 
  
  

        
            
.code                               
                                    
main proc                                             
  mov ax, seg space
  mov ds, ax
  
  xor cx, cx      ;Input of an array
  lea dx, array                     
                                    
  fillArray:                        
    call DECIN                      
    mov al, bl                      
    mov bx, dx                      
    add bx, cx                      
    mov [bx],al                     
    
    push ax
    push dx
    mov ah, 09       ; print space
    lea dx, space    ;
    int 21h          ;
          
    mov dl, 3
    mov ax, cx
    inc ax
    div dl
    cmp ah, 0
    je giveLine
               
  goOn:
    pop dx
    pop ax
    
    inc cx                          
    cmp cx, 9                       
  jne fillArray   ;                 
    
  jmp det
         
  giveLine:
    mov ah, 09
    lea dx, endl
    int 21h
  jmp goOn
         
  det:
  mov ah, 09
  lea dx, detMessage
  int 21h
  
  
  mov ax, 0001h   ;calculate the determinant
  xor dx, dx                        
                                    
  imul array                        
  imul array+4                      
  imul array+8                      
  add dx, ax                        
  mov ax, 0001h                     
               
  imul array+3 
  imul array+7 
  imul array+2 
  add dx, ax   
  mov ax, 0001h
               
  imul array+1 
  imul array+5 
  imul array+6 
  add dx, ax   
  mov ax, 0001h   
               
  imul array+2 
  imul array+4 
  imul array+6 
  sub dx, ax   
  mov ax, 0001h   
               
  imul array+1 
  imul array+3 
  imul array+8 
  sub dx, ax   
  mov ax, 0001h   
               
  imul array+7 
  imul array+5 
  imul array   
  sub dx, ax    ;end of calcultation of determinant
               
  mov ax, dx   
  cmp ax, 0
  jnl proceed
  
  push ax
  mov ah, 02
  mov dl,"-"
  int 21h
  pop ax
  mov dx, -1
  imul dx        
          
  proceed:             
  call DECOUT ; output the result
               
               
               
                  
  mov ax, 4c00h
  int 21h                         
main endp                   
                            
;-----------------------------------------------------------------------------
DECIN   PROC                                       
; In :  none                                       
; Out:  bl                                         
; Uses: None                                       
; gets number from the user (keybord) and stores it in BL    
;-----------------------------------------------------------------------------                                  ;Gets number from user and puts it in BL                                                
        push ax
        push dx
        mov bl, 0
        mov dl, 0
        mov dh, 10                                  
iv_prad:                                           
        mov ah, 08h   ; catch character to al         
        int 21h       ;                            
                                                   
        cmp al, 13    ; filter numbers from other characters         
        je iv_pab     ;                            
        cmp al, '0'   ;                            
        jb iv_prad    ;                            
        cmp al, '9'   ;                            
        ja iv_prad    ;                            
                                                   
        mov ah,02h    ; show catched character          
        mov dl,al     ;                            
        int 21h       ;                            
                                                   
        sub al, 48    ; convert asci to number        
                                                   
        mov dl, al    ; BL=BL*10+AL
        mov al, bl    ;                            
        mul dh        ;                            
        add al, dl    ;
        mov bl, al    ;                            
                                                   
        xor al, al                                 
        jmp iv_prad                                
iv_pab:                                            
        pop dx
        pop ax
        ret                                        
DECIN endp    
              
;-----------------------------------------------------------------------------
DECOUT   PROC                   
; In :  AX                      
; Out:  none                    
; Uses: None                    
; Converts a number in AX to decimal format and outputs it to the screen
;-----------------------------------------------------------------------------
  push  ax                             ;keep registers
  push  bx                      
  push  cx                
  push  dx                
                          
  xor   cx,cx                          ;POP counter
  mov   bx,10                          ;divide by 10d == 0Ah
decloop:                  
  xor   dx,dx                          ;high 16 bits zero.
  div   bx                             ;remainder in DX, quotient in AX
  inc   cx                             ;increase POP counter
  push  dx                             ;and PUSH
  cmp   ax,0                           ;is quotient zero?
  jnz   decloop                        ;if not, get one more number
                          
  mov   ah,02             
poploop:                  
  pop   dx                             ;get number
  add   dl,48                          ;add ASCII base (48="0")
  int   21h                            ;and display
  dec   cx                             ; -loop
  jnz   poploop                        ;/
                          
  ;mov   dl,"d"                         ;display the decimal indicator
  ;int   21h  
                          
  pop   dx                             ;restore original registers
  pop   cx                
  pop   bx                
  pop   ax                
  ret                                  ;return caller
DECOUT   ENDP
end main