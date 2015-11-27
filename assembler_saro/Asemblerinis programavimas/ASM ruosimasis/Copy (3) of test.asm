.MODEL SMALL
.STACK
.DATA

a db 3
b db 4
c db 5

.CODE

START:

PUSH '*'
PUSH 20
PUSH 10
CALL DrawBlockOfCharacters


mov ax, 0100h
int 21h

mov ax, 4c00h
int 21h

DrawBlockOfCharacters PROC
    ARG @@Height:WORD, @@Width:WORD, @@Character:BYTE = @@ArgBytesUsed
    LOCAL @@x:WORD, @@y:WORD = @@LocalBytesUsed

    PUSH BP                            ; Save BP
    MOV BP, SP                         ; Allow params. to be addressed
    SUB SP, @@LocalBytesUsed           ; Reserve space for local vars.

    ; Save affected registers and flags:
    PUSH AX
    PUSH DX
    PUSHF

    ; Let [@@y] = [@@Height]  (@@y is the outer loop counter):
    MOV AX, [@@Height]
    MOV [@@y], AX

@@RowLoop:

    ; Let [@@x] = [@@Width]  (@@x is the inner loop counter):
    MOV AX, [@@Width]
    MOV [@@x], AX

    @@ColumnLoop:

        ; Use INT 21h, Service 2 to output the character:
        MOV AH, 2
        MOV DL, [@@Character]
        INT 21h

        ; Decrement the inner loop counter:
        DEC [@@x]

        ; Has the inner loop counter reached zero yet?
        CMP [@@x], 0
        JNE @@ColumnLoop               ; ...if not, continue the loop.
        ; If it has reached zero, then the inner loop ends here.

    ; Using INT 21h, Service 2, output a CR and LF to move the cursor
    ; to the start of the next line:
    call NewLine
    
    ; Decrement the outer loop counter:
    DEC [@@y]

    ; Has the outer loop counter reached zero yet?
    CMP [@@y], 0
    JNE @@RowLoop                      ; ...if not, continue the loop.
    ; If it has reached zero, then the outer loop ends here.
    
    ; Restore the affected registers and flags:
    POPF
    POP DX
    POP AX

    ADD SP, @@LocalBytesUsed           ; "De-allocate" local variables'
                                       ;  space
    POP BP                             ; Restore BP
    RET @@ArgBytesUsed
DrawBlockOfCharacters ENDP

NewLine Proc
    MOV AH, 2
    MOV DL, 13                         ; ASCII 13 dec = carriage return
    INT 21h
    MOV DL, 10                         ; ASCII 10 dec = line feed
    INT 21h
    ret
NewLine EndP


END START



