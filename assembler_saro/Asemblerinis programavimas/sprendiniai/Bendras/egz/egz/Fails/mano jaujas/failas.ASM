stekas segment stack                
  db 256 dup(?)                     
stekas ends                         
                                    
duomenys segment                    
     duom db 'Ana Bikevic II-3/3'
     path db 'c:\kursinis.txt'       
        h dw 0                      
duomenys ends                       
                                    
programa segment                    
        assume cs:programa,ds:duomenys,ss:stekas
start:                                
         mov ax,duomenys              
         mov ds,ax                  
                        
         ;create file                                                        
         mov ah,3ch                                               
         mov cx,0       ;cx=0 normal file                                        
         lea dx,path                                             
         int 21h                    
                        
         ;open file                           
         mov ah,3dh     
         mov al,2       ;al=2 for reading - writing            
         lea dx,path                
         int 21h    
                     
         mov h,ax       ;copy file handle        
                    
         ;write file                                                         
         mov ah,40h               
         mov bx,h       ;file handle           
         lea dx,duom    ;write to file
         mov cx,18      ;bytes to write
         int 21h        
                        
         ;close file                              
         mov ah,3eh                    
         mov bx,h           
         int 21h                                                      
                                                                 
                                                                 
                                                                 
         mov ah,07h                   
         int 21h                      
                                      
         mov ah,4ch                   
         int 21h                      
programa ends                         
 end start