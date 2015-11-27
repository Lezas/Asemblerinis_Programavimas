Stekas segment stack                                 
db 256 dup (?)                                       
Stekas ends                                          
                          
duomenys segment                                     
pran1 db "Skirtumas lygus ",'$'
pran0 db "nuliui", '$'
pranminus db "-", '$'
                 
ten db 10        
                    
a db 5
b db 13
                    
duomenys ends       
                    
Programa segment                     
assume ss:Stekas, ds:duomenys, cs:Programa
start:           
                                   
MOV ax, duomenys ; duomenus segmentas
MOV ds, ax                           
                                     
MOV ax, 0002h    ; clear screenas
INT 10h                          
                                 
LEA dx, pran1    ; isvedam "Skirtumas lygus "                
MOV ah, 09h                                 
INT 21h                                     
                                            
MOV al, a         
SUB al, b        ; is a atimam b -> al                           
JZ zero          ; jei skirtumas = 0 sokam i zero
JNS teig         ; jei rezultatas > 0  sokam i teig
MOV bl, al       ; issisaugom bl'e rezultata                                  
LEA dx, pranminus; isvedam minuso zenkla                           
MOV ah, 09h                                 
INT 21h                                     
MOV al, bl       ; grazinam rezultata i al'a                           
NOT al           ; darom inversija neigiamam skaiciui
ADD al, 1        ; pridedam 1                               
                                     
teig:            
CMP al, 10       ; lyginam su 10
JL vien          ; jei maziau sokam i vien               
XOR ah, ah                                
DIV ten          ; dalinam is desimt    
PUSH ax          ; issisaugom ax
ADD al, 30h      ; pridedam 30h kad matytusi kodas               
MOV dl, al                                        
MOV ah, 02h      
INT 21h          
POP ax           
MOV al, ah       
                 
vien:            
ADD al, 30h      ; pridedam 30h kad gautumem zenklo koda                    
MOV dl, al                                              
MOV ah, 02h                  
INT 21h          ; isvedam rezultata            
JMP nextz        ; einam i pabaiga            
                                  
zero:                             
LEA dx, pran0    ; isvedam kad rezultatas lygus nuliui            
INT 21h                                               
                                                      
nextz:                                                
                                                      
XOR ax, ax       ; baigiam programa
MOV ah, 4ch                                           
INT 21h                                               
                                                      
Programa ends                                         
end start
