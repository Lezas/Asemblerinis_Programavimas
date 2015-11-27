;STEKO SEGMENTAS.                               
stek segment stack                              
        db 256 dup (?)                          
stek ends                                       
                                                
;DUOMENU SEGMENTAS                              
data segment                                    
        intro db 'Oleg Bystrov',13,10,'II-0/4',13,10,10,'$'
        rez db 'Vidurkis       :'               
        tmp db 10 dup(?)                        
         db 13,10,'$'        
        F db ?                                    
        l db ?                                    
                                                
        array   db 1, 'Jonaitis       ', 5,6,5,6,5,10,?
                db 2, 'Petraitis      ', 6,7,6,7,6,7,?
                db 3, 'Jonaityte      ', 9,9,9,9,9,7,?
                db 4, 'Petraityte     ', 8,10,8,10,8,10,?
                db '***'                           
                                                   
        sum db 0                                   
                                                   
        den db 5   ;Parodo, kiek dalyku yra
data ends                                          
                                                                                                                
code segment                                       
        assume cs:code,ds:data,ss:stek                     
start:                                                       
       	mov ax,data                                
       	mov ds,ax                                  
; isveda intro                        
        mov ax,0900h                  
        lea dx,intro                  
        int 21h                       
                                                   
        mov bx,16                                  
        xor ax,ax                     
        xor si,si                                      
        mov cx,5                                       
suma:                                                  
; ar ne pabaiga                                        
        cmp array[si],'*'                              
        jne next                                       
        cmp array[si+1],'*'                            
        jne next                                       
        cmp array[si+2],'*'                            
        je pre_finish                                  
        mov bx,16                                      
        mov cx,5                                       
                                                       
next:   add al,array[bx][si]                           
        inc bx                                         
   loop next                                           
                                                       
        add sum,al
        xor ah,ah                                      
                                                       
        div den                                        
        mov array[si+21],al                            
        mov array[si+22],ah                            
                                                       
        mov al,array[si+21]                            
        mov F,al                                       
        mov al,array[si+22]                            
        mov l,al                                       
                                                       
        add si,23                                      
        mov bx,16                                      
        mov cx,5                                       
        mov ax,0                                       
        jmp suma                                       
                                                       
pre_finish:                                            
        mov den,20                                     
        mov al,sum                                     
        div den                                        
        mov F,al                                       
        mov l,ah                                           
                                                       
        ;Rezultato isvedimas i ekrana                  
        call print_data                                
        mov ah,09h                                     
        lea dx,rez                                     
        int 21h                                        
                                                       
        ;Programos darbo nutraukimas                         
        mov ah,4ch                                     
       	int 21h                                                    
                                                       
print_data proc near                                   
        push si                                        
        mov si,9                                       
        mov bl,10                                      
        mov bh,5                                       
        mov al,F ;  turi buti sveikas sk               
                                                       
repeat:                                                
        mov ah,0                                       
        div bl                                         
        mov tmp[si-4],ah                                 
        add tmp[si-4],30h                                
        dec si                                         
        mov ah,0                                                                                              
        cmp ah,al                                      
jb repeat                                              
                                                       
        mov al,l                                       
        mov si,7                                       
        mov cx,3                                       
        mov tmp[6],2Eh                                 
                                                       
for_print:                                              
        mul bl                                         
        div den                                        
        add al,30h                                     
        mov tmp[si],al                                 
        mov al,ah                                      
        inc si                                         
loop for_print                                         
                                                       
pop si                                                 
ret                                                    
print_data endp                   	               
       	                                               
code ends                                              
                                                                    
end start                                                           
 	       		     	                       