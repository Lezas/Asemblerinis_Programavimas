stekas segment stack    
      	db 256 dup(?)   
stekas ends             
                        
duomenys segment        
   pran db 'Koliokviumo darbas',10,13
        db 'Atliko Sigitas Maciulis ii-2/3',10,13
        db 'Uzduotis: yvesti zody 9 raidziu',10,13
        db 'Sukeisti 3-ia ir 7-ta raides',10,13,'$'
  pran1 db 10,'Yveskite zody:','$'              
  zodis db 10 dup(0),'$'
;    tmp db ' ',0,'$'   
;   tmp1 db ' ',0,'$'   
duomenys ends           
                        
programa segment        
                        
assume cs:programa, ds:duomenys, ss:stekas
start:                  
   mov ax, 0002h        
   int 10h              
                        
   mov ax, duomenys     
   mov ds, ax           
            
   xor ax,ax                        
   mov ah,09h           
   lea dx,pran          
   int 21h              
   
   mov ah,09h
   lea dx,pran1
   int 21h
                       
   mov ah,3fh       
   lea dx,zodis     
   int 21h          

   xor ax,ax
   mov ah,zodis+2
   mov al,zodis+6
   mov zodis+2,al
   mov zodis+6,ah
             
   mov ah,09h
   lea dx,zodis
   int 21h   
             
   mov ah,07h
   int 21h    
              
   mov ah, 4ch
   int 21h   

programa ends           
end start      
