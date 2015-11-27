Stekas segment stack
        db 256 Dup(?)           
Stekas ends             
                        
Duom segment            
       ivedimas    db 10,13,"vedam beleka",10,13,"$"
       neivede     db 10,13,"cia tuscia","$"
       zodis       dw 10 dup(?),10,13,"$"
       sum db ?         
       sk db 0          
       a db ?           
       b db ?           
       aa db 10,13,'   tiek ivedei skaiciu', 2 dup(?),'$'
       bb db 10,13,'   tiek ivedei raidziu :P',2 dup(?),'$'                    
       ats1 db 10,13,'     visu skaiciu suma', 3 dup(?),'$'
       des  db 10
                                                           
Duom ends
                                                  
Program segment                                            
        assume cs:program, ds:duom, ss:Stekas              
start:                                                     
       mov ax, 0002h                                       
       int 10h                                             
                                                           
       mov ax, duom                                        
       mov ds,ax                                           
                                                           
       mov ah,09h
       lea dx,ivedimas
       int 21h
                                                           
isnaujo:                                                   
        mov zodis[0],10                                    
        mov ah,0ah                                         
        lea dx,zodis                                       
        int 21h                                            
        mov ax,zodis[1]                                    
        cmp al,0                                           
        je neivedete                                       
        mov a,al   ;tiek isviso simboliu
                                                           
gerai:                                                     
       xor si,si                                           
       mov cl,al                                           
       xor di,di                                           
       xor ax,ax                                           
       add si,2                                            
                                                           
ciklas:                                                    
       xor ax,ax                                           
       mov ax,zodis[si]                                    
       cmp al,30h                                          
       jge galskaicius                                     
       jmp kitas                                           
galskaicius:                                               
       cmp al,39h                                          
       jg kitas                                            
       jmp aha                                             
geras:                         
inc sk                                                    
       mov al,sum                                          
       add al,bl                                           
       mov sum,al                                          
kitas:                                                     
       inc si                                              
       loop ciklas                                         
       jmp pabaiga                                         
                                                                                      
aha:                                                       
xor bx,bx                                                  
       sub al,30h                                          
       mov bl,al                                           
       jmp geras                                           
                                                           
neivedete:                                                 
        mov ah,09h                                         
        lea dx,neivede                                     
        int 21h                                            
        jmp isnaujo                                   
                                                                                                                                                                                                                                                                                                                                                                      
pabaiga:       
       xor ax,ax         
       mov al,a
       sub al,sk
       mov si,2         
               ;<<<<<<<issigalvoja cia kazka plee:)
raides:                                            
       div des                                        
       add ah,30h                                     
       mov bb[si],ah                               
       dec si                                         
       mov ah,0                                       
       cmp al,0                                    
       je skaiciai                                 
       jmp raides                                  
skaiciai:                                          
       xor ax,ax                                   
       mov al,sk                                    
       mov si,2                                    
                                                   
skaiciai1:                                         
       div des                                        
       add ah,30h                                     
       mov aa[si],ah                               
       dec si                                         
       mov ah,0                                       
       cmp al,0                                    
       je next                                     
       jmp skaiciai1
      next:         
       xor ax,ax         
       mov al,sum        
       mov si,3          
       ciklass:                                       
       div des                                        
       add ah,30h                                     
       mov ats1[si],ah                                
       dec si                                         
       mov ah,0                                       
       cmp al,0                       
       je endas
       jmp ciklass       
      endas:
         mov ah, 09h                                    
       lea dx, aa
       int 21h   
                 
                   mov ah, 09h                                    
       lea dx, bb
       int 21h
          
          
          
                         
       mov ah, 09h                                    
       lea dx, ats1                                    
       int 21h           
                               
       mov ah,07h                   
       int 21h                      
       mov ah,4ch                   
       int 21h            
                                                
program ends              
end start                 
          