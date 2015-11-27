SSEG SEGMENT STACK   
db 256 dup (?)              
ENDS SSEG                   
                     
        CR equ 13            
        LF equ 10                            
                     
DSEG SEGMENT         
        a db 2
        b db 3
        c db 4        
        d db 5      
        dal db 0Ah
        strng db 4 dup(0),'$'
ENDS DSEG            
                     
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG 
                         
START:                   
        mov ax, DSEG 
        mov ds, ax   
        mov ax, 0002h 
        int 10h       
                     
        mov al, a   
        mov bl, b   
        add al, bl 
        mov bl, c  
        sub al, bl 
        mov bl, d  
        mul d  
        mov si, 4
               
darkart:         
        dec si
        mov ah, 00h                  
        div dal    
        add ah, 30h
        mov strng[si], ah
        cmp al, 0
        je isvedimas
        jne darkart               
              
isvedimas:    
        mov ah, 09h      
        lea dx, strng
        int 21h         
                        
        mov ah, 4Ch     
        int 21h         
ENDS CSEG               
END START               
