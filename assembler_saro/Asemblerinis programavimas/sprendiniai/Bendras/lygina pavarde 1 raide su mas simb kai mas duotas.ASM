stekas segment stack
db 256 dup (?)
stekas ends
duomenys segment
pran1 db 'Iveskite pavarde',13,10,7,'$' 
info db 15,15 dup (?),'$' 
m db 4 dup (?),'$'   
mas db 'maaaaseaaertabhiaaaasdvdvgbdfhddfvsvsnn'
praide db ?                    
d db 10 
k db 0                                 
atsakymas  db 'Masyve raidziu, kurios sutampa su pavardes pirmaja raide yra: $'
nerasta db 'Tokiu simboliu nerasta $'
kiek db 0
duomenys ends
programa segment
assume cs:programa, ds:duomenys, ss:stekas
start:
mov ax,duomenys
mov ds,ax
;isvalo	ekrana
mov ax,0002h
int 10h 

mov ah,09h                                
lea dx,pran1                               
int 21h

mov bx, 0		
mov ah, 0Ah	        
lea dx, info	        
int 21h  
     
mov al,info[2]
mov praide,al 
mov bx,0              
tikrinimas:              
mov al,mas[bx]
cmp praide,al 
je kiekis    
toliau:      
inc bx       
cmp bx,39   
je next      
jmp tikrinimas 

              
kiekis:   
inc kiek
jmp toliau

next:
cmp kiek,0
je nera  


;kiek skaitmenu
;mov bx,0 
mov k,0  
mov al,kiek
mov ah,0
kieksimb:    
div d      
inc k   
mov ah,0
cmp al,0 
ja kieksimb 
        
;vertimas
mov bl,k     
mov al,kiek
mov ah,0
cikl:   
div d   
add ah,30h
mov m[bx],ah 
mov ah,0    
dec bx  
cmp bx,0
ja cikl

 ;kordinates            
        mov ah,02              
        mov bh,00
        mov dh,4
        mov dl,2
        int 10h
  
mov ah,09h                                
lea dx,atsakymas
int 21h
      
 mov bx,1
isvedimas:  
  mov ah, 02h		
  mov dl,m[bx]	
  int 21h		                 
  inc bx
  mov al,k
  mov ah,0
  add ax,1   		
  cmp bx,ax 	
je endas 
jmp isvedimas            
                       
             
nera:        
mov ah,09h                                
lea dx,nerasta                               
int 21h
endas: 
mov ah,07h
int 21h
mov ah,4ch
int 21h       
  
         
programa ends
end start
