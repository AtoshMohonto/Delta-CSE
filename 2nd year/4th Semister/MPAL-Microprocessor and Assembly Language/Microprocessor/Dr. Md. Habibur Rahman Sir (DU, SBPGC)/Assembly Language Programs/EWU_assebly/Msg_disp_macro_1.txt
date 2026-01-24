; A program to display message n times in different lines using macro

display macro msg			; display - user defined macro
	mov ah, 09h				; display string function
	mov dx, offset msg		; initialize dx to msg
	int 21h					; call DOS service
endm

_DATA segment               ; Data segment starts here
    cgr equ 0dh
    lnfd equ 10
msg db cgr,lnfd,'East West University','$'
msg1 db cgr,lnfd, 'Our first program','$'
_DATA ends                  ; End of Data segment

_CODE segment               ; Code segment starts here
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax
               
       mov cx, 100b         ; Value of N
       
 Reap: display msg          ; call display macro
       display msg1 
       loop Reap            ; looping
       
       mov ah,4ch           ; terminate the program
       mov al, 00h
       int 21h              ; end of CODE segment
_CODE ends
      end start             ; end of start