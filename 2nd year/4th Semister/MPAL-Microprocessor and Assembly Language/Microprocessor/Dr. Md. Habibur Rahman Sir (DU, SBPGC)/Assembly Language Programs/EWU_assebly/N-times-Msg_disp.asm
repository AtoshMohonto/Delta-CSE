; A program to display message n time in ;different lines

_DATA segment
    cr equ 0dh
    lf equ 0ah
msg db cr,lf,'Fifth semester Final Examination$'
_DATA ends

_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov dx, ax
       
       mov cx, 0ah
       
 Reap: mov ah, 09h
       mov dx, offset msg
       int 21h
       loop Reap
       mov ah,4ch
       mov al, 00h
       int 21h
_CODE ends
      end start