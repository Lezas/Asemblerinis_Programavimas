;Laboratorinis darbas Nr.1
;Atliko: Arunas Ciesiunas, II-1/5

;Uzduotis: "Teksto spausdinimas ekrane"

;Steko segmentas           
stekas segment stack
  db 256 dup(0) 
stekas ends

;Duomenu segmentas
duomenys segment 
  tekstas db "Laboratorinis darbas Nr. 1",10,13
          db "Uzduotis: Teksto spausdinimas ekrane",10,13
          db "Atliko: Arunas Ciesiunas, II-1/5",10,13,'$'
duomenys ends

;Programos segmentas
program segment
 assume cs:program, ds:duomenys, ss:stekas
 
 start:
  mov ax, duomenys
  mov ds, ax
  
;Ekrano isvalymas
  mov ax,0002h
  int 10h     

;Rodomas tekstas
  mov ah,09h                                       
  lea dx,tekstas  
  int 21h

;Laukiamas klaviso paspaudimas                                 
  mov ah, 07h                                      
  int 21h   

;Programos pabaiga
mov ax,4C00h                                               
int 21h
    
         
program ends
end start