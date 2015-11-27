stekas segment stack
       db 256 dup(0)
stekas ends
duomenys segment
         junginys db 80,?,80 dup(0),'$'         
         galutinis db 80 dup(0),'$'
         liekana db ?
         tarpas db ?
         kiek db ?
         atskyrejas db ?
         pran1 db 10,13,'Iveskite simboli-atskyreja',13,10,'$'
         pran2 db 'Iveskite simboliu eilute is spauskite ENTER',13,10,'$'
         pran3 db 10,13,'Zodziu skaicius: ','$'
         rezultatas db 'Gautas rezultatas:',13,10,'$'
         vienas DB 1
         sk db 1,'$' ;sk=1 nes jis skaiciuoja simbolius atskyrejus
	 n db 3 dup (?), '$' ;skaiciaus isvedimo masyvas
	 dal db 10 ;reikia dalint ta koda verciant ji i dvizenkli skaiciu
duomenys ends
programa segment
         assume cs: programa, ds:duomenys, ss:stekas
         start: mov ax,duomenys
                mov ds,ax             
;ekrano isvalymas
        mov ax,0002h
        int 10h        
                mov ah,09h
                lea dx,pran1
                int 21h                
                mov ah,08h      ;cia ivedi ta atskyreja
                int 21h                
                mov atskyrejas,al    ;cia ji priskiria kintamajam atskyrejas     
                mov ah,09h
                lea dx,pran2
                int 21h
                mov ah,0ah      ;cia ivedi simboliu eilute
                lea dx,junginys
                int 21h                

                mov cl,junginys+1 ;rodo kiek suksis ciklas 
                mov bl,atskyrejas ;i bl ikeli atskyreja
                atskyreju: mov al,[si] ;i al ikeli pirma ivesta simboli
                           cmp al,bl ; tikrina ar jis nera atskyrejas
                           jne toliau;jei ne eina toliau ima antra simboli
                           inc dl ;cia net nezinau kas tam dl yra bet kogero jo reikia vietoj atskyrejo paliekant tarpa
                           inc sk ;reiskia baigesi vienas zodis padidina sk 1
                           toliau: inc si
                loop atskyreju
;-----------------------------------
;cia ta koda kuris dabar yra sk pavercia i normalu skaiciu
xor ax,ax
mov al,sk
mov si, 2
;paverciame koda i skaiciu
skaicius:
div dal
add ah, 30h
mov n[si], ah ;ir ikelia i n, kuris yra masyvas is triju vietu 
dec si
mov ah, 0
cmp al, 0
je t
jmp skaicius
;----------------------------------
                t:            ;cia tai net nezinau labai gremezdiskas kodas
                mov kiek,dl ;pagal mane tai cia vietoj to atskyrejo iraso tarpa,
                cmp kiek,0  ;nustato kur butent isvesti ekrane ir isskaiciuoja tuos 
                je doss     ;vienodus tarpus tarp zodziu, nes auksciau tai to nepadaro.
                mov ax,0    ;kai pats to nedariau tai man sunku susigaudyt ka kur 
                mov al,junginys+1  ;padeda ikelia ir panasiai, 
                sub al,kiek    ;sorry issamiau negaliu paaiskint            
                mov bl,al
                mov al,80
                sub al,bl
                div kiek
                mov liekana,ah
                mov tarpas,al                
                mov dx,0
                lea si,junginys+2
                lea di,galutinis
                mov bl,kiek
                galut: mov al,[si]
                       cmp al,atskyrejas
                       jne forma
                       cmp bl,liekana
                       jne galu
                       mov bh,vienas
                       add bh,tarpas
                       mov tarpas,bh
                       galu: mov cx,0
                             mov cl,tarpas
                             mov al,' '                                                         
                             tarpass: inc di
                                      inc dl 
                                     mov [di],al                                  
                             loop tarpass
                             dec bl
                             jmp formaaa
                       forma: mov [di],al
                              inc dl ;------
                              inc di ;------
                       jmp formaaa                       
                       formaaa: inc si                                
                       cmp dl,79
                       jg pabaiga
                       jmp galut
                pabaiga:
                mov ah,02
                mov bh,00
                mov dh,10
                mov dl,31
                int 10h
                jmp dos
                doss: lea si,junginys+2
                      mov cx,0
                      mov cl,junginys+1
                      lea di,galutinis
                      ssss: mov al,[si]
                            mov [di],al
                            inc si
                            inc di
                      loop ssss
                      mov al,'$'
                      mov [di],al
		dos:
                mov ah,09h
                lea dx,rezultatas
                int 21h                
                mov ah,09h
                lea dx,galutinis
                int 21h
                
                mov ah,09h
                lea dx, pran3
                int 21h
                lea dx, n
                int 21h
                ;sustabdo ekrana                
                mov ah,07h
                int 21h
                ;grazina i ta melyna langa kur rasom koda
                mov ah,4ch
                int 21h
programa ends
end start                                 