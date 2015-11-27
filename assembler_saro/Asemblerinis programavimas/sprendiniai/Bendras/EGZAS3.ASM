;---------steko segmentas---------                                
stekas    segment stack                                           
          db 256 dup(0)                                           
stekas    ends                                                    
cr        equ 13                                                  
lf        equ 10                                                  
                                                                  
duomenys  segment                                                 
                                                                  
        a db +27  ,cr,lf,'$'
        b db -30 ,cr,lf,'$'    ; TARKIM JIS NEIGIAMAS......
        c db -2  ,cr,lf,'$'   
        d db 10                                               
        ElNr db 26 ,cr,lf,'$'  ; Mano eiles numeris grupeje 26
                                                                  
        Teigiamas db 'Gautas teigiamas skaicius',cr,lf,'$'        
        Neigiamas db 'Gautas neigiamas skaicius',cr,lf,'$'        
                                                                  
  pran  db 'Rolandas Sloveckas',cr,lf,'$'                         
  uzduotis db 'suskaiciuoti rezultata pagal formule (a+b+c)*ElNr',cr,lf,'$'
  rez db ?,cr,lf,'$'                                              
duomenys  ends                                                             
                                                                           
programa  segment                                                          
          assume cs:programa, ds:duomenys, ss:stekas                       
                                                                           
start:                                                        
          mov ax,0002h                                        
          int 10h                                             
                                                              
          mov ax,duomenys                                     
       	  mov ds,ax                                           
                                                              
          mov AH,9                                            
          lea DX,pran                                         
          int 21h                                             
                                                              
          mov AH,9                                            
          lea DX,uzduotis                                     
          int 21h                                             
;====================== Apskaiciuojam ========================                                                         
          ;--- Sudedam ------                                                                                     
          mov al,a                  
          mov bl,b                  
          mov cl,c                                                 
          add al,bl           
          add al,cl           
                              
          imul d              
          CMP ax,0            
          jl Neigiamas1       
                                                 
          ;--- Padauginam is eiles numerio -----         
          mul ElNr                                       
          mov rez,al                                     
                              
;================================================================
         ;----------- Isvedam 
Teigiamas1:                                              
          mov AH,9                                       
          add b,30h                                      
          lea DX,teigiamas                               
          int 21h                                        
          jmp pabaiga                                    
Neigiamas1:                                              
          mov AH,9                                       
          add b,30h                                      
          lea DX,neigiamas                               
          int 21h                                        
pabaiga:                                                 
	  mov ah, 07h 
          int 21h                                        
                                                         
          mov ah,4Ch                                     
	  int 21h                                        
                                                         
                                                         
programa  ends                                           
          end start                                      
