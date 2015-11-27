 stekas segment stack                                                     
  	db 256 dup(?)                                                     
stekas ENDS                                                               
                                                                          
duomenys segment                                                          
                                                                          
       	a db 5,?,5 dup (?)                                                 
       	b db 5,?,5 dup (?)                
       	a1 dw 0                           
       	b1 dw 0                           
        minusas db '-','$'                                                                 
     	des db 10                                                         
       	dess dw 10                                                        
       	simt dw  100                      
       	rez db 6 dup (?),"$"                                              
       	                                                                  
       	                                                                  
       	pran db "P. Anoskino II-1/3 gr. stud. " ,13,10                    
	     db "Asemblerinio programavimo" ,13,10                        
	     db "Egzamino uzduotis Nr 30", 13,10                          
      	     db "2004 01 20" , 13,10, "$"                                 
	                                                                  
      duomen db 13,10, "Programa turi skaiciuoti reiskinio c=a*b reiksme" 
	     db 13,10, "a ir b turi buti ivedami naudojant klaviatura, "           
	     db 13,10, "rezultatas atspausdinamas ekrane ",13,10, "$" 	         	                                                                   
      iveska db 13,10, "Iveskite reiksme  a: ",13,10, "$"               
      iveskb db 13,10, "Iveskite reiksme  b: ",13,10, "$"          	  
        atsa db 13,10, "Reiskinio c=a*b reiskme yra: c =  ", "$"                              
               	            	       	                                  
duomenys ENDS                                                             
                                                                          
programa segment                                                          
        assume cs:programa, ds:duomenys, ss:stekas                        
                                                                          
        start:                                                            
               mov ax, duomenys    ; duomenys                 
  	       mov ds, ax                                               
      	                                                                
      	       mov ax, 0002h       ; ekranas                    
      	       int 10h                                                  
      	                                                                
      	       mov ah, 09h         ;autorius
      	       lea dx, pran                                             
      	       int 21h                                                  
      	                                                                
      	       mov ah, 09h         ;salyga
      	       lea dx, duomen                                             
      	       int 21h                                                  
      	                                                    
              ; Pranesimas apie reiksmes a ivedima      	            
      	                                                                  
               mov ah, 09h                                  
               lea dx, iveska                                  
               int 21h       	                                                  
      	                                                                
               mov ah, 0ah         ;ivedima A reiksme        
               lea dx, a                                                
               int 21h                                                  
                                                                        
              ; a reiksmes apdorojimas                        
                                                            
               mov ax, 0                                                
               mov bx, 0                                                
               mov cx, 0                                                
                                                                        
               mov ch, 0      ; cx - skaitliukas                        
               mov cl, a+1                                                         
               lea dx, a+2                                              
               mov si, dx                                               
                                                                          
               mov bl,[si]    ;tikrina ar prieki yra minusas            
               cmp bl, 2Dh                                              
               je a_neigia                                                  
               jne a_teigia                                                 
                                                                        
          a_teigia:                                                         
                                                                        
               ciklasat:                                                  
                   mov bl, [si]                                         
                   sub bl, 30h                                          
                   add al, bl                                           
                   mul des                                              
                   inc si            ;didina si, 1             
               loop ciklasat                                       
                                                                        
                   div des                                                
                   mov bl, al      ; nauja reiksme       
                                                            
                   mov a1,bx        
                                                                          
                   jmp B_apdor                              
                                                                                          
          a_neigia:                                                         
                sub cx, 1                                               
                add si, 1                                               
                ciklasan:                                          
                    mov bl, [si]                                        
                    sub bl, 30h                                         
                    add al,bl                                           
                    mul des                                             
                    inc si          ;add si, 1                                           
                loop ciklasan                                      
                                                                        
                  div des                                               
                  mov bl, al            ; bx nauja reiksme              
                  neg bx                ; padaro neigiamu   
                                                            
                  mov a1,bx         
                                                            
                 jmp B_apdor                                              
                                                            
