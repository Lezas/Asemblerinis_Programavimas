.model small                                   
.stack 100h                                    
                                               
.data                                          
atliko db 13, 10, 10, 'Atliko: Renatas Brazaitis',13,10
       db 'Grupe: II-0/4',13,10,10,'$'                 
txt db 'Rezultatas:'                           
tmp db 10 dup(?)        ;saugojamas galutinis rezultatas                                
 db 10,13,'$'                                           
F db ?                  ;saugojama sveikoji (reikalinga) dalis
l db ?                  ;saugojama (nereikalinga) liekana                                      
mas db 4, 'Skaiciai       ',55,4,8,12,10,?,?             
    db '*'                                               
suma db 0               ;pradine skaiciu suma                                 
daliklis db 5           ;masyvas is 5 skaitmenu                                 
                                                         
                                                
.code                                           
main proc                                                
       	mov ax,@data            ; duomenu segmento adreso uzkrovimas
       	mov ds,ax               ; i DS segmentini registra          
                                                   
       	mov ah,09h              ;spausdiname 'atliko'                   
       	lea dx,atliko                                           
       	int 21h                                                 
                                                                
        mov bx,16               ;reikalinga counteriui nuo kur pradeti
        mov ax,0                     
        mov si,0                                                
        mov cx,5                ;ciklas 5 kartus (5 skaiciu masyvas)
lp1:                                                                 
                                ;Masyvo pabaigos tikrinimas                                                        
        cmp mas[si],2Ah         ;lyginam su zavigzdutes simboliu                                     
        je pab                  ;einame i pabaiga                    
                                                                            
cont:                                                                
        add al,mas[bx][si]           
        inc bx                                                       
loop cont                      
                               
        add suma,al             ;al issaugom i suma                  
        mov ah,0                ;nuresetinam ah                   
                                                                     
        div daliklis            ;daliname is 5
        mov mas[si+21],al       ;sveika dali irasom i si+21                                     
        mov mas[si+22],ah       ;liekana irasom i si+22                                     
                                                                     
        mov al,mas[si+21]                                            
        mov F,al                ;F sveikoji dalis                                     
        mov al,mas[si+22]                                            
        mov l,al                ;l liekana                                     
                                                                                   
pab:                                                                 
        call isved                        
        mov ah,09h                        
        lea dx,txt                                     
        int 21h                                        
                                                       
        mov ah,4ch              ;programos pabaiga                       
       	int 21h                                                    
                                                       
isved proc near                                   
        push si                 ;issaugome si i steka
        mov si,9                                  
        mov bl,10                                 
        mov bh,5                                  
        mov al,F                                  
                                                  
lp2:                                              
        mov ah,0                                       
        div bl                        
        mov tmp[si-4],ah                                 
        add tmp[si-4],30h                                
        dec si                                         
        mov ah,0                                                                                              
        cmp ah,al                                      
jb lp2                                                 
        pop si                                         
        ret                                            
isved endp                   	                       
main endp                                              
end main       	                                       
       	       	   	     	                       
                                                       
                                      
