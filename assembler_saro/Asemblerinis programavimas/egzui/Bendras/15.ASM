stekas segment stack      
db 256 dup (?)                  
stekas ends               
                          
duomenys segment           
; skaiciaus ivedimas
Autorius db 10,13, '***Viktoja Briskmanaite, II-04/4***',10,13, '$'
pran db 10,13, '   Iveskite skaiciu: ','$'
skaitm db 5 dup(?),'$'
ten dw 10           
; skaicivimas  
prans db 13,10,'   Skaiciu suma: ','$'
sum dw 0 
duomenys ends                               
                    
programa segment                                
assume cs:programa,ds:duomenys,ss:stekas
                                             
start:                                         
mov ax,duomenys ;isikeliam duomenis i ax
mov ds,ax ; i ds uzkraunami duomenys
   	
;ekrano isvalymas       	  
mov ax,0002h        
int 10h  ; nustato kursoriu       	

;autoriaus isvedimas
lea dx, autorius
mov ah, 09h
int 21h

; uzd               
mov cx,5 ;pasirenkame kad leistu ivesti 5 elementus

nexts: 
push cx ;isimena info esancia cx'e
                    
lea dx,pran ;pranesimo isvedimas
mov ah,09h
int 21h
       	                      
mov cx,5 ;skaiciuje esamu skaitmenu kiekis
mov si,0 ;uznulinam si

ived:	
mov ah,08h
int 21h

;patikrinimas                          
cmp al,13        ;ar ne Enter
je skaic
cmp al,'0'       ;jei ne skaicius
jb ived          ;pakartot ivedima
cmp al,'9'
ja ived
                         
mov dl,al   
mov ah,0002h
int 21h
                          
sub al,'0'
mov skaitm[si],al
inc si  ;si padidinam vienetu
loop ived ;kartojamas ivedimo ciklas

skaic:                              
mov al, skaitm[0]     ;ax - pirmas skaitmuo
xor ah,ah ; uznulinam ah
                    
cmp si,1 ;lyginame
je suma
mov cx,si
sub cx,1  ; cx'a sumazina vienetu
mov si,1

skaic1:
mul ten 
mov dl,skaitm[si]                          
xor dh,dh                                  
add ax,dx          ;prie ax prirasem skaitmeni
inc si                                     
loop skaic1               
                    
suma:  
add sum,ax
pop cx  ; atstato cx registra    
loop nexts           
                    
mov ax,sum
; isvedam ax i ekrana kaip skaiciu (ax,cx,dx,si;skaitm,ten)
xor dx,dx
mov cx,5                      
next:   
div ten     
mov si,cx
add dl,'0' ; jei sito nebus tai neisvess atsakyme sk
mov skaitm[si-1],dl
xor dx,dx  ;uznulinam dx 
cmp ax,0000h 
loopne next ;jei nelygu, kartoja cikla next

nuliai: 
mov si,cx   
mov skaitm[si-1],' ' ; tarpai pries sk
loop nuliai      

;isvedimas
lea dx,prans 
mov ah,09h
int 21h        
lea dx,skaitm
mov ah,09h
int 21h
jmp pabaiga

pabaiga: 
mov ah,08h  ;parodo atsakyma
int 21h
mov ax,4C00h ;gryzta i programa
int 21h

programa ends                                                       
                                                                    
end start                                                           
       	       	     	     	                       
              