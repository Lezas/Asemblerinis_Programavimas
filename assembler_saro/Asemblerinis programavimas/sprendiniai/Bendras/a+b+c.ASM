stekas segment stack
  db 256 dup(?)
stekas ends
cr equ 13
lf equ 10
                 
duomenys segment 
  pran1 db 'Skaiciuojama triju skaiciu suma a+b+c',cr,lf
        db 'skaiciai yra tokie: a=1,b=2,c=3',cr,lf,'$'
  pran2 db 'Suma = ',7,'$'
                    
  a db 1            
  b db 2            
  c db 3            
  sum db ?,'$'         
duomenys ends       
                    
prog segment        
  assume cs:prog, ds:duomenys, ss:stekas
strt:  mov ax,duomenys
  mov ds,ax         
  mov ah,09h        
  lea dx,pran1      
  int 21h           
  lea dx,pran2      
  int 21h           
  mov bh,a          
  add bh,b          
  add bh,c          
  add bh,30h        
  mov sum,bh        
  lea dx,sum        
  int 21h           
  mov ah,4ch        
  int 21h           
  prog ends         
end strt