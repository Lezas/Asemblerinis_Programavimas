;-----------------------Dimitrianas Kondrasovas---------------------------
;---Programa skaiciuojanti kiek yra eiluciu masyve kuriu pirmas elementas- 
;------------------------pasikartoja bent viena karta---------------------                     
stekas segment stack                                                      
db 256 dup (?)                                                            
stekas ends             
                                                              
duomenys segment                                                          
        vardas db 10,13,'Dimitrianas Kondrasovas II 1/3'               
               db 10,13,'Laboratorinis darbas Nr10 $'        
	Kartojimas  db 10,13,'Eiluciu kuriose kartojasi pirmas sibolis: $'
	StulpSk db 20   
	kiekis db 0, '$'    
	koks   db 0                                                  
       	                   
mas db 'ababbbbbbbbbbbbbbbbb'
    db 'bccbcccccccccccccccc'
    db 'cddddddddddddddddddc'
    db 'deeeeeeeeeeeeeeeeeee'
    db 'efffffffffffffffffff'                                      
    db 'fggggggggggggggggggg'                                      
    db 'ghhhhhhhhhhhhhhhhhhh'                                      
    db 'hjjjjjjjjjjjjjjjjjjj'                                      
    db 'jkkkkkkkkkkkkkkkkkkj'                                      
                                                                   
duomenys ends                                                      
programa segment                                                   
        assume cs:programa, ds:duomenys, ss:stekas                 
start:                                                             
    mov ax,duomenys                                                
    mov ds,ax                                                      
    ;valau ekrana                                                  
    mov ax, 0002h                                                  
    int 10h                                                        
    mov ah,09h                                                     
    lea dx,vardas                                                  
    int 21h                                                        
                                                                   
          ;di=stulpelio nr [1,2,3...]                              
          ;si=eilutes elementas[1,2,3,..]                          
          ;bx=di*20                                                
                                                                   
          mov di, 0          ; di -> 0                             
                                                                   
Starting: mov ax, di        ; di -> ax
          mul StulpSk        ; eilutes elementu kieki dauginam ish ax          
          mov bx, ax         ; rezultata talpinu i bx                                        
          mov dl,mas[bx]     ; pirma eilutes elementa talpinu i dl'a                        
          mov koks, dl       ; dl saugau i koks                                       
          mov si,0           ; uznulinu si                         
                                                                   
                tikrinu:                                           
                inc bx             ; bx = bx + 1                   
                mov cl, mas[bx]    ; eilutes elementa dedu i cl             
                cmp koks,cl        ; tikrinu pirma eilutes elementa su cl                            
                je suma            ; jei pirmas = kitam einu i suma                                      
                inc si             ; didinu si                               
                cmp si, 19         ; tikrinu ar si daugiau uz 19
                ja next            ; jei taip einu i next
                jmp tikrinu        ; jei ne einu i tikrinu                                
                                                                   
           next:                                                   
           cmp di, 8      ; lyginu di su stulpeliu kiekiu 8                                         
           je exit        ; jei lygu i exit, jei ne toliau                                         
           inc di         ; didinu di                                         
           jmp starting   ; einu i Newline
                                                                   
exit:                                                              
    mov ah,09h                                                     
    lea dx,kartojimas                                              
    int 21h                                                        
                                                                   
    add kiekis, 30h                                                
    mov ah, 09h                                                    
    lea dx, kiekis                                                 
    int 21h                                                        
                                                                    
    mov ah, 07h                                                    
    int 21h                                                        
    mov ah,4ch                                                     
    int 21h                                                        
                                                                   
suma:                                                              
inc kiekis                                                         
jmp next                                                           
                                                                   
programa ends                                                      
end start  