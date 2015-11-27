;Cia komentaras       
deklas segment stack   
                       
       db 128 dup(0)   
deklas ends            
                        
duomenys segment       
         minus db "-$" 
         mat1 db 1, 15, 3
              db 2, 1, 1
              db 4, 1, 2
         mat2 db -1, 2, 3
              db 2, 1, 1
              db 1, 1, 1
         pranesimas db "Arturas Janulis II-08/1",10,13,'$'
         pranesimas2 db " ",'$'
         pranesimas3 db "Pirminis",'$'
         pranesimas4 db "Nei pirminis, nei sudetinis",'$'
duomenys ends           
programa segment        
ats proc       ;proc isveeda atsakyma. Vietoj jo aprasymo gale, sukuriau procedura, kuria iskvieciu per call funkcija      
mov al, ah              
add al, 48              
mov ah, 02h             
mov dl, al              
int 21h                 
ret                     
ats endp                
         assume cs:programa,ds:duomenys,ss:deklas
         start:         
         mov ax, duomenys
         mov ds, ax     
                        
         mov ah, 06h    
         ;al per kiek eiluciu stumsiu
         ;mov al 00h. Cia blogesne alternatyva "xor al al"  punktui
         mov bh, 07h                          
         xor al, al;Logines komandos dirba zymiai greiciau nei aritmetiniai procesai
         ;cx virsutinis kairysis kampas       
         xor cx, cx ;xor yra "isskirtine arba"
         ;dx apatinis desinysis kampas        
         mov dl, 79                           
         mov dh, 24                           
         int 10h ;bios pertraukimas           
                                              
         ;nuo eilutes pradzios pradeda            
         mov ah, 02h                          
         xor bh, bh                           
         mov dh, 0                            
         mov dl, 0                            
         int 10h                              
                                              
         mov ah, 09h                          
         lea dx, pranesimas                   
         int 21h                              
         mov cl, 10 ;ciklas visiems el
         mov di, 0 ;el sk                     
         mov bh, 0 ;skaitmenu sk                   
         atimu:                               
         mov ah, 09h                          
         lea dx, pranesimas2                  
         int 21h                              
                                              
         mov al, mat1[di]                     
         mov bl, mat2[di]                     
         inc di                               
         sub al, bl                           
         jns teigiama                         
         neigiama:                             
         neg al                               
         mov bl, al                           
         mov ah, 09h                          
         lea dx, minus                        
         int 21h                              
         mov ah, 0                            
         mov al, bl                           
         teigiama:                            
        ; mov ah, 02h                         
         ;add al, 48                          
         ;mov dl, al                          
         ;int 21h                             
         ;sub al, 48                          
         mov ah, 0                            
         mov bl, 10                           
         div bl                               
         push ax                              
         mov ah, 0                            
         inc bh                               
         cmp al, 0                            
         je traukti                           
         loop teigiama                        
         traukti:                             
         pop ax                               
         mov al, ah                           
         mov ah, 02h                          
         add al, 48 UşÿU‘şÿU’şÿV“şÿV”şÿW•şÿW–şÿW˜şÿX™şÿXšşÿX›şÿYœşÿYşÿYŸşÿZ şÿZ¡şÿ[£şÿ[¤şÿ[¥şÿ[§ÿÿ[¨ÿÿ[ªÿÿ\«ÿÿ\¬ÿÿ\®ÿÿ]¯ÿÿ]±ÿÿ^²ÿÿ^³ÿÿ^µÿÿ_¶ÿÿ_·ÿÿ_¸ÿÿ`¸ÿÿ`¸ÿÿa¸ÿÿa¸ÿÿa¸ÿÿb¸ÿÿb¸ÿÿb¸ÿÿc¹ÿÿc¹ÿÿc¹ÿÿd¹ÿÿd¹ÿÿe¯ÿÿ_›ÿÿHqÿÿ*Mÿÿ/ÿÿ/ÿß/ÿ0                                                                                                                                                                        /ÿŸ/ÿÿ
5ÿÿ;zşÿHŠşÿHŠşÿH‰şÿI‰şÿIˆşÿIˆşÿJˆşÿJˆşÿJ‡şÿK‡şÿK‡şÿL‡şÿL‡şÿL‡şÿM‡şÿM‡şÿMˆşÿNˆşÿN‰şÿN‰şÿN‰şÿOŠşÿO‹şÿO‹şÿPŒşÿPŒşÿPşÿPşÿQşÿQşÿR‘şÿR’şÿR“şÿS”şÿS•şÿS–şÿT—şÿT˜şÿT™şÿUšşÿUœşÿVşÿVşÿVŸşÿW¡şÿW¢şÿW£şÿW¥ÿÿW¦ÿÿW¨ÿÿX©ÿÿXªÿÿY¬ÿÿY­ÿÿY¯ÿÿZ°ÿÿZ±ÿÿZ³ÿÿ[´ÿÿ[µÿÿ\¶ÿÿ\¶ÿÿ\¶ÿÿ]¶ÿÿ]¶ÿÿ]¶ÿÿ^·ÿÿ^·ÿÿ^·ÿÿ_·ÿÿ_·ÿÿ`¸ÿÿ`¸ÿÿ`¸ÿÿa¸ÿÿa¸ÿÿa¸ÿÿb¸ÿÿb±ÿÿRÿÿ/ÿÿ/ÿß/ÿ                                                                                                                                                                        /ÿŸ/ÿÿ
5ÿÿ8yşÿD‰şÿE‰şÿEˆşÿEˆşÿF‡şÿF‡şÿG