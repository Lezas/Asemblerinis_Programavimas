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
         add al, 48 U���U���U���V���V���W���W���W���X���X���X���Y���Y���Y���Z���Z���[���[���[���[���[���[���\���\���\���]���]���^���^���^���_���_���_���`���`���a���a���a���b���b���b���c���c���c���d���d���e���_���Hq��*M��/��/��/�0                                                                                                                                                                        /��/��
5��;z��H���H���H���I���I���I���J���J���J���K���K���L���L���L���M���M���M���N���N���N���N���O���O���O���P���P���P���P���Q���Q���R���R���R���S���S���S���T���T���T���U���U���V���V���V���W���W���W���W���W���W���X���X���Y���Y���Y���Z���Z���Z���[���[���\���\���\���]���]���]���^���^���^���_���_���`���`���`���a���a���a���b���b���R���/��/��/�                                                                                                                                                                        /��/��
5��8y��D���E���E���E���F���F���G