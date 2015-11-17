;-steko segmentasstekas
Stekas SEGMENT STACK
	DB 256 DUP(?)
Stekas ENDS

Data Segment
  str1 db 'Nebeprisikiskialiaudamas','$'  
  strlen1 dw $-str1
  strrev db 20 dup(' ')
Data Ends

Code Segment
  Assume cs:code, ds:data, ss:Stekas
  Begin:
    mov ax, data
    mov ds, ax
    mov es, ax
    mov cx, strlen1
    add cx, -2
    lea si, str1
    lea di, strrev
    add si, strlen1
    add si, -2
    L1:
       mov al, [si]
       mov [di], al
       dec si
       inc di
    loop L1
       mov al, [si]
       mov [di], al
       inc di
       mov dl, '$'
       mov [di], dl
    Print:
       mov ah, 09h
       lea dx, strrev
       int 21h
    Exit:
       mov ax, 4c00h
       int 21h
Code Ends
End Begin