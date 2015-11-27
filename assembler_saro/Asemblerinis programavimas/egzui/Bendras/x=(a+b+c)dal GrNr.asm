stek segment stack
db 256 dup(?)    
stek ends              
data segment 
    note db 'Laboratorinio darbo uzduotis Nr.6, Kristinos Peciukonytes,FMU-2 grupe.',10,13          
    note2 db 'Formule (a+b+c)/GrNr, a,b,c bet kokie skaiciai su zenklu ',13,10,'$'
    answ db '(10+(-3)+(-21))/4=','$'
    pran db 'Pranesimas: Rezultatas neigiamas!',13,10,'$'                                       
    min db ' -', '$'                                               
    a db 10                                                                   
    b db -3                          
    c db -21                         
    f db -1                                                                  
    GrNr db 7                        
    x db 10                          
    mas db 3 dup (?),13,10, '$'      
data ends                                                                     
prog  segment                                                                 
       assume cs:prog,ds:data,ss:stek                                                   
start:                                                                      
     mov ax, 02h                                                            
     int 10h                                                                
                                                                            
     mov ax,data     ;duomenu atspausdinimas                                                         
     mov ds,ax   
                         
     mov ah, 09h                     
     lea dx, note                    
     int 21h                                                        
                                                                           
     mov ah, 09h                     
     lea dx, answ                      
     int 21h 
                                                        
; Skaiciavimai                       
     mov al, 0                                                             
     mov si, 2                                                                                                                                  
     mov bl, a                                                                                                                           
     add bl, b                                                              
     add bl, c                                                              
     cbw                                                                   
     mov al, bl 
     js neig                      
     jns teig                                                                                                                                      
neig:                     
     mov ah, 09h          
     lea dx, min        
     int 21h   
     mov al, bl              
     imul f               
teig:                                                                         
     div GrNr                       
     cbw                                                                                                                          
; spausdinimas                  
print:   div x            
         mov mas[si], ah       
         add mas[si], 48       
         dec si                
         mov ah, 0                  
         cmp al, 0 
         je ats            
         jne print             
                     
ats:                   
     mov ah, 09h  
     lea dx, mas  
     int 21h                   
                           
     mov ah,09h                                                             
     lea dx, pran                                                             
     int 21h                         
                            
     mov ah, 07h     ; sustabdom ekrana
     int 21h         
                              
     mov ah,4ch      ; griztam i DOS'a    
     int 21h                    
                                          
prog ends       
end start                                     