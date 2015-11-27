SSEG SEGMENT STACK
db 256 dup (?)              
ENDS SSEG                   

CR equ 13
LF equ 10                            

                            
DSEG SEGMENT                
Msg db  'Karoce...',CR,LF,'Antra eilute ir viskas.',CR,LF,'$'
ENDS DSEG                                      
                            
                                               
CSEG SEGMENT                                   
ASSUME ss:SSEG, ds:DSEG, cs:CSEG               
START:                                         
mov ax, DSEG
mov ds, ax 
mov ah, 09H
lea dx, Msg
int 21h
mov ah, 4Ch
int 21h
ENDS CSEG
END START