;cia baigiasi a reiksmes apdorojimas
                                                            
    B_apdor:                                                
                                                            
        ; Pranesimas apie B ivedima            	            
      	                                                    
               mov ah, 09h                                  
               lea dx, iveskb                                 
               int 21h       	                                                  
      	                                                                
               mov ah, 0ah         ;ivedima B reiksme       
               lea dx, b                                    
               int 21h                                                  
                                                                        
                   ; B reiksmes apdorojimas                 
                                    
               mov ax, 0                                    
               mov bx, 0                                                
               mov cx, 0                                                  
                                                                        
               mov ch, 0      ; cx - skaitliukas                        
               mov cl, b+1                                  
               lea dx, b+2                                  
               mov si, dx                                               
                                                                        
               mov bl,[si]    ;tikrina ar prieki yra minusas            
               cmp bl, 2Dh                                              
               je bneigia                                                  
               jne bteigia                                                 
                                                                        
          bteigia:                                                         
                                                                        
               ciklasbt:                               
                   mov bl, [si]                                         
                   sub bl, 30h                                          
                   add al, bl                                           
                   mul des                                              
                   inc si            ;add si, 1             
               loop ciklasbt                                         
                                                                        
                   div des                                                
                   mov bl, al      ; bx nauja reiksme       
                                                            
                   mov b1,bx        
                                                            
                   jmp skaic                                
                                                                                          
          bneigia:                                                         
                sub cx, 1                                               
                add si, 1                                               
                ciklasbn:                              
                    mov bl, [si]                                        
                    sub bl, 30h                                         
                    add al,bl                                           
                    mul des                                             
                    inc si          ;add si, 1                                           
                loop ciklasbn       
                                                                        
                  div des                                                 
                  mov bl, al            ; bx nauja reiksme              
                  neg bx                ; padaro neigiamu   
                                                            
                  mov b1,bx                                
                                                            
                 ;jmp skaic                                  
;baigiasi b reiksmes apdorojimas    
                                                            
   skaic:                                                   
       mov ax, 0                                            
       mov bx, 0                                            
       mov cx, 0                                            
       mov dx, 0                                            
                                                            
       mov ax,b1  ; b reiksme       
       mov bx,a1  ; a reiksme       
                                    
       imul bx                                                     
                                                           
   ; Vykdau atsakymo spausdinima    
                                                          
              mov dx, 0      ;nulinu dx                   
              mov bx, 0      ;nulinu bx                   
              mov cx, 0      ;nulinu cx                   
                                    
              cmp ax,0              
                                    
              jl maziau             
              jmp daugiau           
              maziau:               
              neg ax                
              jmp neigiamo          
              daugiau:                                            
              mov cx, 5                                   
              mov si, 5                                   
                                                          
              ciklasi:                                 
                   div dess       ; ax=sveik. d.  dx=liekan.
                   add dx, 30h      
                   mov rez[si], dl  
                   dec si                                 
                   mov dx, 0        
              loop ciklasi          
                                    
                                              
              mov ah, 09h           
              lea dx, atsa          
              int 21h               
                                    
              mov ah, 09h           ; spausdina atsakyma
              lea dx, rez           
              int 21h               
              jmp pabaiga           
              neigiamo:             
              mov cx, 5                                   
              mov si, 5                                   
                                                          
              ciklasi1:                                 
                   div dess       ; ax=sveik. d.  dx=liekan.
                   add dx, 30h      
                   mov rez[si], dl  
                   dec si                                 
                   mov dx, 0        
              loop ciklasi1         
                                    
                                              
              mov ah, 09h           
              lea dx, atsa          
              int 21h               
                                    
               mov ah,09h           
               lea dx,minusas       
               int 21h              
                                    
                                    
              mov ah, 09h           ; spausdina atsakyma
              lea dx, rez           
              int 21h               
                                    
             pabaiga: 
             mov ah, 07h
             int 21h                                                         
               mov ah, 4ch                                             
      	       int 21h                                                 
programa ENDS                                                          
end start                                                              
      