;Var. I nr. 4
;programa papraso vartotoja ivesti skaiciu, ir isveda sio skaiciaus 
;skaitmenu vidurki                   
stek segment stack               
        db 256 dup (?)                            
stek ends                                         
                                                  
data segment                            
   vardas db 'atliko Saulius  Masiulis II-2/2 kursinio var I nr 4 ',10,13,'$'
      iv1 db 'iveskite skaiciu:','$'
      iv2 db 'Skaitmenu sumos vidurkis:','$'
     mas1 db 10,?,10 dup (?),'$'
      sum db ?,13,10, '$'
      kab db ',$'     
        a db ?        
        b db 10,?, 10 dup (?),'$' 
        des db 10               
        f db 2                  
        k db ?,'$'    
        x db ?,'$'              
data ends                                         
                                                     
program segment                                      
      assume cs:program, ds:data, ss:stek            
start:            
 mov ax,data      
 mov ds,ax        
                                
 mov ax,0002h ;isvalo ekrana
 int 10h                         
 mov ah,09h                      
 lea dx,vardas                   
 int 21h                         
 lea dx,iv1                      
 int 21h                         
;nuskaitoma skaiciu             
 mov ax,0                        
 mov ah,0Ah                      
 lea dx,mas1                     
 int 21h                         
                      
                                     
;kursorias perkelimas           
 mov ah,02        
 mov bh,00        
 mov dh,5         
 mov dl,20        
 int 10h          
 mov cl,mas1+1                   
 mov si,2                        
 mov al,0                        
 mov sum,0                       
 mov a,0                         
 mov ax,0                        
 ciklas:                         
  mov  bl,mas1[si]                
  sub bl,30h                     
  add al,bl       
  add si,1        
  add a,1         
 loop ciklas                     
 mov sum,al       
;divassss         
 mov ah,00        
 mov al,sum       
 div a            
 add al,30h       
 mov x, al        
 mov k, ah        
 mov ah,09h       
 lea dx,iv2       
 int 21h          
 lea dx ,x        
 int 21h          
; kablelis                      
 mov ah,09h       
 lea dx, kab      
 int 21h          
                                
                                
 mov si,2                               
 mov al,k         
 mov cl,8         
ciklas2:          
  mov k,00        
  mov ah,00       
  mul des         
  div a           
  add al,30h      
  mov b+si,al     
                  
  mov x,ah        
  mov al,x        
  inc si               
loop ciklas2                    
                                
 mov ah,09h       
 lea dx,b+2         
 int 21h                               
                                
      pabaiga:     
        mov ah,07h                        
        int 21h                           
                                          
        mov ah,4ch
        int 21h 
 program ends                              
end start
             