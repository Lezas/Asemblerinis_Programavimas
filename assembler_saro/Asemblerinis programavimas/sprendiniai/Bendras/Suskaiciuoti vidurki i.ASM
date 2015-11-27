;Aprašyti masyva duomenu segmente.
; Suskaiciuoti vidurki ir rezultata atspausdinti ekrane 
;su tikslumu iki dvieju skaiciu po kablelio. 

 ;stek segment              
stek    segment stack      
          db 256 dup(?)    
stek    ends               
;data segment              
data    segment            
                 
        note db 'Labwork no 5',13,10
             db 'Done by Raimonda Stulgaite Fmu-2',13,10
             db '',13,10                 
             db '',13,10                 
             db 'Array: 2,5,4',13,10
             db '       5,6,7',13,10
             db '       8,9,3',13,10
             db 'Average: $',13,10       
        d    db 10,'$'                   
        m    db 9,'$'                    
        arr  db 3 dup(3 dup(2,5,4,5,6,7,8,9,3)),'$'     
        ans  db 4 dup(0),'$'             
data ends                                
;program segment                         
program segment                          
        assume cs:program, ds:data, ss:stek
                                           
start:  mov ax,data                      
        mov ds,ax                        
;cls                                     
    	mov ax,0002h                     
 	int 10h                          
;output of note                                
      	mov ah,09h                       
  	lea dx,note                      
 	int 21h                          
;calculations                            
                                         
        mov ax,0                         
        mov si,8                         
go:                                      
        add al,arr(si)                   
        dec si                           
        cmp si,0                         
        jnl go         ;jump not less                  
                                         
                 
                                       
        div m                          
        add al,30h                     
        mov ans[0],al                  
                                       
        mov al,2Ch        ;insert comma
        mov ans[1],al         
                              
        mov si,1              
        mov al,ah             
gogo:                         
        inc si                
        mul d                 
        div m                 
        add al,30h            
        mov ans[si],al        
        mov al,ah             
        cmp si,3              
        jne gogo      ;jump not equal        
                              
                                       
;output of result             
        mov ah,09h                     
        lea dx,ans            
        int 21h                         
                              
;keypress                              
  	mov ah,07h                     
  	int 21h                        
;DOS                                   
	mov ah,4ch                     
	int 21h     
                   
program ends                           
end start                              
                                       
                                       
                                       
                                       
                                       
                                       
                               
                               
                              
                              
