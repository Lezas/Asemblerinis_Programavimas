stekas segment stack                   
       db 256 dup (0)                  
stekas ends                            
duomenys segment                       
  vardas db 'Atliko Jaroslav Jakubovskij II-2/2' , 13,10,'$'
masyvas  db 'K','i','s','k','i','a','k','o','p','u','s','T','l','A','p','i','s','*' ,'$'   
           tarp  db ' ','$'                                                         
   a db ?,'$'
   b db '*'
   sept db 17
        duomenys ends                                                         
program segment                                                               
 assume cs:program, ds:duomenys, ss:stekas                                    
start:  
                                                                       
mov ax,0002h                                                                  
int 10h                                                                       
                                                                              
mov AX,duomenys                                                               
mov ds,ax               
mov bp,0                
ciklas3:                                
CMP masyvas[bp],'*'     
je arciau               
inc bp                  
loop ciklas3            
arciau:                 
mov ax,0                
mov al,00                                                                    
mov di,1                
mov bx,00               
mov si,0                
                        
ciklas:                 
mov cx,di               
ciklas2:                
CMP bx,bp
je toliau
mov al,masyvas+bx       
mov a,al                
mov ah,09h              
lea dx,a                
int 21h                 
add bx,1                
loop ciklas2            
lea dx,tarp       
int 21h                                                                       
inc di            
                  
loop ciklas       
                          
                                   
toliau:
mov ah,4ch                            
int 21h                                

 PROGRAM  ends
      end start
                             
                               
                               
                             
              	             
 