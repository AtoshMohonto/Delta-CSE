; this example shows the use of aaa instruction (ascii adjust after addition).
; it is used to add huge bcd numbers.

name "Loop"

org     100h

mov cx, 3
mov ax,0
next:   
add ax,cx
Loop next


; print the result:

; store contents of
; ax register:
mov     dx, ax

; print first digit:
mov     ah, 0eh
; convert to ascii:
or      dh, 30h
mov     al, dh
int     10h

; print second digit:
; convert to ascii:
or      dl, 30h
mov     al, dl
int     10h

; wait for any key press:
mov ah, 0
int 16h

ret  ; return control to operating system.




