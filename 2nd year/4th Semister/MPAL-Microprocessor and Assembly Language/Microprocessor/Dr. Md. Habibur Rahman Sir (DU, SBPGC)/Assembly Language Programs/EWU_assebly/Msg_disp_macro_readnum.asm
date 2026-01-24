; A program to display message n time in ;different lines

printf macro msg
       mov ah, 09h  ; display the message
       mov dx, offset msg
       int 21h
endm

readnum macro num   ; readnum macro to read a two-digit number
    mov ah, 01h
    int 21h         ; 01 DOS function call to read a character
    sub al, '0'     ; convert the ASCII char. into digit
    mov bh, 0ah
    mul bh          ; multiply the digit by 10
    mov num, al     ; save the result in num variable
    mov ah, 01h
    int 21h         ; read the value of digit in unit position
    sub al, '0'     ; convert the ASCII char. into digit
    add num, al     ; add the digit with num
endm

    
_DATA segment       ; DTATA segment starts here
    cr equ 0dh
    lf equ 10
    msg db cr,lf,'East West University','$'
    msg1 db cr,lf, 'Department of CSE','$'
    nwln db cr,lf,'$'
    N db ?
_DATA ends          ; end of DATA segment

_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax
       
       readnum N    ; read the value of N    
       mov cl, N    ; put the value of N into cl
       mov ch,0     ; put 0 into ch, to consiser cx as counter
       
 Reap:  printf msg  ; call printf macro to display msg
        printf msg1 ; call printf macro to display msg1
        printf nwln ; print new line 
        loop Reap   ; looping
       
       mov ah,4ch   ; terminate the program
       mov al, 00h
       int 21h
_CODE ends          ; end of CODE segment
      end start     ; end of start