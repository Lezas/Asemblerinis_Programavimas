STEKAS SEGMENT STACK
	db 256 dup(?)
STEKAS ENDS
duom SEGMENT
pran1 db 'Programa isveda simboliu eilute tiek kartu, koks yra vartotojo', 10, 13, '$'
pran2 db 'nurodytas skaicius. ', 10, 13, 10, 13, '$'
pran3 db 'IVESKITE SKAICIU:', 10, 13, 10, 13, '$'
pran4 db 10, 13, 10, 13, 'IVESKITE SIMBOLIU EILUTE:', 10, 13, 10, 13, '$'
pran5 db 10, 13, 10, 13, 'ISVEDIMAS:', 10, 13, 10, 13, '$'
ats db 79
db ?
db 79 dup (?), '$'
atv db 79 dup (?), 10, 13, '$'
a db 3 dup (?), '$'
sk db 0, '$'
daug db 10


duom ends
prog segment
assume cs: prog, ds: duom, ss: stekas
start:                               
mov ax, duom                         
mov ds, ax                           
                                     
;isvalo ekrana                       
mov ax, 0                            
mov ax, 0002h                        
int 10h                              
                                     
xor ax, ax                           
                                     
;trumpas paaiskinimas, ka daro programa
mov ah, 09h                          
lea dx, pran1                        
int 21h                              
lea dx, pran2                        
int 21h                              
;----------------                    
;ivedame duomenis                    
mov ah, 09h                          
lea dx, pran3                        
int 21h
sk_ivedimas:                         
mov si, 0
mov ah, 08h
lea dx, a
int 21h
;laukia kol paspausim enter
cmp al, 13
je toliau
                                     
cmp al, 30h
jb sk_ivedimas
cmp al, 39h
ja sk_ivedimas
                                     
mov dl, al
;veda po viena simboli
mov ah, 02h
int 21h
mov a[si], al
inc si
jmp sk_ivedimas
;********************
toliau:
xor al, al
mov si, 0
mov al, a[si]
sub al, 30h
mov sk, al
dec si
;xor al, al
mov al, a[si]
cmp a[si], ' '
jmp t
sub al, 30h
mul daug
add sk, al
;********************               
;toliau:
t:                              
mov ah, 09h                          
lea dx, pran4                        
int 21h                              
                                     
mov ah, 0ah                          
lea dx, ats                          
int 21h                              
;----------------                    
mov ah, 0                            
mov cl, ats+1                        
mov ch, 0h                           
lea si, atv                          
mov bx, 1                            
mov ah, 0
         
ciklas:  
add bx, 1
mov al, ats[bx] 
mov [si], al
inc si   
mov ah, 0
loop ciklas   
         
;isvedimas
mov ah, 09h
lea dx, pran5
int 21h  
isvedimas:
lea dx, atv
int 21h  
         
dec sk
cmp sk, 0
jg isvedimas

;sustabdo ekrana
mov ah, 07h
int 21h
;grazina i operacine sistema
mov ah, 4ch
int 21h

prog ends
end start