;Uzrasas viduryje ekrano        
;----steko segmentas-----
stekas segment stack     
 	db 256 dup(?)    
stekas ends                                                                                                                                        
                         
cr equ 13                
lf equ 10                
                            
;----duomenu segmentas------
duomenys segment            
kvietimas db 'Iveskite pavarde, varda ir grupes nr. ',cr,lf,7,  '$'
rez db '', lf,'$'       
dal db 10                                                          
;masyvo isvedimas       
ats         db 253                                   
            db ?                                     
          db 255 dup (?),'$'  ;paliekama vieta duomenims
atv db 253 dup (?),'$'                                              
n db 3 dup (?),cr,lf,'$'                             
       	                                             	                                          	                                           
duomenys ends           
                                                                                                                                                   
;----programos segmentas----
programa segment                                                                                                                                   
 assume cs:programa, ds:duomenys, ss:stekas    
                                                   
;--ds paruosimas-----   
start: mov  ax,duomenys                            
      	mov ds,ax                                  
                                                   
;ekrano valymas              
mov ax,0002h              
int 10h                       
                                           
                                           
;ivedimas is ekrano                                
        mov ah,09h            
        lea dx,kvietimas                             
        int 21h                                    
                                                   
        mov ah,0ah          
        lea dx,ats                                                                 
        int 21h         
                        
;----simboliu skaiciavimas-------
mov ax,0                         
mov al, ats+1                    
cbw                           
mov cx,3                               
lea si, n+2             
                        
                        
                                       
c: div dal                                   
   add ah,30h           
   mov [si],ah                         
   dec si                              
   mov ah,0                            
   loop c               
;ekrano valymas         
mov ax,0600h            
mov bh,07               
mov cx,0000             
mov dx,184fh            
int 10h                 
;kursoriaus nukelimas                                
mov ah,02h                   
mov bh,0                
mov dh,12               
mov dl,25               
int 10h                      
                                                 
                                      
mov ax,0                                                                       
mov cl, ats+1           
mov ch, 0h                    
lea si,atv              
mov bx,1                
mov ah,0       	                                                                   
cikl:                                                                      
        add bx,1        
        mov al,ats[bx]  
        mov [si], al    
        inc si          
                        
        mov ah,0        
loop cikl               
                                                                
;---pranesim isvedimas------
                                                                                                                                            
mov ah, 09h             
lea dx,rez              
int 21h                 
       	                    
mov ah, 09h             
lea dx,atv              
int 21h                 
                        
                        
;---grizta i DOS----    
                        
mov ah,07h              
int 21h                     
mov ah,4ch                     
int 21h                        
programa ends                          
	end start 