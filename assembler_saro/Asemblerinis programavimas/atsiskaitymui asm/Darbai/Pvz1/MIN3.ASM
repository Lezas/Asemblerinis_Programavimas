; Minimali asemblerio programa
        .MODEL SMALL
        .STACK  100h
        .DATA
        
        .CODE
        ; Inicializuojam duomen÷
        ; segmento registr–
        mov     ax, @Data
        mov     ds, ax

        ; Programos kodas —ia


        ; I’eiti DOS funkcija
        mov     ah, 4Ch
        int     21h
        END
