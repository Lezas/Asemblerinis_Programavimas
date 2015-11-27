STEKAS SEGMENT STACK                                 
 	db 256 dup(?)                                
STEKAS ENDS                                          
duom SEGMENT                                         
                                                     
info db 10,13                                        
   db '     ********************************************************',10,13
   db '     * Kursinis darbas',10,13                             
   db '     * Uzduotis: Islygiuoti simboliu eilute pagal desni' ,10,13
   db '     *           krasta atskiriant tarpu vietoj akryrejo' ,10,13
   db '     * Atliko Darius Okunevicius II-2/6' ,10,13
   db '     ********************************************************',10,13,'$'    
                                                     
input1 db 10, 13, 'Iveskite atskyreja: ', '$'        
input2 db 10, 13, 'Iveskite simboliu eilute: ', '$'  
pran6 db 10, 13, 10, 13, 'Simboliu eilute: ', 10, 13, '$'
finish db 10,13, '->Programos pabaiga','$'   
ats db 79                                                                                             
                                               
atv db 79 dup (0), 10, 13, '$'                       
n db 3 dup (?), 10,13,'$'                            
simb db 0, '$'                                       
dal db 10                                            
sk db 0, '$'                                         
                                                     
duom ends                                           
prog segment                                        
assume cs: prog, ds: duom, ss: stekas               
start:                                              
mov ax, duom                                        
mov ds, ax                                          
                                               
mov ax, 0                                           
mov ax, 0002h                                  
int 10h                                                            
                                               
mov ah, 09h                                    
lea dx, info                                   
int 21h                                        
                                               
mov ah, 09h                                    
lea dx, input1                                 
int 21h                                        
                                               
mov ah, 08h                                    
int 21h                                        
mov simb, al                                   
              
mov dl, simb  
mov ah, 02h   
int 21h       
              
mov ah, 09h   
lea dx, input2 
int 21h       
              
mov ah, 0ah   
lea dx, ats   
int 21h       
              
mov ah, 0     
mov cl, ats+1 
mov ch, 0    
lea si, atv   
mov bx, 1     
mov ah, 0     
              
ciklas:       
add bx, 1     
mov al, ats[bx]
cmp al,simb   
je t          
jmp tt                 
t:            
mov al,0      
tt:           
mov [si], al           
inc si                 
inc sk                 
mov ah, 0              
loop ciklas            
            
xor al, al             
mov [si], al           
mov al, sk             
skaicius:              
div dal                
            
add ah, 30h            
mov n[si], ah          
dec si                 
mov ah, 0              
cmp al, 0              
jg skaicius            
          
isvedimas:             
mov ah, 09h   
lea dx, pran6 
int 21h       
;Pagal desini krasta
mov ah, 02h          
mov bx, 00    
mov dh, 11    
mov dl, 79    
sub dl, sk    
int 10h       
              
mov ah, 09h   
lea dx, atv   
int 21h      
              
mov ah, 09h                                    
lea dx, finish                                   
int 21h      
mov ah, 07h  
int 21h      
           
mov ah, 4ch  
int 21h      
             
prog ends    
end start