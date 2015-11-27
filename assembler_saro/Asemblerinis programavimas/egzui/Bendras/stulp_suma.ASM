Stekas Segment Stack                                      
       	db 256 dup (?)                                    
Stekas ends                                               
                                                                                                        
Duomenys Segment                
pran db 'ivesk matrica: ','$'
pran1 db '  ','$'                                                       
pran5 db '',10,13,'$'                                                      
ivsr db 17,?,17 dup (0)                                
matrix db 15 dup ('*')
ilgis db 0         
du dw 2            
trys dw 3          
desimt db 10           
sumos db 3 dup (0),'$'
isv db 2 dup (0),'$'       
                                                                    
Duomenys ends                                                                                     
                                                                                                  
Programa Segment                                                                                  
       	Assume SS:Stekas, DS:Duomenys, CS:Programa                    
;===========PAPROGRAMES===================================================         	                                              
                                                        
;======================================================================                                                                                                                                                                                     
Start:                                                                                                 
       	MOV AX,Duomenys                                                                                
       	MOV DS,AX                                                                                      
     ;isvalau ekrana                                                                                   
        mov ax,0002h                                                                                         
        int 10h                                                           
                                                                          
        mov ah,09h                                                        
        lea dx,pran                                                       
        int 21h                 
        mov ah,09h                                                        
        lea dx,pran5                                                       
        int 21h       
                      
        mov ah,0ah    
        lea dx,ivsr   
        int 21h       
                      
        mov ah,ivsr+1 
        mov ilgis,ah  
                      
        mov cl,ilgis  
        mov di,du     
        mov bp,0      
pildymas:                   
        mov ah,ivsr[di]
        sub ah,30h       
        mov matrix[bp],ah
        inc di        
        inc bp        
        loop pildymas 
 ;matrix isvedimas   
       mov cx,5     
       mov di,0     
  isvedimas:                  
        push cx     
                    
        mov cx,3    
  isved:                  
        mov ah,matrix[di]
        add ah,30h   
        mov dl,ah   
        mov ah,02h  
        int 21h       
        mov ah,09h                                                        
        lea dx,pran1                                                       
        int 21h       
        inc di        
        loop isved        
                    
        mov ah,09h                                                        
        lea dx,pran5                                                       
        int 21h                  
        pop cx        
        loop isvedimas              
                        
    ;stulpeliu suma         
    mov di,0            
    mov bp,0            
    mov cx,3            
    sumos1:             
    mov ax,0            
       push cx          
    mov cx,5            
   suma:                
                           
        add al,matrix[di]  
        add di,trys     
        loop suma       
                        
        mov sumos[bp],al  
        inc di            
        inc bp            
        pop cx                 
        loop sumos1
             
             
             
             
        mov di,0             
        mov cx,3     
        spausdinu:   
        mov ax,0
        mov al,sumos[di]  
                     
        mov cx,2            
        mov si,1            
             spausd:        
        div desimt          
        add ah,30h          
        mov isv[si],ah            
              dec si        
        loop spausd 
          mov ah,09h                                                        
               lea dx,isv                                                       
               int 21h
                 mov ah,09h                                                        
               lea dx,pran1                                                       
               int 21h        
       inc di              
       loop spausdinu            
                                                                                              
;========================================================================                                                                         
                    
                                                                         
                    
;=====================================================================                                        
       	mov Ah,07h;kad lauktu klaviso paspaudimo                                                         
       	int 21h                                                             
       	MOV Ax,4C00h                                                        
      	INT 21h;nutraukia programa                                                   
;============================================================                                                                
Programa ENDS                                                              
END Start